#include <stdbool.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "location.h"


/**
 * A set of Cartesian coordinates implemented using a k-d tree, where k = 2.
 */
//basically linked list except each element of the list is linked to two elements (the children). Each node is distinct struct of type kdtree. Basically recursively defined kdtree_node with base cases: defined a node as a kdtree_node and a node with two child nodes as kdtree. 

typedef struct node {
	bool xaxis;							//keeps track of what the cutting axis is
	location coordinates;				//the actual value of the coordinates
	struct node *parent;                //null if the node is the root of the tree
	struct node *leftchild;				//null if the node is a leaf
	struct node *rightchild;			//null if the node is a leaf
} kdtree_node;


typedef struct _kdtreek {
	kdtree_node *root;
} kdtree;


//function prototype for mergesort
mergeSort(int n, const location a[], location out[], bool xory);
void helper_for_create(kdtree_node *current_node, kdtree_node *parent, int n, location *x_array, location *y_array, xaxis);
location median_and_arrays(location listofx[], location listofy[],
	int n, bool xaxis,
	location x_array_left[], location x_array_right[],
	location y_array_left[], location y_array_right[]);

/**
 * Creates a balanced k-d tree containing copies of the points in the
 * given array of locations.  If the array is NULL and n is 0 then the
 * returned tree is empty.  If the tree could not be created then the
 * returned value is NULL.
 *
 * @param pts an array of unique valid locations, non-NULL if n != 0
 * @param n the number of points in that array, or 0 if pts is NULL
 * @return a pointer to the newly created collection of points, or NULL
 * if it could not be created
 */
kdtree *kdtree_create(const location *pts, int n){
	printf("kdtree_create has been called\n");

	//if we have n=0, then must create an empty tree. 
	if (n == 0)
	{
		kdtree *pointer;
		pointer = malloc(sizeof(kdtree));

		if (pointer->root == NULL)
		{
			return pointer;
		}

		pointer->root = NULL;
		return pointer;
	}


	//if n = 1 then the single point provided is the entire tree
	if (n == 1)
	{
		kdtree *pointer;
		pointer = malloc(sizeof(kdtree));
		pointer->root = malloc(sizeof(kdtree_node));

		if (pointer->root == NULL)
		{
			return pointer;
		}

		//if the malloc didn't fail, we make our root 
		pointer->root->xaxis         = true;							
		pointer->root->coordinates.x = pts->x;
		pointer->root->coordinates.y = pts->y;	
		pointer->root->parent        = NULL;                
		pointer->root->leftchild     = NULL;				
		pointer->root->rightchild    = NULL;
		return pointer;
	}


	//if n = 2 since the list is ordered, the point on the right is going to be greater than the point on the left
	if (n ==2)
	{
		kdtree *pointer;
		pointer = malloc(sizeof(kdtree));
		pointer->root = malloc(sizeof(kdtree_node));

		if (pointer->root == NULL)
		{
			return pointer;
		}

		//if the malloc didn't fail, we make our root 
		pointer->root->xaxis         = true;							
		pointer->root->coordinates.x = pts->x;
		pointer->root->coordinates.y = pts->y;	
		pointer->root->parent        = NULL;                
		pointer->root->leftchild     = NULL;				
		pointer->root->rightchild    = malloc(sizeof(kdtree_node));

		kdtree_node *pointer2;

		pointer2 = pointer->root->rightchild;

		pointer2->xaxis	        = false;
		pointer2->coordinates.x = (pts+1)->x;
		pointer2->coordinates.y = (pts+1)->y;
		pointer2->parent        = pointer->root;
		pointer2->leftchild     = NULL;
		pointer2->rightchild    = NULL;

		return pointer;
	}

	kdtree *pointer;
	location *array_x; //pointer for array sorted by x
	location *array_y; //pointer for array sorted by y

	mergeSort(n, pts, array_x, true); //assign them to the outputs of the mergesort
	mergeSort(n, pts, array_y, false);

	//check to make sure that there are not any duplicated points in the x or y arrays
	for (int i = 0; i < n-1; ++i)
	{
		if (array_x[i].x == array_x[i+1].x && array_x[i].y == array_x[i+1].y)
		{
			return pointer;
		}

		if (array_y[i].x == array_y[i+1].x && array_y[i].y == array_y[i+1].y)
		{
			return pointer;
		}
	}

	//malloc pointer to a kdtree_node, this will be the root node for the actual tree that we create. Fields are initiated as such
	kdtree_node *root_node, *lchild, *rchild;
	
	location *array_xleft, *array_yleft, *array_xright, *array_yright;

	location median = median_and_arrays(array_x, array_y,
		n, true,
		array_xleft, array_xright, array_yleft, array_yright);

	
	root_node->xaxis         = true;				//true because node			
	root_node->coordinates.x = median.x;				//x and y are values from the median location value
	root_node->coordinates.y = median.y;				//	pointed to by pts
	root_node->parent        = NULL;           		//is root so no parent
	root_node->leftchild     = lchild;				//no children yet
	root_node->rightchild    = rchild;				//no children yet





	//if n is not 0 1 or 2, we call the recursive helper functon to create the tree
	helper_for_create(root_node->leftchild, root_node, n, array_xleft, array_yleft, false);
	helper_for_create(root_node->rightchild, root_node, n, array_xright, array_yright, false);

}


