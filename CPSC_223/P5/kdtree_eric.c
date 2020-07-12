
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "location.h"

/**
 * A set of geographic locations given by latitude and longitude
 * implemented using a k-d tree, where k = 2.  For all functions,
 * points are considered different based on the values of the
 * coordinates that are passed in, even if the coordinates represent
 * the same physical point, so, for example, longitude -180 is
 * considered different than longitude 180.
 */
typedef struct _kdtree 
{
    bool axis;//true if x, false if y
    location *pt;
    struct _kdtree *rchild;
    struct _kdtree *lchild;

} kdtree;

void location_merge(int n1, location **a1, int n2, location **a2, location **out, bool axis)
{
    int i1;
    int i2;
    int iout;
    int dupes;
    i1=i2=iout=dupes=0;

    while(i1 < n1 || i2 <n2)
    {
        if (axis)
        {
            if (i2 >= n2 || ((i1 < n1) && (a1[i1]->x < a2[i2]->x)))
            {
                out[iout++] = a1[i1++];
            }
            else if ((i1 >= n1) || ((i2 < n2) && a1[i1]->x > a2[i2]->x))
            {
                out[iout++] = a2[i2++];
            }
            else
            {
                if (i2 >= n2 || ((i1 < n1) && (a1[i1]->y < a2[i2]->y)))
                {
                    out[iout++] = a1[i1++];
                }
                else //if (i1 > n1 || ((i2 < n2) && (a1[i1]->y > a2[i2]->y)))
                {
                    out[iout++] = a2[i2++];
                }
            }
        }
        else
        {
            if (i2 >= n2 || ((i1 < n1) && (a1[i1]->y < a2[i2]->y)))
            {
                out[iout++] = a1[i1++];
            }
            else if(i1 >= n1 || ((i2 < n2) && a1[i1]->y > a2[i2]->y))
            {
                out[iout++] = a2[i2++];
            }
            else
            {
                if (i2 >= n2 || ((i1 < n1) && (a1[i1]->x < a2[i2]->x)))
                {
                    out[iout++] = a1[i1++];
                }
                else //if (i1 >= n1 || ((i2 < n2) && a1[i1]->x > a2[i2]->x))
                {
                    out[iout++] = a2[i2++];
                }
                
            }
        }
        
    }
}

void location_merge_sort(int n, location **a, location **out, bool axis)
{
    location **a1;
    location **a2;
    if (n < 2)
    {
        memcpy(out, a, sizeof(location*) * n);
    }
    else
    {
        a1 = malloc(sizeof(location*) * n/2);
        a2 = malloc(sizeof(location*) * (n- n/2));

        location_merge_sort(n/2, a, a1, axis);
        location_merge_sort(n - n/2, a + n/2, a2, axis);

        location_merge(n/2, a1, n - n/2, a2, out, axis);
        
        free(a1);
        free(a2);
    }
}

