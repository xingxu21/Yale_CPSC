#include <stddef.h>
#include <math.h>
#include <stdio.h>


#include "location.h"



//store the number of cities
int numberofcities = 0;

//store the name of each city as we make structs and stuff
int nameofcity;

//store the coordinates of each city as we make structs and stuff
int latitudeofcity, longitudeofcity;

//our nice little array that has all the distances between all the cities that will make life easier for me yolo swag
void datamatrixmaker(int n)
{
	int distancesmatrix[n][n];
}

//create a struct for storing our city name and then a location struct with long and lat
typedef struct City{
	char name;
	location coordinatesofcity; 
}city;


//main takes in commannd line arguments. First is name of file to read, the rest are methods we are required to use. 
int main(int argc, char *argv[])
{

	// read in the number of cities, make a matrix with that many rows,  columns
	FILE *file = fopen(argv[1], "r");
	scanf(File *file, "%d" &numberofcities);
	datamatrixmaker(numberofcities);

	// read in the names of cities, create a struct named by the number of the city (city 1 stuff goes in struct 1), fill in name section of the struct with the name of the city.
	for(i = 1, i <= numberofcities, i++)
	{
		scanf(File *file, "%s" &nameofcity);
		city i;
		nameofcity.name = nameofcity;
	}

	//read in the coordinates of each city and fill them into the appropriate city
	for (int i = 1; i <= numberofcities; ++i)
	{
		scanf(File *file, "%d" &latitudeofcity);
		scanf(File *file, "%d" &longitudeofcity);

		i.coordinatesofcity.lat = latitudeofcity;
		i.coordinatesofcity.lon = longitudeofcity;

	}

	printf("%d" 2.coordinatesofcity.lat);

}