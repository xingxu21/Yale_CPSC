#include "malloc.h"
#include "process.h"

//global variables for stuff in the fields of the dmalloc_statistics struct
int NUM_TOT_ALLOCS     = 0; //total number of mallocs (including ones that were freed)
int NUM_ALLOCS         = 0; //number of active allocated sites
int FREE_SPACE         = 0; //size in bytes of the amount of space availiable in heap
int LARGEST_FREE_CHUNK = 0; //size in bytes of the largest free chunk currently availiable in the heap

//header containing metadata for each malloc
typedef struct malloc_header
{
    int size; //size of the payload
    int freed; //whether or not this memory location has been freed
    int valid; //whether this allocation is valid
    void* payload_start; //pointer to where the payload starts because i don't want to do arithmetic multiple times
} malloc_header;


typedef struct hml_node 
{
	struct hml_node* previous;
	struct hml_node* next;
	int size;
} hml_node;




///////////////////////////////////////////////////////////////////////////////////////////////
//MergeSort and support functions adapted from geeksforgeeks: https://www.geeksforgeeks.org/merge-sort-for-linked-list/
/* function prototypes */
struct hml_node* SortedMerge(struct hml_node* a, struct hml_node* b); 
void FrontBackSplit(struct hml_node* source, 
                    struct hml_node** frontRef, struct hml_node** backRef); 
  
/* sorts the linked list by changing next pointers (not data) */
void MergeSort(struct hml_node** headRef) 
{ 
    struct hml_node* head = *headRef; 
    struct hml_node* a; 
    struct hml_node* b; 
  
    /* Base case -- length 0 or 1 */
    if ((head == NULL) || (head->next == NULL)) { 
        return; 
    } 
  
    /* Split head into 'a' and 'b' sublists */
    FrontBackSplit(head, &a, &b); 
  
    /* Recursively sort the sublists */
    MergeSort(&a); 
    MergeSort(&b); 
  
    /* answer = merge the two sorted lists together */
    *headRef = SortedMerge(a, b); 
} 
  
/* See https:// www.geeksforgeeks.org/?p=3622 for details of this  
function */
struct hml_node* SortedMerge(struct hml_node* a, struct hml_node* b) 
{ 
    struct hml_node* result = NULL; 
  
    /* Base cases */
    if (a == NULL) 
        return (b); 
    else if (b == NULL) 
        return (a); 
  
    /* Pick either a or b, and recur */
    if (a->size >= b->size) { 
        result = a; 
        result->next = SortedMerge(a->next, b); 
    } 
    else { 
        result = b; 
        result->next = SortedMerge(a, b->next); 
    } 
    return (result); 
} 
  
/* UTILITY FUNCTIONS */
/* Split the nodes of the given list into front and back halves, 
    and return the two lists using the reference parameters. 
    If the length is odd, the extra node should go in the front list. 
    Uses the fast/slow pointer strategy. */
void FrontBackSplit(struct hml_node* source, 
                    struct hml_node** frontRef, struct hml_node** backRef) 
{ 
    struct hml_node* fast; 
    struct hml_node* slow; 
    slow = source; 
    fast = source->next; 
  
    /* Advance 'fast' two nodes, and advance 'slow' one node */
    while (fast != NULL) { 
        fast = fast->next; 
        if (fast != NULL) { 
            slow = slow->next; 
            fast = fast->next; 
        } 
    } 
  
    /* 'slow' is before the midpoint in the list, so split it in two 
    at that point. */
    *frontRef = source; 
    *backRef = slow->next; 
    slow->next = NULL; 
} 
  

/////////////////////////////////////////////////////////////////////////////////////////////////////

hml_node* list_head;
hml_node* list_tail;

