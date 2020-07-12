#include <stdbool.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <limits.h>

#include "location.h"

void mergeSort(int n, const location a[], location out[], bool xory);




/**
 * A set of Cartesian coordinates implemented using a k-d tree, where k = 2.
 */
//basically linked list except each element of the list is linked to two elements (the children). Each node is distinct struct of type kdtree. Basically recursively defined kdtree_node with base cases: defined a node as a kdtree_node and a node with two child nodes as kdtree. 

typedef struct node {
    bool xaxis;                         //keeps track of what the cutting axis is
    location coordinates;               //the actual value of the coordinates
    struct node *parent;                //null if the node is the root of the tree
    struct node *leftchild;             //null if the node is a leaf
    struct node *rightchild;            //null if the node is a leaf
} kdtree_node;


typedef struct _kdtreek {
    kdtree_node *root;
} kdtree;



void helper_for_create(kdtree_node *current_node, kdtree_node *parent, int n, location *x_array, location *y_array, bool xaxis);

location* median_and_arrays(location listofx[], location listofy[],
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

    //if we have n=0, then must create an empty tree. 
    if (n == 0 || pts == NULL)
    {
        kdtree *pointer;
        pointer = malloc(sizeof(kdtree));

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

    kdtree *pointer;
    pointer = malloc(sizeof(kdtree));
    pointer->root = malloc(sizeof(kdtree_node));

    kdtree_node *root_node = pointer->root;
    location *array_x = malloc(sizeof(location)*n); //pointer for array sorted by x
    location *array_y = malloc(sizeof(location)*n); //pointer for array sorted by y



    mergeSort(n, pts, array_x, true); //assign them to the outputs of the mergesort
    mergeSort(n, pts, array_y, false);


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
        pointer->root->coordinates.x = array_x[0].x;
        pointer->root->coordinates.y = array_x[0].y;  
        pointer->root->parent        = NULL;                
        pointer->root->leftchild     = NULL;                
        pointer->root->rightchild    = malloc(sizeof(kdtree_node));

        kdtree_node *pointer2;

        pointer2 = pointer->root->rightchild;

        pointer2->xaxis         = false;
        pointer2->coordinates.x = array_x[1].x;
        pointer2->coordinates.y = array_y[1].y;
        pointer2->parent        = pointer->root;
        pointer2->leftchild     = NULL;
        pointer2->rightchild    = NULL;

        return pointer;
    }

    /*kdtree *pointer;
    pointer = malloc(sizeof(kdtree));
    pointer->root = malloc(sizeof(kdtree_node)); */

    if (pointer == NULL || pointer->root == NULL) //if the root node is null or the pointer to the root node is null, return pointer to the root node. (the malloc failed)
    {
        return pointer;
    }




    

    //check to make sure that there are not any duplicated points in the x array or y array
    for (int i = 0; i < n-1; ++i)
    {
        if (array_x[i].x == array_x[i+1].x && array_x[i].y == array_x[i+1].y)
        {
            return pointer;
        }
    }


    //if the malloc didn't fail, we need the median. (x/y)_array_(left/right) are malloced withing the median_and_arrays function. these will be pointers to the arrays that actually contain stuff useful to us later
    location *x_array_left, *x_array_right, *y_array_left, *y_array_right;
    //give arrays actual malloced memory space
    int index_of_median = (n-1)/2;

    x_array_left  = malloc(sizeof(location)*index_of_median);
    x_array_right = malloc(sizeof(location)*(n - index_of_median - 1));
    y_array_left  = malloc(sizeof(location)*index_of_median);
    y_array_right = malloc(sizeof(location)*(n - index_of_median - 1));


    location *median = median_and_arrays(array_x, array_y, n, true, x_array_left, x_array_right, y_array_left, y_array_right);



    //now we need use the median so that we can get values for initializing the root node. 
    //also malloc some space for the left and right child
    kdtree_node *lchild = malloc(sizeof(kdtree_node));
    kdtree_node *rchild = malloc(sizeof(kdtree_node));

    root_node->xaxis         = true;
    root_node->coordinates.x = median->x;
    root_node->coordinates.y = median->y;
    root_node->parent        = NULL;
    root_node->leftchild     = lchild;
    root_node->rightchild    = rchild;


    helper_for_create(root_node->rightchild, root_node, (n-1)-((n-1)/2), x_array_right, y_array_right, false);
    
    helper_for_create(root_node->leftchild, root_node, (n-1)/2, x_array_left, y_array_left, false);



    free(x_array_right);
    free(x_array_left);
    free(y_array_right);
    free(y_array_left);
    return pointer;

}

