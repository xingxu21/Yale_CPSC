    #define _GNU_SOURCE

#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>

#include "lugraph.h"

struct lugraph
{
  int n;          // the number of vertices
  int *list_size; // the size of each adjacency list
  int *list_cap;  // the capacity of each adjacency list
  int **adj;      // the adjacency lists
};

struct lug_search
{
  const lugraph *g;
  int from;
  int *dist;
  int *pred;
};

#define LUGRAPH_ADJ_LIST_INITIAL_CAPACITY 4

/**
 * Resizes the adjacency list for the given vertex in the given graph.
 * 
 * @param g a pointer to a directed graph
 * @param from the index of a vertex in that graph
 */
void lugraph_list_embiggen(lugraph *g, int from);

/**
 * Prepares a search result for the given graph starting from the given
 * vertex.  It is the responsibility of the caller to destroy the result.
 *
 * @param g a pointer to a directed graph
 * @param from the index of a vertex in that graph
 * @return a pointer to a search result
 */
lug_search *lug_search_create(const lugraph *g, int from);

/**
 * Adds the to vertex to the from vertex's adjacency list.
 *
 * @param g a pointer to a graph, non-NULL
 * @param from the index of a vertex in g
 * @param to the index of a vertex in g
 */
void lugraph_add_half_edge(lugraph *g, int from, int to);









lugraph *lugraph_create(int n)
{
  if (n < 1)
    {
      return NULL;
    }
  
  lugraph *g = malloc(sizeof(lugraph));
  if (g != NULL)
    {
      g->n = n;
      g->list_size = malloc(sizeof(int) * n);
      g->list_cap = malloc(sizeof(int) * n);
      g->adj = malloc(sizeof(int *) * n);
      
      if (g->list_size == NULL || g->list_cap == NULL || g->adj == NULL)
	{
	  free(g->list_size);
	  free(g->list_cap);
	  free(g->adj);
	  free(g);

	  return NULL;
	}

      for (int i = 0; i < n; i++)
	{
	  g->list_size[i] = 0;
	  g->adj[i] = malloc(sizeof(int) * LUGRAPH_ADJ_LIST_INITIAL_CAPACITY);
	  g->list_cap[i] = g->adj[i] != NULL ? LUGRAPH_ADJ_LIST_INITIAL_CAPACITY : 0;
	}
    }

  return g;
}








int lugraph_size(const lugraph *g)
{
  if (g != NULL)
    {
      return g->n;
    }
  else
    {
      return 0;
    }
}







void lugraph_list_embiggen(lugraph *g, int from)
{
  if (g->list_cap[from] != 0)
    {
      int *bigger = realloc(g->adj[from], sizeof(int) * g->list_cap[from] * 2);
      if (bigger != NULL)
	{
	  g->adj[from] = bigger;
	  g->list_cap[from] = g->list_cap[from] * 2;
	}
    }
}







void lugraph_add_edge(lugraph *g, int from, int to)
{
  if (g != NULL && from >= 0 && to >= 0 && from < g->n && to < g->n && from != to)
    {
      lugraph_add_half_edge(g, from, to);
      lugraph_add_half_edge(g, to, from);
    }
}








void lugraph_add_half_edge(lugraph *g, int from, int to)
{
  if (g->list_size[from] == g->list_cap[from])
    {
      lugraph_list_embiggen(g, from);
    }
  
  if (g->list_size[from] < g->list_cap[from])
    {
      g->adj[from][g->list_size[from]++] = to;
    }
}









bool lugraph_has_edge(const lugraph *g, int from, int to)
{
  if (g != NULL && from >= 0 && to >= 0 && from < g->n && to < g->n && from != to)
    {
      int i = 0;
      while (i < g->list_size[from] && g->adj[from][i] != to)
	{
	  i++;
	}
      return i < g->list_size[from];
    }
  else
    {
      return false;
    }
}







int lugraph_degree(const lugraph *g, int v)
{
  if (g != NULL && v >= 0 && v < g->n)
    {
      return g->list_size[v];
    }
  else
    {
      return -1;
    }
}





//queue used for bfs search. queue, enqueue, and deque inspired by code from Programiz.com 
typedef struct queue 
  {
    int *items;
    int front;
    int rear;
  } queue;


//functions used qith queue
void enqueue(struct queue* q, int value, int number_vertices)
{
  if(q->rear == number_vertices -1)
      printf("\nQueue is Full!!");
  else 
    {
      if(q->front == -1)
      {
          q->front = 0;
      }
      
      q->rear++;
      q->items[q->rear] = value;
    }
}


int dequeue(struct queue* q)
{ 
  if (q->rear != -1)
  {
    int item = q->items[q->front];
    q->front++;
    
    if(q->front > q->rear)
    {
      q->front = q->rear = -1;
    }

    return item;
  } 

  else
  {
  return -1;
  }
}



