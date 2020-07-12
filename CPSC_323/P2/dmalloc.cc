#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>
#include <climits>
#include <iostream> 
#include <unordered_map> 
#include <vector>
#include <algorithm>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)

//global variables for stuff in the fields of the dmalloc_statistics struct
unsigned long long nactive     = 0;              // # active allocations
unsigned long long active_size = 0;              // # bytes in active allocations
unsigned long long ntotal      = 0;              // # total allocations
unsigned long long total_size  = 0;              // # bytes in total allocations
unsigned long long nfail       = 0;              // # failed allocation attempts
unsigned long long fail_size   = 0;              // # bytes in failed alloc attempts
uintptr_t heap_min             = UINTPTR_MAX;    // smallest allocated addr
uintptr_t heap_max             = 0;              //maximum allocated addr

//header containing metadata for each malloc
typedef struct header
{
    int size; //size of the payload
    int freed; //whether or not this memory location has been freed
    int canary; //whether or not the thing has been overwritten
    char buffer[300]; //buffer for overwritten stuff
    const char* filename; //name of the file containing the code doing the malloc
    long linenumber;//line number we were at when malloc happend
} header;


//footer is a buffer in case stuff gets written past the end of the array
typedef struct footer
{
    char buffer[300]; //buffer in case we write past the allocated memory
} footer;


//hash table containing all of the calls to malloc, keeyed with the call#, entries contain memory addresss
using namespace std;
unordered_map<int, void*> malloc_calls;
unordered_map<string,size_t> hh_hash;