void helper_for_create(kdtree_node *current_node, kdtree_node *parent, int n, location *x_array, location *y_array, bool xaxis)
{
    //if n = 1
    if (n == 1)
    {
        //sorting by x
        if (xaxis == true)
        {
            //node is just the only point we have in x_array
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = x_array[0].x;
            current_node->coordinates.y = x_array[0].y;
            current_node->parent        = parent;
            current_node->leftchild     = NULL;
            current_node->rightchild    = NULL;

            return;
        }

        //sorting by y
        else if (xaxis == false)
        {
            //node is just the point we have in y_array
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = y_array[0].x;
            current_node->coordinates.y = y_array[0].y;
            current_node->parent        = parent;
            current_node->leftchild     = NULL;
            current_node->rightchild    = NULL;

            return;
        }

    }


    //if n = 2
    else if (n == 2)
    {
        //if cut in x dimension
        if (xaxis == true)
        {
            kdtree_node *lower_node  = malloc(sizeof(kdtree_node));

            //fill the higher node with things
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = x_array[0].x;
            current_node->coordinates.y = x_array[0].y;
            current_node->parent        = parent;
            current_node->leftchild     = NULL;
            current_node->rightchild    = lower_node;

            //fill the lower node with things
            lower_node->xaxis         = !current_node->xaxis;
            lower_node->coordinates.x = x_array[1].x;
            lower_node->coordinates.y = x_array[1].y;
            lower_node->parent        = current_node;
            lower_node->leftchild    = NULL;
            lower_node->rightchild    = NULL;  

            return;
        }
        




        //if cut in y dimension
        else if (xaxis == false)
        {
            kdtree_node *lower_node  = malloc(sizeof(kdtree_node));


            //fill the higher node with things
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = y_array[0].x;
            current_node->coordinates.y = y_array[0].y;
            current_node->parent        = parent;
            current_node->leftchild     = NULL;
            current_node->rightchild    = lower_node;

            //fill the lower node with things
            lower_node->xaxis         = !current_node->xaxis;
            lower_node->coordinates.x = y_array[1].x;
            lower_node->coordinates.y = y_array[1].y;
            lower_node->parent        = current_node;
            lower_node->rightchild    = NULL;
            lower_node->leftchild    = NULL;  

            return;
        }


    }

    
    //if n = 3
    else if (n == 3)
    {
        //if cutting by x
        if (xaxis == true)
        {
            kdtree_node *left_node  = malloc(sizeof(kdtree_node));
            kdtree_node *right_node = malloc(sizeof(kdtree_node));

            //fill the mid node with things
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = x_array[1].x;
            current_node->coordinates.y = x_array[1].y;
            current_node->parent        = parent;
            current_node->leftchild     = left_node;
            current_node->rightchild    = right_node;

            //fill the left node with things
            left_node->xaxis         = !current_node->xaxis;
            left_node->coordinates.x = x_array[0].x;
            left_node->coordinates.y = x_array[0].y;
            left_node->parent        = current_node;
            left_node->leftchild     = NULL;
            left_node->rightchild    = NULL;

            //fill the right node with things
            right_node->xaxis         = !current_node->xaxis;
            right_node->coordinates.x = x_array[2].x;
            right_node->coordinates.y = x_array[2].y;
            right_node->parent        = current_node;
            right_node->rightchild    = NULL;
            right_node->rightchild    = NULL;  

            return;
        }



        //if cutting by y
        else if (xaxis == false)
        {
            kdtree_node *left_node  = malloc(sizeof(kdtree_node));
            kdtree_node *right_node = malloc(sizeof(kdtree_node));

            //fill the mid node with things
            current_node->xaxis         = xaxis;
            current_node->coordinates.x = y_array[1].x;
            current_node->coordinates.y = y_array[1].y;
            current_node->parent        = parent;
            current_node->leftchild     = left_node;
            current_node->rightchild    = right_node;

            //fill the left node with things
            left_node->xaxis         = !current_node->xaxis;
            left_node->coordinates.x = y_array[0].x;
            left_node->coordinates.y = y_array[0].y;
            left_node->parent        = current_node;
            left_node->leftchild     = NULL;
            left_node->rightchild    = NULL;

            //fill the right node with things
            right_node->xaxis         = !current_node->xaxis;
            right_node->coordinates.x = y_array[2].x;
            right_node->coordinates.y = y_array[2].y;
            right_node->parent        = current_node;
            right_node->rightchild    = NULL;
            right_node->rightchild    = NULL;  

            return;
        }
    }
    


    else 
    {
        //cutting by x
        if (xaxis == true)
        {
            //create the node from the median at index (n-1)/2
            kdtree_node *lchild = malloc(sizeof(kdtree_node));
            kdtree_node *rchild = malloc(sizeof(kdtree_node));

            location *x_array_left, *x_array_right, *y_array_left, *y_array_right;

                //give arrays actual malloced memory space
            int index_of_median = (n-1)/2;
            x_array_left  = malloc(sizeof(location)*index_of_median);
            x_array_right = malloc(sizeof(location)*(n - index_of_median - 1));
            y_array_left  = malloc(sizeof(location)*index_of_median);
            y_array_right = malloc(sizeof(location)*(n - index_of_median - 1));


            location *median = median_and_arrays(x_array, y_array, n, xaxis, x_array_left, x_array_right, y_array_left, y_array_right);

            current_node->xaxis         = xaxis;
            current_node->coordinates.x = median->x;
            current_node->coordinates.y = median->y;
            current_node->parent        = parent;
            current_node->rightchild    = lchild;
            current_node->leftchild     = rchild;


            helper_for_create(current_node->rightchild, current_node, (n-1)-((n-1)/2), x_array_right, y_array_right, !current_node->xaxis);
    
            helper_for_create(current_node->leftchild, current_node, (n-1)/2, x_array_left, y_array_left, 
                !current_node->xaxis);

            

            free(x_array_right);
            free(x_array_left);
            free(y_array_right);
            free(y_array_left);
            return;

        }

        //cutting by y
        if (xaxis == false)
        {
             //create the node from the median at index (n-1)/2
            kdtree_node *lchild = malloc(sizeof(kdtree_node));
            kdtree_node *rchild = malloc(sizeof(kdtree_node));

            location *x_array_left, *x_array_right, *y_array_left, *y_array_right;
            int index_of_median = (n-1)/ 2;
            //give arrays actual malloced memory space
            x_array_left  = malloc(sizeof(location)*index_of_median);
            x_array_right = malloc(sizeof(location)*(n - index_of_median - 1));
            y_array_left  = malloc(sizeof(location)*index_of_median);
            y_array_right = malloc(sizeof(location)*(n - index_of_median - 1));


            location *median = median_and_arrays(x_array, y_array, n, xaxis, x_array_left, x_array_right, y_array_left, y_array_right);

            current_node->xaxis         = xaxis;
            current_node->coordinates.x = median->x;
            current_node->coordinates.y = median->y;
            current_node->parent        = parent;
            current_node->rightchild    = lchild;
            current_node->leftchild     = rchild;


            helper_for_create(current_node->rightchild, current_node, (n-1)-((n-1)/2), x_array_right, y_array_right, !current_node->xaxis);
    
            helper_for_create(current_node->leftchild, current_node, (n-1)/2, x_array_left, y_array_left, 
                !current_node->xaxis);

            free(x_array_right);
            free(x_array_left);
            free(y_array_right);
            free(y_array_left);
            return;
        }

    }

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
                if (p->x < current_node->coordinates.x) //see if we need to go down left subtree
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
                if (p->y < current_node->coordinates.y) //see if we need to go down left subtree
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




void helper_for_nearest(kdtree_node *t, bool left_tree, location *bottom_corner, location *top_corner, const location *p, location *neighbor, double *d)
{
    //we check if the things we have been passed are null or zero
    if (t == NULL || *d == 0 || p == NULL)
    {
        return; //we return nothing
    }

    //now we check region. We check the previous node's axes to see if we need to update x or y coordinates in our corners.
    if (t->parent->xaxis == true)
    {
        if (left_tree == true)
        {
            top_corner->x = t->parent->coordinates.x;
        }

        else
        {
            bottom_corner->x = t->parent->coordinates.x;
        }
    }

    //in this case, the pervious node was split along the y axis
    else
    {
         if (left_tree == true)
        {
            top_corner->y = t->parent->coordinates.y;
        }

        else
        {
            bottom_corner->y = t->parent->coordinates.y;
        }
    }


    //now we check the region. if the distance to the rectangle is greater than d,
    if (fabs(location_distance_to_rectangle(p, bottom_corner, top_corner)) > *d)
    {
        return;
    }


    //save the current distance in a variable
    double  current_distance = fabs(location_distance(p, &t->coordinates));

    if (current_distance < *d) //if current distance is less, we update the values of neighbor and d
    {
        neighbor->x = t->coordinates.x;
        neighbor->y = t->coordinates.y;

        *d = current_distance;
    }



    //get some location pointers for our four corners
    location *left_top_corner, *left_bottom_corner, *right_top_corner, *right_bottom_corner;

    //malloc actuall space for all of our pointers
    left_top_corner     = malloc(sizeof(location)); 
    left_bottom_corner  = malloc(sizeof(location));
    right_top_corner    = malloc(sizeof(location));
    right_bottom_corner = malloc(sizeof(location));



    //update locations
    //check to see if t is split by x
    if (t->xaxis == true)
    {
        left_bottom_corner->x = bottom_corner->x;
        left_bottom_corner->y = bottom_corner->y;

        left_top_corner->x = t->coordinates.x;
        left_top_corner->y = top_corner->y;


        right_bottom_corner->x = t->coordinates.x;
        right_bottom_corner->y = bottom_corner->y;

        right_top_corner->x = top_corner->x;
        right_top_corner->y = top_corner->y;
    }


    else
    {
        left_bottom_corner->x = bottom_corner->x;
        left_bottom_corner->y = bottom_corner->y;

        left_top_corner->x = top_corner->x;
        left_top_corner->y = t->coordinates.y;


        right_bottom_corner->x = bottom_corner->x;
        right_bottom_corner->y = t->coordinates.y;

        right_top_corner->x = top_corner->x;
        right_top_corner->y = top_corner->y;
    }

    //see what axis we are working with
    if (t->xaxis == true)
    {
        
        //if the x value of p is less than x value of t
        if (p->x < t->coordinates.x)
        {
            helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
        }

        //else if the x value of p is greater than the x value of t
        else if (p->x > t->coordinates.x)
        {
            helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
        }

        else
        {
            //this is for tie-breaker for testing y values
            //if the y value of p is less than y value of t
            if (p->y < t->coordinates.y)
            {
                helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
                helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            }

            //else if the y value of p is greater than the y value of t
            else if (p->y > t->coordinates.y)
            {
                helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
                helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            }
        }

    }

    else
    {
        //if the y value of p is less than y value of t
        if (p->y < t->coordinates.y)
        {
            helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
        }

        //else if the y value of p is greater than the y value of t
        else if (p->y > t->coordinates.y)
        {
            helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
        }

        else
        {
            //this is for tie-breaker for testing x values
            //if the x value of p is less than x value of t
            if (p->x < t->coordinates.x)
            {
                helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
                helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            }

            //else if the x value of p is greater than the x value of t
            else if (p->x > t->coordinates.x)
            {
                helper_for_nearest(t->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
                helper_for_nearest(t->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            }
        }

    }

    //free all the corners
    free(left_top_corner);
    free(right_top_corner);
    free(left_bottom_corner);
    free(right_bottom_corner);


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

    //if we get null thing, just return nothing. 
    if (t == NULL || t->root == NULL || p == NULL || d == NULL)
    {
        *d = INFINITY;
        return; //return nothing
    }

    if (kdtree_contains(t, p))
    {
        *d = 0;
        neighbor->x = p->x;
        neighbor->y = p->y;
        return;
    }

    *d = fabs(location_distance(&t->root->coordinates, p));
    neighbor->x = t->root->coordinates.x;
    neighbor->y = t->root->coordinates.y;

    location *left_top_corner, *left_bottom_corner, *right_top_corner, *right_bottom_corner;

    //malloc actuall space for all of our pointers
    left_top_corner     = malloc(sizeof(location)); 
    left_bottom_corner  = malloc(sizeof(location));
    right_top_corner    = malloc(sizeof(location));
    right_bottom_corner = malloc(sizeof(location));


    //this is the left box
    left_top_corner->x = t->root->coordinates.x;
    left_top_corner->y = INFINITY;

    left_bottom_corner->x = -INFINITY;
    left_bottom_corner->y = -INFINITY;


    //this is the right box
    right_top_corner->x = INFINITY;
    right_top_corner->y = INFINITY;

    right_bottom_corner->x = t->root->coordinates.x;
    right_bottom_corner->y = -INFINITY;



    //see what axis we are working with
    if (t->root->xaxis == true)
    {
        
        //if the x value of p is less than x value of t
        if (p->x < t->root->coordinates.x)
        {
            helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
        }

        //else if the x value of p is greater than the x value of t
        else if (p->x > t->root->coordinates.x)
        {
            helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
        }

        else
        {
            //this is for tie-breaker for testing y values
            //if the y value of p is less than y value of t
            if (p->y < t->root->coordinates.y)
            {
                helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
                helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            }

            //else if the y value of p is greater than the y value of t
            else if (p->y > t->root->coordinates.y)
            {
                helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
                helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            }
        }

    }

    else
    {
        //if the y value of p is less than y value of t
        if (p->y < t->root->coordinates.y)
        {
            helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
        }

        //else if the y value of p is greater than the y value of t
        else if (p->y > t->root->coordinates.y)
        {
            helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
        }

        else
        {
            //this is for tie-breaker for testing x values
            //if the x value of p is less than x value of t
            if (p->x < t->root->coordinates.x)
            {
                helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
                helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
            }

            //else if the x value of p is greater than the x value of t
            else if (p->x > t->root->coordinates.x)
            {
                helper_for_nearest(t->root->rightchild, true, right_bottom_corner, right_top_corner, p, neighbor, d);
                helper_for_nearest(t->root->leftchild, true, left_bottom_corner, left_top_corner, p, neighbor, d);
            }
        }

    }

    //free all the corners
    free(left_top_corner);
    free(right_top_corner);
    free(left_bottom_corner);
    free(right_bottom_corner);
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

    if (t->leftchild != NULL)
    {
        destroy_children(t->leftchild);
    }

    if (t->rightchild != NULL)
    {
        destroy_children(t->rightchild);
    }

    free(t);
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

    free(t->root);
    free(t);
}



/* merge sorted arrays a1 and a2, putting result in out */
void merge(int n1, const location a1[], int n2, const location a2[], location out[], bool xory)
{
    int i1;
    int i2;
    int iout;

    i1 = i2 = iout = 0;

    if (xory == true) //if xory is true, we order by x
    {
        while(i1 < n1 || i2 < n2) 
        {
            if(i2 >= n2 || ((i1 < n1) && (a1[i1].x < a2[i2].x))) 
            {
                /* a1[i1] exists and is smaller */
                out[iout++] = a1[i1++];
            }  

            else if (i2>= n2 || ((i1 < n1) && (a1[i1].x == a2[i2].x)))
            {
                if (a1[i1].y < a2[i2].y)
                {
                    out[iout++] = a1[i1++];
                }

                else 
                {
                    out[iout++] = a2[i2++];
                }
            }

            else 
            {
                /* a1[i1] doesn't exist, or is bigger than a2[i2] */
                out[iout++] = a2[i2++];
            }
        }
    }


    else if (xory == false) //if xory is false, we order by y
    {
        while(i1 < n1 || i2 < n2) 
        {
            if(i2 >= n2 || ((i1 < n1) && (a1[i1].y < a2[i2].y))) 
            {
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
                    out[iout++] = a2[i2++];
                }
            }

            else 
            {
                /* a1[i1] doesn't exist, or is bigger than a2[i2] */
                out[iout++] = a2[i2++];
            }
        }
    }
}

/* sort a, putting result in out */
/* we call this mergeSort to avoid conflict with mergesort in libc */
void
mergeSort(int n, const location a[], location out[], bool xory)
{
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
location* median_and_arrays(location *listofx, location *listofy,
    int n, bool xaxis,
    location *x_array_left, location *x_array_right,
    location *y_array_left, location *y_array_right){

    int index_of_median = ((n - 1) / 2); //always will be the index of the median thing


    location *median = malloc(sizeof(location)); //initialize median 

    int countright;
    int countleft;

    ///need to fix the iteration counters on these loops
    if (xaxis == true)
    {
        median = &listofx[index_of_median]; //give median its value when cutting by x

        //cutting by x, relatively simpler
        //x_array_left
        for (int i = 0; i < index_of_median; ++i)
        {
            x_array_left[i].x = listofx[i].x; 
            x_array_left[i].y = listofx[i].y;
        }

        //x_array_right
        for (int i = index_of_median + 1; i < n; ++i)
        {
            x_array_right[i-(index_of_median + 1)].x = listofx[i].x;
            x_array_right[i-(index_of_median + 1)].y = listofx[i].y;
        }


        countleft = 0;
        countright = 0;
        //y sub arrays
        for (int i = 0; i < n; ++i)
        {
            
            if (listofy[i].x < listofx[index_of_median].x) // if in y array left
            {
                y_array_left[countleft].x = listofy[i].x;
                y_array_left[countleft].y = listofy[i].y;
                countleft += 1;
            }

            else if (listofy[i].x > listofx[index_of_median].x)
            {
                y_array_right[countright].x = listofy[i].x;
                y_array_right[countright].y = listofy[i].y;
                countright += 1;
            }

            else
            {
                if (listofy[i].y < listofx[index_of_median].y) //tie break when x is equal by y
                {
                    y_array_left[countleft].x = listofy[i].x;
                    y_array_left[countleft].y = listofy[i].y;
                    countleft += 1;
                }

                else if (listofy[i].y > listofx[index_of_median].y)
                {
                    y_array_right[countright].x = listofy[i].x;
                    y_array_right[countright].y = listofy[i].y;
                    countright += 1;
                }
            }

            
        }
        
    }

    if (xaxis == false)
    {

        median = &listofy[index_of_median]; //give median its value when cutting by y

        //cutting by y, relatively simpler
        //y_array_left
        for (int i = 0; i < index_of_median; ++i)
        {
            y_array_left[i].x = listofy[i].x; 
            y_array_left[i].y = listofy[i].y; 
        }

        //y_array_right
        for (int i = index_of_median + 1; i < n; ++i)
        {
            y_array_right[i-(index_of_median + 1)].x =  listofy[i].x;
            y_array_right[i-(index_of_median + 1)].y =  listofy[i].y;
        }

        countleft = 0;
        countright = 0;
        //x sub arrays
        for (int i = 0; i < n; ++i)
        {
            
            if (listofx[i].y < listofy[index_of_median].y) // if in x array left
            {
                x_array_left[countleft].x = listofx[i].x;
                x_array_left[countleft].y = listofx[i].y;
                countleft += 1;
            }
            else if (listofx[i].y > listofy[index_of_median].y)
            {
                x_array_right[countright].x = listofx[i].x;
                x_array_right[countright].y = listofx[i].y;
                countright += 1;
            }
            else
            {
                if (listofx[i].x < listofy[index_of_median].x) //tie break when y is equal by x
                {
                    x_array_left[countleft].x = listofx[i].x;
                    x_array_left[countleft].y = listofx[i].y;
                    countleft += 1;
                }
                else if (listofx[i].x > listofy[index_of_median].x)
                {
                    x_array_right[countright].x = listofx[i].x;
                    x_array_right[countright].y = listofx[i].y;
                    countright += 1;
                }
            }

            
        }


    }
  
    return median; //return the median value

}