//returns true if next row was successfully added; false if not
//takes a node w/ a location and the sorted x and y arrs of that
//node, splits them, finds its children, and performs a recursive call
//on the children
//parameters: n is the length of the arrays, node is current node, x and yarrs contain
//  the current node and will be split to find the child nodes
void kdtree_balanced_add(kdtree *node, int n, location **arr1, location **arr2)
{
    //location **arr1; location **arr2;
    bool curraxis = node->axis;
    /*if (curraxis)
    {
        arr1=xarr;
        arr2=yarr;
    }
    else
    {
        arr1=yarr;
        arr2=xarr;
    }*/
    if (n==1 || n==0)
    {
        node->rchild = NULL;
        node->lchild = NULL;
        return;
    }
    if (n==2)
    {
        if(!curraxis)
        {
            if(arr1[0]->x == node->pt->x && arr1[0]->y == node->pt->y)
            {
                //index 0 is the location of parent node
                //index 1 is the location of child node
                if (arr1[1]->x < node->pt->x)
                {
                    node->lchild = malloc(sizeof(kdtree));
                    node->lchild->pt = arr1[1];
                    node->lchild->axis = !curraxis;
                    node->lchild->lchild = NULL;
                    node->lchild->rchild = NULL;
                    node->rchild = NULL;
                }
                else if (arr1[1]->x > node->pt->x)
                {
                    node->rchild = malloc(sizeof(kdtree));
                    node->rchild->pt = arr1[1];
                    node->rchild->axis= !curraxis;
                    node->rchild->lchild = NULL;
                    node->rchild->rchild = NULL;
                    node->lchild = NULL;
                }
                else
                {
                    if (arr1[1]->y < node->pt->y)
                    {
                        node->lchild = malloc(sizeof(kdtree));
                        node->lchild->pt = arr1[1];
                        node->lchild->axis = !curraxis;
                        node->lchild->lchild = NULL;
                        node->lchild->rchild = NULL;
                        node->rchild = NULL;
                    }
                    else
                    {
                        node->rchild = malloc(sizeof(kdtree));
                        node->rchild->pt = arr1[1];
                        node->rchild->axis = !curraxis;
                        node->rchild->lchild = NULL;
                        node->rchild->rchild = NULL;
                        node->lchild = NULL;
                    }
                }
            }
            else
            {
                if (arr1[0]->x < node->pt->x)
                {
                    node->lchild = malloc(sizeof(kdtree));
                    node->lchild->pt = arr1[0];
                    node->lchild->axis = !curraxis;
                    node->lchild->lchild = NULL;
                    node->lchild->rchild = NULL;
                    node->rchild = NULL;
                }
                else if (arr1[0]->x > node->pt->x)
                {
                    node->rchild = malloc(sizeof(kdtree));
                    node->rchild->pt = arr1[0];
                    node->rchild->axis = !curraxis;
                    node->rchild->lchild = NULL;
                    node->rchild->rchild = NULL;
                    node->lchild = NULL;
                }
                else
                {
                    if (arr1[0]->y < node->pt->y)
                    {
                        node->lchild = malloc(sizeof(kdtree));
                        node->lchild->pt = arr1[0];
                        node->lchild->axis = !curraxis;
                        node->lchild->lchild = NULL;
                        node->lchild->rchild = NULL;
                        node->rchild = NULL;
                    }
                    else 
                    {
                        node->rchild = malloc(sizeof(kdtree));
                        node->rchild->pt = arr1[0];
                        node->rchild->axis= !curraxis;
                        node->rchild->lchild = NULL;
                        node->rchild->rchild = NULL;
                        node->lchild = NULL;
                    }
                }
            }
        }
        else
        {
            if(arr1[0]->x == node->pt->x && arr1[0]->y == node->pt->y)
            {
                if (arr1[1]->y < node->pt->y)
                {
                    node->lchild = malloc(sizeof(kdtree));
                    node->lchild->pt = arr1[1];
                    node->lchild->axis = !curraxis;
                    node->lchild->lchild = NULL;
                    node->lchild->rchild = NULL;
                    node->rchild = NULL;
                }
                else if (arr1[1]->y > node->pt->y)
                {
                    node->rchild = malloc(sizeof(kdtree));
                    node->rchild->pt = arr1[1];
                    node->rchild->axis = !curraxis;
                    node->rchild->lchild = NULL;
                    node->rchild->rchild = NULL;
                    node->lchild = NULL;
                }
                else
                {
                    if (arr1[1]->x < node->pt->x)
                    {
                        node->lchild = malloc(sizeof(kdtree));
                        node->lchild->pt = arr1[1];
                        node->lchild->axis = !curraxis;
                        node->lchild->lchild = NULL;
                        node->lchild->rchild = NULL;
                        node->rchild = NULL;
                    }
                    else 
                    {
                        node->rchild = malloc(sizeof(kdtree));
                        node->rchild->pt = arr1[1];
                        node->rchild->axis= !curraxis;
                        node->rchild->lchild = NULL;
                        node->rchild->rchild = NULL;
                        node->lchild = NULL;
                    }
                }
                
            }
            else
            {
                if (arr1[0]->y < node->pt->y)
                {
                    node->lchild = malloc(sizeof(kdtree));
                    node->lchild->pt = arr1[0];
                    node->lchild->axis = !curraxis;
                    node->lchild->lchild = NULL;
                    node->lchild->rchild = NULL;
                    node->rchild = NULL;
                }
                else if (arr1[0]->y > node->pt->y)
                {
                    node->rchild = malloc(sizeof(kdtree));
                    node->rchild->pt = arr1[0];
                    node->rchild->axis = !curraxis;
                    node->rchild->lchild = NULL;
                    node->rchild->rchild = NULL;
                    node->lchild = NULL;
                }
                else
                {
                    if (arr1[0]->x < node->pt->x)
                    {
                        node->lchild = malloc(sizeof(kdtree));
                        node->lchild->pt = arr1[0];
                        node->lchild->axis = !curraxis;
                        node->lchild->lchild = NULL;
                        node->lchild->rchild = NULL;
                        node->rchild = NULL;
                    }
                    else 
                    {
                        node->rchild = malloc(sizeof(kdtree));
                        node->rchild->pt = arr1[0];
                        node->rchild->axis= !curraxis;
                        node->rchild->lchild = NULL;
                        node->rchild->rchild = NULL;
                        node->lchild = NULL;
                    }
                }
                
            }
        }
        return;
    }
    
    node->lchild = malloc(sizeof(kdtree));
    node->rchild = malloc(sizeof(kdtree));
    //declare the left and right arrays, where arr1 refers to the "primary" axis (that is being split)
    //and arr2 is the "secondary" axis (for tiebreakers, and also what the parent node was split by)
    location **larr1; location **rarr1;
    location **larr2; location **rarr2;
    //if this node is split along x, then the prior node was split by y, and 
    //             thus this node is the median (index n/2) of the yarr
    larr2 = malloc(sizeof(location*) * n/2);
    memcpy(larr2, arr2, n/2 * sizeof(location*));
    rarr2 = malloc(sizeof(location*) * (n-n/2-1));
    memcpy(rarr2, arr2 + n/2 + 1, sizeof(location*) * (n-n/2-1));

    larr1 = malloc(sizeof(location*) * n/2);
    rarr1 = malloc(sizeof(location*) * (n-n/2-1));
    int counter1 = 0;
    int counter2 = 0;
    if (curraxis)
    {
        for (int i = 0; i < n; i++)
        {
            if(arr1[i]->y < node->pt->y)
            {
                larr1[counter1] = arr1[i];
                counter1++;
            }
            else if (arr1[i]->y > node->pt->y)
            {
                rarr1[counter2] = arr1[i];
                counter2++;
            }
            else
            {
                if(arr1[i]->x < node->pt->x)
                {
                    larr1[counter1] = arr1[i];
                    counter1++;
                }
                else if(arr1[i]->x > node->pt->x)
                {
                    rarr1[counter2] = arr1[i];
                    counter2++;
                } 
            }
        }
        node->lchild->pt = larr1[(n/2)/2];
        node->lchild->axis = !curraxis;
        kdtree_balanced_add(node->lchild, n/2, larr2, larr1);
        node->rchild->pt = rarr1[(n-n/2-1)/2];
        node->rchild->axis = !curraxis;
        kdtree_balanced_add(node->rchild, (n-n/2-1), rarr2, rarr1);
        
    }
    else
    {
        for (int i = 0; i < n; i++)
        {
            if(arr1[i]->x < node->pt->x)
            {
                larr1[counter1] = arr1[i];
                counter1++;
            }
            else if (arr1[i]->x > node->pt->x)
            {
                rarr1[counter2] = arr1[i];
                counter2++;
            }
            else
            {
                if(arr1[i]->y < node->pt->y)
                {
                    larr1[counter1] = arr1[i];
                    counter1++;
                }
                else if(arr1[i]->y > node->pt->y)
                {
                    rarr1[counter2] = arr1[i];
                    counter2++;
                } 
            }
        }
        node->lchild->pt = larr1[(n/2)/2];
        node->lchild->axis = !curraxis;
        kdtree_balanced_add(node->lchild, n/2, larr2, larr1);
        node->rchild->pt = rarr1[(n-n/2-1)/2];
        node->rchild->axis = !curraxis;
        kdtree_balanced_add(node->rchild, (n-n/2-1), rarr2, rarr1);
    }
    
    free(larr1);
    free(larr2);
    free(rarr1);
    free(rarr2);
}

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
kdtree *kdtree_create(const location *pts, int n)
{
    if (pts == NULL || n==0)
    {
        kdtree *node = malloc(sizeof(kdtree));
        node->axis = false;
        node->lchild = NULL;
        node->rchild = NULL;
        node->pt = NULL;
        return node;
    }
    location **ptarray = malloc(n * sizeof(location*));
    for (int i = 0; i < n; i++)
    {
        ptarray[i] = malloc(sizeof(location));
        ptarray[i]->x = pts[i].x;
        ptarray[i]->y = pts[i].y;
    }
    
    location **xarray = malloc(n*sizeof(location*));
    location **yarray = malloc(n*sizeof(location*));
    location_merge_sort(n, ptarray, xarray, true);
    for (int i = 0; i < n-1; i++)
    {
        if (xarray[i]->x ==xarray[i+1]->x && xarray[i]->y == xarray[i+1]->y)
        {
            return NULL;
        }
    }
    location_merge_sort(n, ptarray, yarray, false);
    free(ptarray);

    kdtree *root = malloc(sizeof(kdtree));
    root->axis = false;
    root->pt = xarray[n/2];
    kdtree_balanced_add(root, n, yarray, xarray);
    free(xarray);
    free(yarray);
    return root;
}

