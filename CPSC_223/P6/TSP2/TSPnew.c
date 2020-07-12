#include <stddef.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "location.h"
#include "lugraph.h"


//struct with information about city and a nested location struct
typedef struct cityandlocation
	{
		char name[4];
		int beenthere;            //we set as 0 if we have not been to this city before
		int number;
		location loc;
	} cityandloc;


int* reorder(int *unordered_array, int size) //takes in an array and reorders it to start at zero. returns pointer to reordered array
{
	if (unordered_array == NULL)
	{
		return NULL;
	}

	int temporary[size];//create a temporary array to help with reordering
	int *output = malloc(sizeof(int) * size);//the output array
	if (output == NULL)
	{
		return NULL;
	}

	int found_zero = 0; //boolean for if we have found zero
	int count = 0; //initialize count, this is the index of output where we will put the next element
	for (int i = 0; i < size - 1; ++i)//iterate though the input array untill reach 0. Put that into the first element of output array and fill in the rest of of the things into the unordered array into the output array. This deals only with the things in the unordered array that come after 0 (and the zero).
	{
		if (unordered_array[i] != 0 && found_zero == 0) //if the current element of the arrray is not zero and we have not found zero yet, put it into the temp array
		{
			temporary[i] = unordered_array[i];
		}

		else if (unordered_array[i] == 0) //if we find zero, put it as the first element of the output array and set found_zero to be 1
		{
			found_zero = 1;
			output[count] = 0;
		}

		else if (unordered_array[i] != 0 && found_zero == 0)  //if the current element is not zero and we have already seen zero, put it into the 
		{
			count++;//iterate count by adding one
			output[count] = unordered_array[i]; //set index count of the output array to be the value current thing in the unordered array
		}
	}


	for (int i = 0; i < size - (count + 1); ++i)//there should be size - (count +1) things in the temporary array (this part takes care of the things that came before 0 in the unordered array)
	{
		count++; //iterate count by 1
		output[count] = temporary[i];
	}

	return output;
}




void printmyshit(int* sorted_array, cityandloc *arrayofcities, int size)//takes an array of ints and prints out the city code at each index. 
{
	//first, we get the total distance
	double totaldistance = 0;//initialize the total distance. 

	for (int i = 0; i < size - 1; ++i)
	{
		totaldistance = totaldistance + location_distance(&arrayofcities[sorted_array[i]].loc, 
			&arrayofcities[sorted_array[i+1]].loc);
	}

	totaldistance = totaldistance + location_distance(&arrayofcities[sorted_array[0]].loc,
		&arrayofcities[sorted_array[size - 1]].loc); //add the distance from going back to the starting point

	//now we print 
	printf("-greedy         :");//print that we used greedy
	printf("%10.2f", totaldistance);//print the total distance
	for (int i = 0; i < size; ++i)//print the name of each city in the order of the sorted array
	{
		printf(" %s", arrayofcities[sorted_array[i]].name);
	}

	printf(" %s", arrayofcities[sorted_array[0]].name);//print the final element in the path (looping back to the begining)
}


typedef struct pairs //struct for pairs
{
	int from;
	int to;
	double distance;
}pair;

int comparison(const void *a1, const void *a2)
{
	if (a1 == NULL || a2 == NULL)
	{
		return 0;
	}
	pair* pair1 = (pair*) a1;
	pair* pair2 = (pair*) a2;

	if (pair1->distance < pair2->distance)
	{
		return -1;
	}

	else if (pair1->distance == pair2->distance)
	{
		return 0;
	}

	else
	{
		return 1;
	}
}


