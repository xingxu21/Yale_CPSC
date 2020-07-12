#include <stddef.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "location.h"

//struct with information about city and a nested location struct
typedef struct cityandlocation
	{
		char name[4];
		int beenthere;            //we set as 0 if we have not been to this city before
		int number;
		location loc;
	} cityandloc;

void reorder(int n, int array[n+1])
{
	int temparray[n];
	int temparray2[n];
	int temparray3[n+1];
	int indexsecondcity;
	int indexpenultimate;
	int indexwhere0;
	memcpy(temparray, array, sizeof(int)*(n));

	for (int i = 0; i < n; ++i)
	{
		if (array[i] == 0)
		 {
		 	indexwhere0 = i;
		 } 
	}


	for(int i = indexwhere0; i < n; i++)
	{
		temparray2[i-indexwhere0] = temparray[i];
		//array[i-indexwhere0] = temparray[i];
	}

	for(int i = 0; i < indexwhere0; i++)
	{
		temparray2[n-indexwhere0+i] = temparray[i];
		//array[i+indexwhere0] = temparray[i];
	} 

	for (int i = 0; i < n; ++i)
	{
		if (temparray2[i] == 1)
		{
			indexsecondcity = i;
		}
	}

	for (int i = 0; i < n; ++i)
	{
		if (temparray2[i] == n-1)
		{
			indexpenultimate = i;
		}
	}

	if (indexpenultimate < indexsecondcity)
	{
		for (int i = 0; i < n; ++i)
		{
			temparray3[i] = temparray2[n-i];
		}
	}

	else 
	{
		for (int i = 0; i < n; ++i)
		{
			temparray3[i] = temparray2[i];
		}
	}

	temparray3[n] = 0;
	memcpy(array, temparray3, sizeof(int)*(n+1));
}


void insert_nearest_helper(int *indexi_insertp, int *indexj_insertp, int n, double matrix2d[n][n]) //index i insert and index j insert will be the two closes cities for any given input found by searching the matrix
{	
	double min_distance_insert_nearest = 100000000;
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			if (matrix2d[i][j] < min_distance_insert_nearest && matrix2d[i][j] != 0)
			{
				*indexi_insertp = i;
				*indexj_insertp = j;
				min_distance_insert_nearest = matrix2d[i][j];
			}

			else
			{
				continue;
			}
		}
	}
}




void insert_farthest_helper(int *indexi_insertp, int *indexj_insertp, int n, double matrix2d[n][n]) //index i insert and index j insert will be the two furthest cities for any given input found by searching matrix
{	
	double max_distance_insert_farthest = 0;
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			if (matrix2d[i][j] > max_distance_insert_farthest)
			{
				*indexi_insertp = i;
				*indexj_insertp = j;
				max_distance_insert_farthest = matrix2d[i][j];
			}

			else
			{
				continue;
			}
		}
	}
}




double nearest_helper(int n, cityandloc *arrayofcitiescopy1, int *path_nearest) //helper function for nearest. see documentation
{
	path_nearest[0] = 0;
	double min_distance_nearest = 100000000;
	arrayofcitiescopy1[0].beenthere = 1;
	int index_of_min;
	double totaldistance = 0;                                

	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			if (arrayofcitiescopy1[j].beenthere == 1) //skip cities we have already been to
			{
				continue;
			}

			if (location_distance(&arrayofcitiescopy1[j].loc, &arrayofcitiescopy1[path_nearest[i]].loc) < min_distance_nearest) //check if the distance between the last element of path and any element of the array of cities is the min we haven't been to. if so save it to path
			{
				min_distance_nearest = location_distance(&arrayofcitiescopy1[j].loc, &arrayofcitiescopy1[path_nearest[i]].loc);
				index_of_min = j;
			}
		}
		if (min_distance_nearest == 100000000)
		{
			continue;
		}

		else 
		{
			totaldistance += min_distance_nearest;     //keeps a tally of our total distance and we don't fuck with it if the min distance isnt changed wich means we didn't go to a different city
			path_nearest[i+1] = index_of_min;
		}

		min_distance_nearest = 100000000;
		arrayofcitiescopy1[index_of_min].beenthere = 1;
	}
	totaldistance += location_distance(&arrayofcitiescopy1[0].loc, &arrayofcitiescopy1[path_nearest[n-1]].loc);
	return totaldistance;
}