void helper_for_create(kdtree_node *current_node, kdtree_node *parent, int n, location *x_array, location *y_array, xaxis){
	//we assume we are passed the pointer to a node. We give it no children because subsequent recursive calls will give it children if it is suppoused to have any. this is done with a while loop while n>0
	if (n > 0)
	{
		location *array_xleft, *array_yleft, *array_xright, *array_yright;

		location median = median_and_arrays(x_array, y_array,
			n, xaxis,
			array_xleft, array_xright, array_yleft, array_yright);

		kdtree_node *lchild, *rchild;



		current_node->xaxis         = xaxis;
		current_node->coordinates.x = median.x;
		current_node->coordinates.y = median.y;
		current_node->parent        = parent;
		current_node->leftchild	    = lchild;
		current_node->rightchild    = rchild;

		n-=1;

		helper_for_create(current_node->leftchild, current_node, n, array_xleft, array_yleft, !xaxis);
		helper_for_create(current_node->rightchild, current_node, n, array_xright, array_yright, !xaxis);

	}

	return;
}



/**
 * Adds a copy of the given point to the given k-d tree.  There is no
 * effect if the point is already in the tree.  The tree need not be
 * balanced after the add.  The return value is true if the point was
 * added successfully and false otherwise (if the point was already in the
 * tree or if there was a memory allocation error when trying to add).
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param p a pointer to a valid location, non-NULL
 * @return true if and only if the point was successfully added
 */
//I use contains in add so we gonna declare it first
bool kdtree_contains(const kdtree *t, const location *p);