// TODO: Implement these functions
void * malloc(uint64_t sz){ //pointer returned should be aligned to 16 bytes just FYI
	if (NUM_TOT_ALLOCS == 0) //this is the first malloc call so we need to set up the linked list
	{
		void* sys_sbrk_return = sys_sbrk(sizeof(hml_node));
		if (sys_sbrk_return == (void*) -1)
		{
			return NULL;
		}

		list_head = (hml_node*) sys_sbrk_return;
		list_tail = list_head;
		list_head->previous = NULL;
		list_head->next = NULL;
		list_head->size = 0;
	}

	if (sz == 0) //malloc of size zero returns null. 
	{
		return NULL;
	}

	//now we will implement all the malloc stuff. Two cases. First we iterate though the linked list and see if we can't find a free slot. 
	hml_node* current_node = list_head;

	while ((uint64_t)current_node->size < sz){ //iterate though the linked list
		if (current_node->next != NULL)
		{
			current_node = current_node->next;
		}

		if (current_node->next == NULL) //couldn't find one that is big enough and we reached the tail of the list. allocate a new tail and link it up
		{
			void* sys_sbrk_return = sys_sbrk(ROUNDDOWN(sizeof(hml_node) + sz, PAGESIZE));
			if (sys_sbrk_return == (void*) -1)
			{
				//sbrk failed so we need to return NULL
				return NULL;
			}

			hml_node* tail = (hml_node*) sys_sbrk_return;
			tail->previous = current_node;
			tail->next = NULL;
			tail->size = sz;

			current_node->next = tail;
			current_node = tail;
			list_tail = tail;
		}
	}

	//current_node should be big enough to hold the stuff we want for malloc.
	//now we have checked for errors. we will remove the tail node, and put a malloc header in there!
	//also make sure to keep track stuff for our global variables.
	NUM_ALLOCS++;
	NUM_TOT_ALLOCS++;

	//splice out current_node form the linked list
	current_node->previous->next = current_node->next;
	current_node->next->previous = current_node->previous;

	//if the current node was the head of the list, we gotta do some stuff
	if (current_node->next->previous == NULL)//current node was the head of the list and now current_node->next is the new head
	{
		list_head = current_node->next;
	}

	//if current_node->next is not NULL, that means we may have a chunk of memory left over at the very end. Also we need to check to see if the letover space is even large enough for a hml_header. If not, we just give the left over memory to malloc anyway
	uint64_t left_over_memory = 0;
	uint64_t tiny_left_over_memory=0;

	if (current_node->next != NULL)
	{
		left_over_memory = current_node->size + sizeof(hml_node) - (sizeof(malloc_header) + sz);

		if (left_over_memory < sizeof(hml_node))//if the leftover memory is not big enough for a hml_node, just give it to the malloc
		{
			tiny_left_over_memory = left_over_memory;
		}

		else {// the left over memory is pretty big so we create a new hml node after the malloc header and sz bytes
			hml_node* new_tail = (hml_node*) ((uintptr_t)current_node + (sizeof(malloc_header)) + sz);
			list_tail->next = new_tail;
			new_tail->previous = list_tail;
			new_tail->next = NULL;
			new_tail->size = left_over_memory - sizeof(hml_node);

			list_tail = new_tail;
		}
	}

	if (current_node->next == NULL && (uintptr_t)list_tail < (uintptr_t)current_node)//case where we need to make the previous node the tail
	{
		current_node->previous->next = NULL;
		list_tail = current_node->previous;
	}

	//cast the goop into a malloc_header
	malloc_header* malloced_space = (malloc_header*) current_node;
	malloced_space->size = sz + tiny_left_over_memory;
	malloced_space->freed = 0;
	malloced_space->valid = 1;
	malloced_space->payload_start = (void*) ((uintptr_t)malloced_space + sizeof(malloc_header));

	//return the pointer
	/*if ((uintptr_t)malloced_space->payload_start >= (uintptr_t)0x2FE000)
	{
		return NULL;
	}*/
	return malloced_space->payload_start;
}



void * calloc(uint64_t num, uint64_t sz){
	if (sz == 0 || num == 0) //if num or sz is equal to 0, then calloc returns NULL
	{
		return NULL;
	}

    void* ptr = malloc(sz*num);
    memset(ptr, 0, num*sz);
    return ptr;
}