/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.

    //if file is null 
    if (file == NULL)
    {
        nfail += 1;
        return NULL;
    }

    //use base_malloc to allocate a pointer (after checking that it isn't too big)
    if (sz + sizeof(header) + sizeof(footer) >= INT_MAX || sz >= INT_MAX)
    {
        nfail += 1;
        fail_size += sz;
        return NULL;
    }

    void* ptr = base_malloc(sz + sizeof(header) + sizeof(footer));

    //if the allocation failed
    if (ptr == NULL)
    {
        //book-keeping
        nfail += 1;
        fail_size += sz;

        return NULL;
    }

    //if the allocation did not fail
    else{
        //book-keeping
        nactive += 1;
        active_size += sz;
        ntotal += 1;
        total_size += sz;

        //checking if need to update heap max/min and updating if needed
        if ((uintptr_t)ptr + sizeof(header) < heap_min)
        {
            heap_min = (uintptr_t)(ptr) + sizeof(header);
        }

        if (((uintptr_t)(ptr) + sz + sizeof(header)) > heap_max)
        {
            heap_max = (uintptr_t)(ptr) + sz + sizeof(header);
        }


        //metadata header
        header* head = (header*) ptr;
        head->size = sz;
        head->freed = 0;
        head->canary = 1;
        head->filename = file;
        head->linenumber = line;

        for (int i = 0; i < 300; ++i)
        {
            head->buffer[i] = 'a';
        }


        //metadata footer
        footer* foot = (footer*) ((uintptr_t)(head) + sizeof(header) + sz);

        for (int i = 0; i < 300; ++i)
        {
            foot->buffer[i] = 'a';
        }

       //return value: returns pointer to the payload and put it into our malloc_calls hash table
        void* payload = (void*)((uintptr_t)head + sizeof(header));
        malloc_calls[ntotal] = payload;

        char line_buffer[300];
        snprintf(line_buffer, 300, "%ld", line);
        int len = strlen(file);
        char key[300 + len + 1];
        strcpy(key, file);
        strcat(key, ":");
        strcat(key, (const char*)line_buffer);
        auto search = hh_hash.find(key);
        if (search != hh_hash.end())
        {
            size_t temp = search->second;
            temp += sz;
            search->second = temp;
        }

        else
        {
            hh_hash[key] = sz;
        }

        return payload;
    }
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.
    if (file == NULL)
    {
        return;
    }


    //file is not null. 
    //if ptr is null, do nothing
    else if (ptr == NULL)
    {
        return;
    }

    //if ptr is not null
    else 
    {
        //check if ptr points to previously malloced space.
        if ((uintptr_t)ptr > heap_max || (uintptr_t)ptr < heap_min)
        {
            fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not in heap\n", file, line, ptr);
            abort();
        }

        //checking allignment. if the pointer is not correctly alligned, obviously it wasn't allocated
            if ((uintptr_t)ptr % 8 != 0)
            {
                fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", file, line, ptr);
                abort();
            }

        //first we get some pointers to header and footer
        header* head = (header*)((uintptr_t) ptr - sizeof(header));
        footer* foot = (footer*)((uintptr_t) ptr + head->size);

        //check if double free
        if (head->freed == 1)
        {   
            fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, double free\n", file, line, ptr);
            abort();
        }


        //check if metadata overwritten
        if (head->canary != 1)
        {
            fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", file, line, ptr);

            //check if trying to free something that is in the middle of an allocated section of memory
            unordered_map<int, void*>:: iterator it;
            for (it = malloc_calls.begin(); it != malloc_calls.end(); ++it)
            {
                header* head1 = (header*)((uintptr_t)it->second - sizeof(header));
                void* payload1 = it->second;
                uintptr_t p = (uintptr_t)ptr;

                uintptr_t start = (uintptr_t)payload1;
                uintptr_t end = (uintptr_t)payload1 + head1->size;

                if (p > start && p < end)
                {
                    fprintf(stderr, "  %s:%ld: %p is %ld bytes inside a %d byte region allocated here\n", head1->filename, head1->linenumber,  (void*)ptr, p - start, head1->size);
                    abort();
                }
            }
            abort();
        }

        //check if buffer overwritten
        for (int i = 0; i < 300; ++i)
        {
            if (foot->buffer[i] != 'a' || head->buffer[i] != 'a')
            {
                //write error message
                fprintf(stderr, "MEMORY BUG: %s:%ld: detected wild write during free of pointer %p\n", file, line, ptr);
                abort();
            }
        }
    }

    //get pointer to head
    long payloadptr  = (uintptr_t) ptr;
    header* head = (header*)(payloadptr - sizeof(header));

    //book-keeping
    nactive -= 1;
    active_size -= head->size;

    //free the allocated block of memory
    head->freed = 1;
    base_free(head);
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
    // Your code here (to fix test014).
    if (nmemb > INT_MAX || sz > INT_MAX || sz*nmemb > INT_MAX)
    {
        nfail += 1;
        fail_size += sz;
        return NULL;
    }

    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr != NULL) {
        memset(ptr, 0, nmemb * sz);
    } 
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
    // Your code here.
    stats->nactive     = nactive;
    stats->active_size = active_size;
    stats->ntotal      = ntotal;
    stats->total_size  = total_size;
    stats->nfail       = nfail;
    stats->fail_size   = fail_size;
    stats->heap_min    = heap_min;
    stats->heap_max    = heap_max;
}



/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
    // Your code here.
    //check if trying to free something that is in the middle of an allocated section of memory
    unordered_map<int, void*>:: iterator it;
    for (it = malloc_calls.begin(); it != malloc_calls.end(); ++it)
    {
        header* head = (header*)((uintptr_t)it->second - sizeof(header));

        if (head->freed != 1)
        {
            printf("LEAK CHECK: %s:%ld: allocated object %p with size %d\n", head->filename, head->linenumber, (void*)it->second, head->size);
        }
    }

}


//comparison function
bool comparesize(const pair<string, size_t> &a, const pair<string,size_t> &b)
{
    return (a.second > b.second);
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

//collapse everything in heavy hitters hash table into a vector, sort it and print out things that are greater than 20 percent.
void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
    vector<pair<string,size_t>> vec;
    vec.assign(hh_hash.begin(), hh_hash.end());
    sort(vec.begin(), vec.end(), comparesize);
    int printed = 0;
    for (vector<pair<string,size_t>>::iterator iit = vec.begin(); iit != vec.end(); iit++)
    {
        if (iit->second > 0.2*total_size || printed < 3)
        {
            double percent = (((double)iit->second)/((double)total_size))*100;
            printf("HEAVY HITTER: %s: %ld bytes (~%0.1lf%%)\n", iit->first.c_str(), iit->second, percent);
            printed++;
        }
    }
}