bool kdtree_add(kdtree *t, const location *p){
	printf("kdtree_add was called\n");

	//check to see if p or t is null
	if (p == NULL || t == NULL)
	{
		return false; //return false because we failed to add stuff to the tree
	}


	//see if the kdtree_node is empty. If so, we put p as the root with no children. 
	if (t->root == NULL)
	{
		t->root = malloc(sizeof(kdtree_node));

		if (t->root == NULL) //returns false if the malloc failed
		{
			return false;
		}

		//if the malloc didn't fail, we make our root 
		t->root->xaxis         = true;							
		t->root->coordinates.x = p->x;
		t->root->coordinates.y = p->y;	
		t->root->parent        = NULL;                
		t->root->leftchild     = NULL;				
		t->root->rightchild    = NULL;	

		return true; //return true because node was sucessfully added to tree
	}


	//see if the point is already contained within the tree pointed to by t
	if (kdtree_contains(t,p) == true)
	{
		return false; //if it is already in the tree, return false. 
	} 


	//while the current node is not a leaf, determine whether to traverse left or right on the tree. 
	kdtree_node *current_node  = t->root;
	kdtree_node *previous_node = NULL;
	while (current_node != NULL)
	{	
		previous_node = current_node; //keep track of the previous node

		//if we are cutting on x axis
		if (current_node->xaxis == true)
		{
			//determine traverse left or right
			if (p->x < current_node->coordinates.x)//if we travel left
			{
				current_node = current_node->leftchild;
			}

			else
			{
				current_node = current_node->rightchild; //we travel to right child if p is larger
			}
		}

		//if we are cutting on y axis
		else if (current_node->xaxis == false)
		{
			//determine traverse left or right
			if (p->y < current_node->coordinates.y)//if we travel left
			{
				current_node = current_node->leftchild;
			}

			else
			{
				current_node = current_node->rightchild;// we travel to right child if p is larger
			}
		}

	}

	//we have made it to a leaf so we need to add a new thing
	kdtree_node *added;
	added = malloc(sizeof(kdtree_node));

	if (added == NULL) //returns false if the malloc failed
		{
			return false;
		}

	//if the malloc didn't fail, we make our new node
	added->xaxis         = !previous_node->xaxis;							
	added->coordinates.x = p->x;
	added->coordinates.y = p->y;	
	added->parent        = previous_node;                
	added->leftchild     = NULL;				
	added->rightchild    = NULL;	


	//we are at a null value, so we need to determine whether to insert into left or right subtree. but first, figure out what axis we are cutting on
	if (previous_node->xaxis == true)
	{
		if (p->x < previous_node->coordinates.x)
		{
			previous_node->leftchild = added;
			return true;
		}

		else
		{	
			previous_node->rightchild = added;
			return true;
		}
	}

	else if (previous_node->xaxis == false)
	{
		if (p->y < previous_node->coordinates.y)
		{
			previous_node->leftchild = added;
			return true;
		}

		else
		{
			previous_node->rightchild = added;
			return true;
		}
	}
}



/**
 * Determines if the given tree contains a point with the same coordinates
 * as the given point.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param p a pointer to a valid location, non-NULL
 * @return true if and only of the tree contains the location
 */
bool kdtree_contains(const kdtree *t, const location *p){
	printf("kdtree_contains has been called\n");

	//check to see if t and p are pointing to null
	if (t == NULL || p == NULL)
	{
		return false;
	}


	//check to see if the actual tree pointed to by t is empty
	if (t->root == NULL)
	{
		return false;
	}


	kdtree_node *current_node = t->root;
	//while the current node is not a leaf we check to see the value is equal
	while (current_node != NULL)
	{
		if (current_node->coordinates.x == p->x && current_node->coordinates.y == p->y)
		{
			return true;
		}

		else
		{
			//check if we are cutting on x dimension
			if (current_node->xaxis == true)
			{
				if (p->x < current_node->coordinates.x)	//see if we need to go down left subtree
				{
					current_node = current_node->leftchild;
				}

				else //seems like we need to go down right subtree
				{
					current_node = current_node->rightchild;
				}
			}

			//check if we are cutting on y dimension
			else if (current_node->xaxis == false)
			{
				if (p->y < current_node->coordinates.y)	//see if we need to go down left subtree
				{
					current_node = current_node->leftchild;
				}

				else //seems like we go down right subtree
				{
					current_node = current_node->rightchild;
				}
			}
		}
	} 

	return false; //we have run outof nodes and have fallen off the tree
}

	

/**
 * Copies the nearest neighbor to the given point among points in the
 * given tree to the given location.  Ties are broken arbitrarily.
 * There is no change to neighbor and distance is set to infinity if
 * the tree is empty.  If p is equal to a point in the tree then p is
 * copied into neighbor and distance is set to zero.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param p a pointer to a valid location, non-NULL
 * @param d a pointer to a double, non-NULL
 * @param neighbor a pointer to a valid location, non-NULL
 */
void kdtree_nearest_neighbor(kdtree *t, const location *p, location *neighbor, double *d){
	printf("kdtree_nearest_neighbor has been called\n");

	return;
}