lug_search *lugraph_bfs(const lugraph *g, int from)
{
  //if g is null or if from is not in g
  if (g == NULL || from >= g->n || from < 0)
  {
    return  NULL;
  }
  int number_vertices = g->n;


  //call lug_search_create to create the struct we will eventually return
  lug_search *search_struct = lug_search_create(g, from);
  if (search_struct == NULL)
  {
    return NULL;
  }


  //malloc and initialize queue to be used later
  queue *q = malloc(sizeof(queue));
  if (q == NULL)
  {
    free(search_struct);
    return  NULL;
  }
  q->front       = -1;
  q->rear        = -1;
  q->items       = malloc(sizeof(int) * number_vertices);
  //initialize everuthing in items to be -1
  for (int i = 0; i < number_vertices; ++i)
  {
    q->items[i] = -1;
  }


  //malloc and initialize visited array
  int  *visited = malloc(sizeof(int) * number_vertices);
  for (int i = 0; i < number_vertices; ++i)
  {
    visited[i] = 0;
  }


  //start the BFS algorithm
  enqueue(q, from, number_vertices);

  search_struct->pred[from] = -2;//set pred of from to be something
  search_struct->dist[from] = 0;//set distance for the first thing to be zero
  visited[from] = 1;//make sure we say that we have already visited from

  //while queue is not empty
  while(q->rear != -1)
  {
    int current = dequeue(q); //get the first element in queue

    for (int i = 0; i < g->list_size[current]; ++i) //enque each thing in the adjacency list of current after we make sure we haven't been to current already
    {
      if (visited[g->adj[current][i]] == 0)
      {
        visited[g->adj[current][i]] = 1;//set this node to be visited
        enqueue(q, g->adj[current][i], number_vertices); //enque everything in the adjacency matrix of current
        search_struct->pred[g->adj[current][i]] = current; //set whatever we reached from current to have predecesor current
        search_struct->dist[g->adj[current][i]] = search_struct->dist[current] + 1;//set the distance for the next thing that we reached after current to be one more than the current's distance
      }
    }
  }

  free(q->items);
  free(q);
  free(visited);
  return  search_struct;
}







bool lugraph_connected(const lugraph *g, int from, int to)
{
  if (g == NULL || from >= g->n || to >= g->n || from < 0 || to < 0) //error checking
  {
    return false;
  }

  lug_search *search_struct = lugraph_bfs(g, from); //set the output lug_search type struct from bfs to search_struct

  if (search_struct->dist[to] != -1)//if the value at index [to] in the distance array is not the initial value, this means that it is connected
  {
    lug_search_destroy(search_struct); //free the lug_search struct
    return true;//return true
  }

  else//sad, it wasn't connected
  {
  lug_search_destroy(search_struct);//free the lug_search struct
  return false;//return false
  }
}







void lugraph_destroy(lugraph *g)
{
  if (g != NULL)
    {
      for (int i = 0; i < g->n; i++)
	{
	  free(g->adj[i]);
	}
      free(g->adj);
      free(g->list_cap);
      free(g->list_size);
      free(g);
    }
}




lug_search *lug_search_create(const lugraph *g, int from)
{
  if (g != NULL && from >= 0 && from < g->n)
    {
      lug_search *s = malloc(sizeof(lug_search));
      
      if (s != NULL)
	{
	  s->g = g;
	  s->from = from;
	  s->dist = malloc(sizeof(int) * g->n);
	  s->pred = malloc(sizeof(int) * g->n);

	  if (s->dist != NULL && s->pred != NULL)
	    {
	      for (int i = 0; i < g->n; i++)
		{
		  s->dist[i] = -1;
		  s->pred[i] = -1;
		}
	    }
	  else
	    {
	      free(s->pred);
	      free(s->dist);
	      free(s);
	      return NULL;
	    }
	}

      return s;
    }
  else
    {
      return NULL;
    }
}






int lug_search_distance(const lug_search *s, int to)
{
  if (s == NULL || to >= s->g->n || to < 0)
  {
    return -1;
  }
  return s->dist[to];
}






int* lug_search_path(const lug_search *s, int to, int *len)
{
  if (len == NULL || s == NULL || to >= s->g->n || to < 0)//error checking
  {
   *len = -1;//set len to -1
   return NULL;//Return NULL 
  }

  *len = s->dist[to]; //len is going to be distance to the point "to"
  int length = *len; //get length easily accessable

  //malloc the array that will hold the path
  int *path = malloc(sizeof(int) * (length + 1));

  for (int i = length; i >= 0; --i)//fill in path towards the front from the back
  {
      path[i] = to; 
      to = s->pred[to];
  }
  return path; //return the pointer to the path
}





void lug_search_destroy(lug_search *s)
{
  if (s != NULL)
    {
      free(s->dist);
      free(s->pred);
      free(s);
    }
}