bool kdtree_contains(const kdtree *t, const location *p);

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
bool kdtree_add(kdtree *t, const location *p)
{
    if(p == NULL)
    {
        return false;
    }
    bool contains = kdtree_contains(t,p);
    if(contains)
    {
        return false;
    }
    if(t->pt==NULL)
    {
        t->pt = malloc(sizeof(location));
        t->pt->x=p->x;
        t->pt->y=p->y;
        return true;
    }
    kdtree *currnode = t;
    kdtree *prevnode;
    bool leftchild;
    bool curraxis = t->axis;
    while(currnode!=NULL)
    {
        prevnode=currnode;
        if(!curraxis)
        {
            if(p->x < currnode->pt->x)
            {
                currnode = currnode->lchild;
                leftchild = true;
            }
            else if (p->x > currnode->pt->x)
            {
                currnode = currnode->rchild;
                leftchild=false;
            }
            else
            {
                if(p->y < currnode->pt->y)
                {
                    currnode = currnode->lchild;
                    leftchild=true;
                }
                else 
                {
                    currnode = currnode->rchild;
                    leftchild=false;
                }
            }
        }
        else
        {
            if(p->y < currnode->pt->y)
            {
                currnode = currnode->lchild;
                leftchild=true;
            }
            else if (p->y > currnode->pt->y)
            {
                currnode = currnode->rchild;
                leftchild=false;
            }
            else
            {
                if(p->x < currnode->pt->x)
                {
                    currnode = currnode->lchild;
                    leftchild = true;
                }
                else 
                {
                    currnode = currnode->rchild;
                    leftchild=false;
                }
            }
        }
        curraxis=!curraxis;
    }
    t=malloc(sizeof(kdtree));
    if(leftchild)
    {
        prevnode->lchild = t;
    }
    else
    {
        prevnode->rchild = t;
    }
    t->axis = curraxis;
    t->lchild = NULL;
    t->rchild=NULL;
    t->pt = malloc(sizeof(location));
    t->pt->x = p->x;
    t->pt->y = p->y;
    return true;
}