void for_each(const kdtree *r, kdtree_node *current_node, void (*f)(const location *, void *), void *arg);
/**
 * Passes the points in the given tree to the given function
 * in an arbitrary order.  The last argument to this function is also passed
 * to the given function along with each point.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param f a pointer to a function that takes a location and an extra
 * argument, and does not modify t, non-NULL
 * @param arg a pointer
 */
void kdtree_for_each(const kdtree* r, void (*f)(const location *, void *), void *arg){
	//make sure the pointers are not void
	if (r == NULL || arg == NULL || f == NULL)
	{
		return;
	}


	if (r->root == NULL)
	{
		return;
	}


	else
	{
		for_each(r, r->root, f, arg);
	}
}

void for_each(const kdtree *r, kdtree_node *current_node, void (*f)(const location *, void *), void *arg){
	//if the current node is null
	if (current_node == NULL)
	{
		return;
	}

	else if (current_node->rightchild != NULL && current_node->leftchild != NULL)
	{
		f(&current_node->coordinates, arg);

		for_each(r, current_node->rightchild, f, arg);
		for_each(r, current_node->leftchild, f, arg);
	}

	else if (current_node->rightchild == NULL && current_node->leftchild != NULL)
	{
		f(&current_node->coordinates, arg);
		for_each(r, current_node->leftchild, f, arg);
	}	

	else if (current_node->rightchild != NULL && current_node->leftchild == NULL)
	{
		f(&current_node->coordinates, arg);
		for_each(r, current_node->rightchild, f, arg);
	}

	else if (current_node->rightchild == NULL && current_node->leftchild == NULL)
	{
		f(&current_node->coordinates, arg);
	}
}






//destroy children
void destroy_children(kdtree_node *t){

	if (t == NULL)
	{
		return;
	}

	if (t->leftchild == NULL && t->rightchild == NULL)
	{
		free(t);
	}

	else
	{
		destroy_children(t->leftchild);
		destroy_children(t->rightchild);

		free(t);
	}
}



/**
 * Destroys the given k-d tree.  The tree is invalid after being destroyed.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 **/
//used by kdtree_destory
void kdtree_destroy(kdtree *t){
	//check if the t pass in is pointing to null
	if (t == NULL)
	{
		return; //nothing is here. Go back.
	}


	if (t->root == NULL)
	{
		free(t);
		return;
	}

	destroy_children(t->root->leftchild);
	destroy_children(t->root->rightchild);

	free(t);
}



/* merge sorted arrays a1 and a2, putting result in out */
void
merge(int n1, const location a1[], int n2, const location a2[], location out[], bool xory)
{
    int i1;
    int i2;
    int iout;

    i1 = i2 = iout = 0;

    if (xory == true) //if xory is true, we order by x
    {
    	while(i1 < n1 || i2 < n2) {
        if(i2 >= n2 || ((i1 < n1) && (a1[i1].x < a2[i2].x))) {
            /* a1[i1] exists and is smaller */
            out[iout++] = a1[i1++];
        }  

        else if (i2>= n2 || ((i1 < n1) && (a1[i1].x == a2[i2].x )))
        {
        	if (a1[i1].y < a2[i2].y)
        	{
        		out[iout++] = a1[i1++];
        	}

        	else 
        	{
        		out[iout++] = a1[i2++];
        	}
        }

        else {
            /* a1[i1] doesn't exist, or is bigger than a2[i2] */
            out[iout++] = a2[i2++];
        	}
    	}
    }


    if (xory == false) //if xory is false, we order by y
    {
    	while(i1 < n1 || i2 < n2) {
        if(i2 >= n2 || ((i1 < n1) && (a1[i1].y < a2[i2].y))) {
            /* a1[i1] exists and is smaller */
            out[iout++] = a1[i1++];
        }  

        else if (i2>= n2 || ((i1 < n1) && (a1[i1].y == a2[i2].y )))
        {
        	if (a1[i1].x < a2[i2].x)
        	{
        		out[iout++] = a1[i1++];
        	}

        	else
        	{
        		out[iout++] = a1[i2++];
        	}
        }

        else {
            /* a1[i1] doesn't exist, or is bigger than a2[i2] */
            out[iout++] = a2[i2++];
        }
    }
	}
}