void nearest_fn(int n, cityandloc *arrayofcities, char citycodes[n][4]) //functon for -nearest
{
	char output[n+2][4];
	int path_nearest[n+1];
	cityandloc arrayofcitiescopy1[n];
	memcpy(arrayofcitiescopy1, arrayofcities, n*sizeof(cityandloc));         //pass in a copy of our list of city structs
	double	totaldistance;

	totaldistance = nearest_helper(n, arrayofcitiescopy1, path_nearest);     //get total distance from the helper

	strcpy(output[n], citycodes[0]);
	for (int i = 0; i < n; ++i)
	{
		strcpy(output[i], citycodes[path_nearest[i]]);
	}

	printf("-nearest        :");
	printf("%10.2f", totaldistance);                                      //print out all our stuff in a good format
	for (int i = 0; i < n+1; ++i)
	{
		printf(" %s", output[i]);
	}

	printf("\n");
	
}


void insert_nearest_fn(int n, double matrix2d[n][n], cityandloc *arrayofcities, char citycodes[n][4]) //function for -insert nearest
{
	int indexj_insert = 0, indexi_insert = 0;
	int *indexj_insertp = &indexj_insert;
	int *indexi_insertp = &indexi_insert;
	cityandloc arrayofcitiescopy2[n];

	memcpy(arrayofcitiescopy2, arrayofcities, n*sizeof(cityandloc));
	insert_nearest_helper(indexi_insertp, indexj_insertp, n, matrix2d); //makes indexj and indexi the indices of the two closest cities

	int length = 3; 
	int path_insert_nearest[n+1]; //start off our eventual path array and put our closest cities in it
	path_insert_nearest[0] = indexi_insert;
	path_insert_nearest[1] = indexj_insert;
	path_insert_nearest[2] = indexi_insert;

	arrayofcitiescopy2[indexi_insert].beenthere = 1;
	arrayofcitiescopy2[indexj_insert].beenthere = 1;

	//find the city that is nearest to all the cities currently in our path array
	double min = 100000000;
	int nextcity;

	while(length < n+1)
	{
		for (int i = 0; i < length; ++i)
		{
			for (int j = 0; j < n; ++j)
			{
				if (matrix2d[path_insert_nearest[i]][j] < min && matrix2d[path_insert_nearest[i]][j] != 0 && arrayofcitiescopy2[j].beenthere == 0)
				{
					min = matrix2d[path_insert_nearest[i]][j];
					nextcity = j;
				}
			}
		}
	arrayofcitiescopy2[nextcity].beenthere = 1;
	
	double minchangeindistance = 100000000;
	int insertionindex = 0;
	for (int i = 1; i < length; ++i) //insert into proper position
		{
			double changeforindex = location_distance(&arrayofcitiescopy2[path_insert_nearest[i-1]].loc, &arrayofcitiescopy2[nextcity].loc) + location_distance(&arrayofcitiescopy2[path_insert_nearest[i]].loc, &arrayofcitiescopy2[nextcity].loc) - location_distance(&arrayofcitiescopy2[path_insert_nearest[i-1]].loc, &arrayofcitiescopy2[path_insert_nearest[i]].loc);

			if (changeforindex < minchangeindistance)
		     {
		     	minchangeindistance = changeforindex;
		     	insertionindex = i;
		     }
		}

	int temppath[n+1];

	memcpy(temppath, path_insert_nearest, sizeof(int)*(n+1));

	for (int i = 0; i < insertionindex; ++i)
	{
		path_insert_nearest[i] = temppath[i];
	}

	path_insert_nearest[insertionindex] = nextcity;

	for (int i = insertionindex +1; i < length + 1; ++i)
	{
		path_insert_nearest[i] = temppath[i-1];
	}

	min = 100000000;

	length += 1;
	}

	reorder(n, path_insert_nearest);

	char output[n+2][4];
	strcpy(output[n], citycodes[0]);
	for (int i = 0; i < n; ++i)
	{
		strcpy(output[i], citycodes[path_insert_nearest[i]]);
	}

	double totaldistancetraveled = 0;

	for (int i = 0; i < n; ++i)
	{
		totaldistancetraveled = totaldistancetraveled + location_distance(&arrayofcitiescopy2[path_insert_nearest[i]].loc, &arrayofcitiescopy2[path_insert_nearest[i+1]].loc);
	}

	printf("-insert nearest :");
	printf("%10.2f", totaldistancetraveled);
	for (int i = 0; i < n+1; ++i)
	{
		printf(" %s", output[i]);
	}
	printf("\n");

}