void free(void * ptr){
	if (ptr == NULL) // if ptr == NULL, then no operation happens
	{
		return;
	}

	malloc_header* pointer_of_interest = (malloc_header*) ((uintptr_t)ptr - sizeof(malloc_header));

	if (pointer_of_interest->freed == 1 || pointer_of_interest ->valid != 1) //check for double free and whether the pointer has actually been malloced. In either case, return.
	{
		return;
	}

	else
	{ //valid malloc that has not been freed.  
		//update metadata
		NUM_ALLOCS -=1;

		//set the fields of the malloc header
		pointer_of_interest->freed = 1;
		pointer_of_interest ->valid = 0;

		int size = pointer_of_interest->size;
		//free the malloc by adding it back into the list of free spaces. 



		hml_node* new_tail;
		new_tail = (hml_node*) pointer_of_interest;
		new_tail->size = (sizeof(malloc_header) + size) - sizeof(hml_node);
		new_tail->previous = list_tail;
		new_tail->next = NULL;
		list_tail->next = new_tail;
		list_tail = new_tail;
	}
}



void * realloc(void * ptr, uint64_t sz){
	if (ptr == NULL) // if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
	{
		ptr = malloc(sz);
		return ptr;
	}

	if (sz == 0) //if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
	{
		free(ptr);
		return NULL;
	}

	malloc_header* pointer_of_interest = (malloc_header*) ((uintptr_t) ptr - sizeof(malloc_header));

	if (pointer_of_interest->valid != 1 || pointer_of_interest->freed == 1) //check for free and whether the pointer has actually been malloced. In either case, return null pointer.
	{
		return NULL;
	}

	//the realloc seems to be valid
	//two cases, realloc to a smaller
	if (sz < (uint64_t) pointer_of_interest->size){
    	void* new_pointer = malloc(sz);
    	memcpy(new_pointer, pointer_of_interest->payload_start, sz);

    	free(ptr);

    	return new_pointer;
    }

	//or realloc to a bigger space
	else if (sz >= (uint64_t) pointer_of_interest->size){
    	void* new_pointer = malloc(sz);
    	memcpy(new_pointer, pointer_of_interest->payload_start, pointer_of_interest->size);

    	free(ptr);

    	return new_pointer;
    }

    else{
    	return NULL;
    }

}



void defrag(){
	hml_node* current;
	current = list_head;

	while(current != NULL){//see if two parts of the linked list are adjacent. If so, splice the second elsement out of the linked list and increase the size of the first element. Beware: The new size of the first element will include the orig size of first element, size of hml_header, and size of second element. Additonally, make sure to update the next pointer of the element and the previous pointer of the new second element.
	if ((uintptr_t)current->next == (uintptr_t)current + sizeof(hml_node) + current->size)
	 {
	 	current->size += (current->next->size + sizeof(hml_node));
	 	current->next = current->next->next;
	 	current->next->next->previous = current;
	 }

	 //also do something similar but with checking previous
	 if ((uintptr_t)current->previous == (uintptr_t)current - sizeof(hml_node) - current->previous->size)
	  {
	  	current->previous->size += (current->size + sizeof(hml_node));
	  	current->next->previous = current->previous;
	  	current->previous->next = current->next;
	  } 

	 	current = current->next;
	}
	return;
}

int heap_info(heap_info_struct * info){
	if (info == NULL)
	{
		return -1;
	}

	info->num_allocs = NUM_ALLOCS;

	//allocate space for struct and for the two arrays;  
	long* size_array = malloc(sizeof(long)*NUM_ALLOCS);
	void** ptr_array = malloc(sizeof(void*)*NUM_ALLOCS);

	//use mergesort on linked list. 
	hml_node** pointer_to_head;
	pointer_to_head = &list_head;

	MergeSort(pointer_to_head);

	if (info == NULL || size_array == NULL || ptr_array == NULL)//unable to allocate space for any of the fields or for the struct itself
	{
		return -1;
	}


	hml_node* current = list_head;
	int count = 0;
	int sum = 0;
	while(current != NULL){
		size_array[count] = current->size;
		ptr_array[count] = current;
		sum += current->size;
		count++;
		current = current->next;
	}
	info->size_array = size_array;
	info->ptr_array = ptr_array;
	info->free_space = sum;
	info->largest_free_chunk = size_array[0];
    return 0;
}