/**
 * Determines if the given tree contains a point with the same coordinates
 * as the given point.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param p a pointer to a valid location, non-NULL
 * @return true if and only of the tree contains the location
 */
bool kdtree_contains(const kdtree *t, const location *p)
{
    if(t==NULL || p==NULL || t->pt==NULL)
    {
        return false;
    }
    if (t->pt->x == p->x && t->pt->y==p->y)
    {
        return true;
    }
    kdtree *currnode = t;
    while(currnode != NULL)
    {
        if(currnode->pt->x == p->x && currnode->pt->y == p->y)
        {
            return true;
        }
        else
        {
            if(!currnode->axis)
            {
                if (p->x < currnode->pt->x)
                {
                    currnode=currnode->lchild;
                }
                else if (p->x > currnode->pt->x)
                {
                    currnode=currnode->rchild;
                }
                else
                {
                    if(p->y < currnode->pt->y)
                    {
                        currnode=currnode->lchild;
                    }
                    else
                    {
                        currnode=currnode->rchild;
                    }
                }
                
                
            }
            else
            {
                if(p->y < currnode->pt->y)
                {
                    currnode=currnode->lchild;
                }
                else if (p->y > currnode->pt->y)
                {
                    currnode=currnode->rchild;
                }
                else
                {
                    if (p->x < currnode->pt->x)
                    {
                        currnode=currnode->lchild;
                    }
                    else 
                    {
                        currnode=currnode->rchild;
                    }
                }
                
            }
        }
    }
    return false;
    
    
}