/* sort a, putting result in out */
/* we call this mergeSort to avoid conflict with mergesort in libc */
void 
mergeSort(int n, const location a[], location out[], bool xory){
    location *a1;
    location *a2;

    if(n < 2) {
        /* 0 or 1 elements is already sorted */
        memcpy(out, a, sizeof(location) * n);
    } else {
        /* sort into temp arrays */
        a1 = malloc(sizeof(location) * (n/2));
        a2 = malloc(sizeof(location) * (n - n/2));

        mergeSort(n/2, a, a1, xory);
        mergeSort(n - n/2, a + n/2, a2, xory);

        /* merge results */
        merge(n/2, a1, n - n/2, a2, out, xory);

        /* free the temp arrays */
        free(a1);
        free(a2);
    }
}


//function for getting median value and then 4 different subarays from an imput array. The four subarays are x_array_left, x_array_right, y_array_left, and y_array_right. returns location struct that is the median locaton
location median_and_arrays(location listofx[], location listofy[],
	int n, bool xaxis,
	location x_array_left[], location x_array_right[],
	location y_array_left[], location y_array_right[]){

	int index_of_median = ((n - 1) / 2); //always will be the index of the median thing

	//give arrays actual malloced memory space
	location x_array_left[]  = malloc(sizeof(location)*index_of_median);
	location x_array_right[] = malloc(sizeof(location)*(n - index_of_median - 1));
	location y_array_left[]  = malloc(sizeof(location)*index_of_median);
	location y_array_right[] = malloc(sizeof(location)*(n - index_of_median - 1));

	location median; //initialize median 

	if (xaxis == true)
	{
		median = listofx[index_of_median]

		//cutting by x, relatively simpler
		//x_array_left
		for (int i = 0; i < index_of_median; ++i)
		{
			x_array_left[i] = listofx[i]; 
		}

		//x_array_right
		for (int i = index_of_median + 1; i < n; ++i)
		{
			x_array_right[i-(index_of_median + 1)] =  listofx[i];
		}

		int countleft = 0;
		int countright = 0;
		//y sub arrays
		for (int i = 0; i < n; ++i)
		{
			
			if (listofy[i]->x < listofx[index_of_median]->x) // if in y array left
			{
				y_array_left[count] = listofy[i];
				countleft += 1;
			}

			else if (listofy[i]->x > listofx[index_of_median]->x)
			{
				y_array_right[count] = listofy[i];
				countright += 1;
			}

			else
			{
				if (listofy[i]->y < listofx[index_of_median]->y) //tie break when x is equal by y
				{
					y_array_left[count] = listofy[i];
					countleft += 1;
				}

				else if (listofy[i]->y > listofx[index_of_median]->y)
				{
					y_array_right[count] = listofy[i];
					countright += 1;
				}
			}

			
		}
		
	}

	if (xaxis == false)
	{
		median = listofy[index_of_median]

		//cutting by y, relatively simpler
		//y_array_left
		for (int i = 0; i < index_of_median; ++i)
		{
			y_array_left[i] = listofy[i]; 
		}

		//y_array_right
		for (int i = index_of_median + 1; i < n; ++i)
		{
			y_array_right[i-(index_of_median + 1)] =  listofy[i];
		}

		int countleft = 0;
		int countright = 0;
		//x sub arrays
		for (int i = 0; i < n; ++i)
		{
			
			if (listofy[i]->y < listofx[index_of_median]->y) // if in x array left
			{
				x_array_left[count] = listofx[i];
				countleft += 1;
			}

			else if (listofy[i]->y > listofx[index_of_median]->y)
			{
				x_array_right[count] = listofx[i];
				countright += 1;
			}

			else
			{
				if (listofy[i]->x < listofx[index_of_median]->x) //tie break when y is equal by x
				{
					x_array_left[count] = listofx[i];
					countleft += 1;
				}

				else if (listofy[i]->x > listofx[index_of_median]->x)
				{
					x_array_right[count] = listofx[i];
					countright += 1;
				}
			}

			
		}


	}

	return median; //return the median value

}