void insert_farthest_fn(int n, double matrix2d[n][n], cityandloc *arrayofcities, char citycodes[n][4]) //function for -insert_farthest
{
	int indexj_insert = 0, indexi_insert = 0;
	int *indexj_insertp = &indexj_insert;
	int *indexi_insertp = &indexi_insert;
	cityandloc arrayofcitiescopy3[n];

	memcpy(arrayofcitiescopy3, arrayofcities, n*sizeof(cityandloc));
	insert_farthest_helper(indexi_insertp, indexj_insertp, n, matrix2d); //makes indexj and indexi the indices of the two closest cities

	int length = 3; 
	int path_insert_farthest[n+1]; //start off our eventual path array and put our closest cities in it
	path_insert_farthest[0] = indexi_insert;
	path_insert_farthest[1] = indexj_insert;
	path_insert_farthest[2] = indexi_insert;

	arrayofcitiescopy3[indexi_insert].beenthere = 1;
	arrayofcitiescopy3[indexj_insert].beenthere = 1;

	//find the city that is_farthest to all the cities currently in our path array
	double min = 100000000;
	int nextcity;

	while(length < n+1)
	{
		for (int i = 0; i < length; ++i)
		{
			for (int j = 0; j < n; ++j)
			{
				if (matrix2d[path_insert_farthest[i]][j] < min && matrix2d[path_insert_farthest[i]][j] != 0 && arrayofcitiescopy3[j].beenthere == 0)
				{
					min = matrix2d[path_insert_farthest[i]][j];
					nextcity = j;
				}
			}
		}
	arrayofcitiescopy3[nextcity].beenthere = 1;
	
	double minchangeindistance = 100000000;
	int insertionindex = 0;
	for (int i = 1; i < length; ++i) //insert into proper position
		{
			double changeforindex = location_distance(&arrayofcitiescopy3[path_insert_farthest[i-1]].loc, &arrayofcitiescopy3[nextcity].loc) + location_distance(&arrayofcitiescopy3[path_insert_farthest[i]].loc, &arrayofcitiescopy3[nextcity].loc) - location_distance(&arrayofcitiescopy3[path_insert_farthest[i-1]].loc, &arrayofcitiescopy3[path_insert_farthest[i]].loc);

			if (changeforindex < minchangeindistance)
		     {
		     	minchangeindistance = changeforindex;
		     	insertionindex = i;
		     }
		}

	int temppath[n+1];

	memcpy(temppath, path_insert_farthest, sizeof(int)*(n+1));

	for (int i = 0; i < insertionindex; ++i)
	{
		path_insert_farthest[i] = temppath[i];
	}

	path_insert_farthest[insertionindex] = nextcity;

	for (int i = insertionindex +1; i < length + 1; ++i)
	{
		path_insert_farthest[i] = temppath[i-1];
	}

	min = 100000000;

	length += 1;
	}

	reorder(n, path_insert_farthest);

	char output[n+2][4];
	strcpy(output[n], citycodes[0]);
	for (int i = 0; i < n; ++i)
	{
		strcpy(output[i], citycodes[path_insert_farthest[i]]);
	}

	double totaldistancetraveled = 0;

	for (int i = 0; i < n; ++i)
	{
		totaldistancetraveled = totaldistancetraveled + location_distance(&arrayofcitiescopy3[path_insert_farthest[i]].loc, &arrayofcitiescopy3[path_insert_farthest[i+1]].loc);
	}

	printf("-insert farthest:");
	printf("%10.2f", totaldistancetraveled);
	for (int i = 0; i < n+1; ++i)
	{
		printf(" %s", output[i]);
	}
	printf("\n");

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
//create matrix2d with all the distance between all cities

	//array with distances between all cities
	double matrix2d[n][n];

	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			matrix2d[i][j] = location_distance(&arrayofcities[i].loc, &arrayofcities[j].loc);
		}
	}





///////////////////////////////////////////////////////////////////////////////////////////
//iterate though all the arguments and call the correct functions with some error checking

	for (int i = 0; i < argc; ++i)
	{
		if (strcmp(argv[i], "-nearest") == 0)
		{
			nearest_fn(n, arrayofcities, citycodes);
		}

		else if ((i > 1) && (strcmp(argv[i-1], "-insert") != 0) && //error 4
			(strcmp(argv[i], "-nearest") != 0) &&
			(strcmp(argv[i], "-insert") != 0) &&
			(strcmp(argv[i], "-optimal") != 0))
		{
			fprintf(stderr, "TSP: invalid method %s\n", argv[i]);
			exit(0);
		}

		else if (strcmp(argv[i], "-insert") == 0) //error 6
		{
			if (argv[i+1] == NULL)
			{
				fprintf(stderr, "TSP: missing criterion\n");
				exit(0);
			}

			else if (strcmp(argv[i+1], "nearest") == 0)
			{
				insert_nearest_fn(n, matrix2d, arrayofcities, citycodes);
			}

			else if (strcmp(argv[i+1], "farthest") == 0)
			{
				insert_farthest_fn(n, matrix2d, arrayofcities, citycodes);
			}

			else if (strcmp(argv[i+1], "farthest") != 0 && strcmp(argv[i+1], "nearest") != 0) //error 5
			{
				fprintf(stderr, "TSP: invalid criterion %s\n", argv[i+1]);
				exit(0);
			}
		}
	}

}