void kdtree_nearest_helper(kdtree *t,  bool left, location *blcorner, location *trcorner, kdtree *prev,
    const location *p, location *neighbor, double *d)
{
    if (t == NULL || t->pt == NULL || d ==0 || p==NULL)
    {
        return;
    }
    
    //region check
    if (!prev->axis)
    {
        if (left)
        {
            trcorner->x = prev->pt->x;
        }
        else
        {
            blcorner->x = prev->pt->x;
        }
    }
    else
    {
        if (left)
        {
            trcorner->y = prev->pt->y;
        }
        else
        {
            blcorner->y = prev->pt->y;
        }
    }
    if(fabs(location_distance_to_rectangle(p, blcorner, trcorner)) > *d)
    {
        return;
    }

    double currd = fabs(location_distance(p, t->pt));
    if (currd < *d)
    {
        neighbor->x = t->pt->x;
        neighbor->y = t->pt->y;
        *d = currd;
    }

    location *blcornerL = malloc(sizeof(location));
    location *trcornerL = malloc(sizeof(location));
    location *blcornerR = malloc(sizeof(location));
    location *trcornerR = malloc(sizeof(location));
    if(!t->axis)
    {
        blcornerL->x = blcorner->x;
        blcornerL->y = blcorner->y;
        trcornerL->x = t->pt->x;
        trcornerL->y = trcorner->y;

        blcornerR->x = t->pt->x;
        blcornerR->y = blcorner->y;
        trcornerR->x = trcorner->x;
        trcornerR->y = trcorner->y;
    }
    else
    {
        blcornerL->x = blcorner->x;
        blcornerL->y = blcorner->y;
        trcornerL->x = trcorner->x;
        trcornerL->y = t->pt->y;

        blcornerR->x = blcorner->x;
        blcornerR->y = t->pt->y;
        trcornerR->x = trcorner->x;
        trcornerR->y = trcorner->y;
    }

    if(!t->axis)
    {
        if (p->x < t->pt->x)
        {
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
        }
        else if (p->x < t->pt->x)
        {
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
        }
        else
        {
            if (p->y < t->pt->y)
            {
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            }
            else
            {
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            }
        }
    }
    else
    {
        if (p->y < t->pt->y)
        {
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
        }
        else if (p->y < t->pt->y)
        {
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
        }
        else
        {
            if (p->x < t->pt->x)
            {
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            }
            else
            {
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            }
        }
    }
    free(blcornerL);
    free(blcornerR);
    free(trcornerL);
    free(trcornerR);
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
void kdtree_nearest_neighbor(kdtree *t, const location *p, location *neighbor, double *d)
{
    if (t == NULL || t->pt == NULL || d ==0 || p==NULL)
    {
        *d = INFINITY;
        return;
    }
    if(kdtree_contains(t, p))
    {
        *d=0;
        neighbor->x = p->x;
        neighbor->y = p->y;
        return;
    }
    *d=fabs(location_distance(t->pt, p));
    neighbor->x = t->pt->x;
    neighbor->y = t->pt->y;

    location *blcornerL = malloc(sizeof(location));
    location *trcornerL = malloc(sizeof(location));
    location *blcornerR = malloc(sizeof(location));
    location *trcornerR = malloc(sizeof(location));
    if(!t->axis)
    {
        blcornerL->x = -1 * INFINITY;
        blcornerL->y = -1 * INFINITY;
        trcornerL->x = t->pt->x;
        trcornerL->y = INFINITY;

        blcornerR->x = t->pt->x;
        blcornerR->y = -1 * INFINITY;
        trcornerR->x = INFINITY;
        trcornerR->y = INFINITY;
    }
    else
    {
        blcornerL->x = -1 * INFINITY;
        blcornerL->y = -1 * INFINITY;
        trcornerL->x = INFINITY;
        trcornerL->y = t->pt->y;

        blcornerR->x = -1*INFINITY;
        blcornerR->y = t->pt->y;
        trcornerR->x = INFINITY;
        trcornerR->y = INFINITY;
    }

    if(!t->axis)
    {
        if (p->x < t->pt->x)
        {
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
        }
        else if (p->x < t->pt->x)
        {
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
        }
        else
        {
            if (p->y < t->pt->y)
            {
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            }
            else
            {
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            }
        }
    }
    else
    {
        if (p->y < t->pt->y)
        {
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
        }
        else if (p->y < t->pt->y)
        {
            kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
        }
        else
        {
            if (p->x < t->pt->x)
            {
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
            }
            else
            {
                kdtree_nearest_helper(t->rchild, false, blcornerR, trcornerR, t, p, neighbor, d);
                kdtree_nearest_helper(t->lchild, true, blcornerL, trcornerL, t, p, neighbor, d);
            }
        }
    }
    free(blcornerL);
    free(blcornerR);
    free(trcornerL);
    free(trcornerR);
}

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
void kdtree_for_each(const kdtree* r, void (*f)(const location *, void *), void *arg)
{
    if (!(r == NULL|| r->pt == NULL))
    {
        kdtree_for_each(r->lchild, f, arg);
        f(r->pt, arg);
        kdtree_for_each(r->rchild, f, arg);
    }
    
}

/**
 * Destroys the given k-d tree.  The tree is invalid after being destroyed.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 */
void kdtree_destroy(kdtree *t)
{
    if(t != NULL)
    {
        if (t->lchild != NULL)
        {
            kdtree_destroy(t->lchild);
        }
        if (t->rchild != NULL)
        {
            kdtree_destroy(t->rchild);
        }
        if(t->pt != NULL)
        {
            free(t->pt);
        }
    }
    free(t);
}

