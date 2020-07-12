#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "trackpoint.h"
#include "track.h"

int main (int argc, char *argv[])
{
    //throw a fit if there are not enough arguments
    if (argc != 5)
    {
        exit(0);
    }
    //turn args into floating point and s
    double width = atof(argv[1]);
    double height = atof(argv[2]);

    int value_length = strlen(argv[3]);
    char value_list[value_length+1];

    strcpy(value_list, argv[3]);
    int range = atoi(argv[4]);

    double lat=0, lon=0;
    long time=0;
    int read=0;

    track *trk = track_create();

    //create each trackpoint
    while((read = scanf("%lf %lf %ld\n", &lat, &lon, &time)) != EOF)
    {
        if (read == 0)
        {
            track_start_segment(trk);
        }
        if(read == 3)
        {
            trackpoint *temporary_trackpoint = trackpoint_create(lat, lon, time);
            track_add_point(trk, temporary_trackpoint);
            trackpoint_destroy(temporary_trackpoint);
        }
    }



    int **hmap;
    int nrows, ncols;
    track_heatmap(trk, width, height, &hmap, &nrows, &ncols);

    //print out the heatmap 
    for (int i = 0; i < nrows; i++)
    {
        for (int j = 0; j < ncols; j++)
        {
            int n = hmap[i][j];
            int n_adjusted = n/range;
            if(n == 0)
            {
                printf("%c", value_list[0]);
            }
            else if (n_adjusted >= value_length)
            {
                printf("%c", value_list[value_length-1]);
            }
            else
            {
                printf("%c", value_list[n_adjusted]);
            }
            
        }  
        printf("\n");      
    }
    for (int i = 0; i < nrows; i++)
    {
        free(hmap[i]);
    }
    free(hmap);
    track_destroy(trk);

}