int* greedy_fn(int size,  cityandloc *arrayofcities)
{
	int*	unordered_array; //initialize the unordered array of cities that will be filled in by greedy. This will then be passed on to reorder which will return a sorted_array.

	pair list_pairs[size*size]; //list of all the pairs

///////////////////////////////////////////////////////////////////////////////////////////
//create matrix2d with all the distance between all cities

	//array with distances between all cities
	double matrix2d[size][size];

	for (int i = 0; i < size; ++i)
	{
		for (int j = 0; j < size; ++j)
		{
			matrix2d[i][j] = location_distance(&arrayofcities[i].loc, &arrayofcities[j].loc);
		}
	}

	//populate the list_pairs
	for (int i = 0; i < size; ++i)
	{
		for (int j = 0; j < size; ++j)
		{
			list_pairs[i*size +j].from = i;
			list_pairs[i*size +j].to = j;
			list_pairs[i*size +j].distance = matrix2d[i][j];
		}
	}

	qsort(&list_pairs, size*size, sizeof(pair), &comparison); //list pairs is now sorted

	//start with an empty partial tour (lugraph_create(size). creates a graph that has all the vertices but they are not connected so there are no vertices)
	lugraph *graph = lugraph_create(size);
	if (graph == NULL)
	 {
	 	return NULL;
	 } 


	//now we fill in the adjacency lists. 
	//we go though our list_pairs. for each thing in list pairs, if from and to are not connected (call lugraph connected), and if the degree of both to and from are less than 2, we add the edge to the graph (lugraph_add) 
	for (int i = 0; i < size*size; ++i)//iterate through everything in list_pairs
	{
		if (lugraph_connected(graph, list_pairs[i].from, list_pairs[i].to) //if from and to are not connected and they both have degree less than 2
			&& lugraph_degree(graph, list_pairs[i].from) < 2
			&& lugraph_degree(graph, list_pairs[i].to) < 2)
		{
			lugraph_add_edge(graph, list_pairs[i].from, list_pairs[i].to);
		}

		else
		{
			return NULL;
		}
	}

	//run graph degree on the graph. We have two int variables, deg1_1, deg1_2. These are the two endpoints of our graph which is acrually just a simple path. 
	int deg1_1, deg1_2, found_first = 0;

	for (int i = 0; i < size; ++i)//iterate though each node
	{
		if (found_first == 0 && lugraph_degree(graph, i) == 1)
		{
			found_first = 1;
			deg1_1 = i;
		}

		else if (found_first == 1 && lugraph_degree(graph, i) == 1)
		{
			deg1_2 = i;
		}

		else
		{
			continue;
		}
	}

	//now we run bfs on the graph to get our search struct (from for bfs is going to be deg1_1)
	lug_search *search_struct = bfs(graph, deg1_1);


	//now we run path function on the search struct (to will be de1_2, from is still deg1_1)
	unordered_array = lugraph_search_path(search_struct, deg1_1, deg1_2);

	//now we reorder the path we got from the path function
	int* sorted_array = reorder(unordered_array, size); //set the output of reorder to be this sorted array

	//now we take the reorderdered list, pass it to printmyshit along with the listofcities. print will then calulate the total distace and print out the city codes as specified in the order specified by path. 
	printmyshit(sorted_array, arrayofcities, size);


	//free all the stuff after we have called everything.
	free(sorted_array);
	free(search_struct);
	return NULL;
}




int main(int argc, char const *argv[])
{
///////////////////////////////////////////////////////////////////////////////
//read stuff in
	if (argc == 1) //error 1
	{
		fprintf( stderr, "TSP: missing filename\n");
		exit(0);
	}


	int n;
	const char *filename  = argv[1];
	FILE *inptr; 
	inptr =  fopen(filename,"r"); 

	if (inptr == NULL) //error 2
	{
		fprintf( stderr, "TSP: could not open %s\n",  filename);
		exit(0);
	}


	//saving the number of cities in n
	fscanf(inptr, "%d\n", &n);

	if (n<2) //error 3
	{
		fprintf( stderr, "TSP: too few cities\n");
		exit(0);
	}




	//save the city codes into an array citycodes[n]
	char citycodes[n][4];

	for (int i = 0; i < n; ++i)
	{
		char code[4];
		fscanf(inptr,"%s ", code);
		strcpy(citycodes[i], code);
	}

	//save the coordinates into an array coordinates[2n]
	double coordinates[2*n], coord1, coord2;

	for (int i = 0; i < n; ++i)
	{
		fscanf(inptr,"%lf %lf\n", &coord1, &coord2);
		coordinates[2*i]     = coord1;
		coordinates[(2*i)+1] = coord2;
	}



////////////////////////////////////////////////////////////////////////////////////////////
//put the  stuff we read in into structs

	cityandloc arrayofcities[n];  //array of structs of type cityandloc

	//populate  arrayofcities[n];
	for (int i = 0; i < n; ++i)
	{
		strcpy(arrayofcities[i].name,  citycodes[i]);
		arrayofcities[i].beenthere = 0; //set to 1 if we have been to this city before
		arrayofcities[i].number  = i;
		arrayofcities[i].loc.lat = coordinates[i*2];
		arrayofcities[i].loc.lon = coordinates	[(i*2)+1];
	}


///////////////////////////////////////////////////////////////////////////////////////////
//iterate though all the arguments and call the correct functions with some error checking

	for (int i = 0; i < argc; ++i)
	{
		if (strcmp(argv[i], "-greedy") == 0)
		{
			greedy_fn(n, arrayofcities);
		}

		else
		{
			printf("didn't call greedy\n");
			exit(0);
		}
	}

}
