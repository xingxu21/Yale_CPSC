#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "trackpoint.h"
#include "track.h"

int main (int argc, char *argv[])
{
    if (argc != 5)
    {
        exit(0);
    }
    double cell_width = atof(argv[1]);
    double cell_height = atof(argv[2]);
    int value_length = strlen(argv[3]);
    char value_list[value_length+1];
    strcpy(value_list, argv[3]);
    int range = atoi(argv[4]);

    double lat=0, lon=0;
    long time=0;
    int read=0;

    track *trk = track_create();

    while((read = scanf("%lf %lf %ld\n", &lat, &lon, &time)) != EOF)
    {
        if (read == 0)
        {
            track_start_segment(trk);
        }
        if(read == 3)
        {
            trackpoint *tp = trackpoint_create(lat, lon, time);
            track_add_point(trk, tp);
            trackpoint_destroy(tp);
        }
    }

    int **map;
    int rows, cols;
    track_heatmap(trk, cell_width, cell_height, &map, &rows, &cols);

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            int n = map[i][j];
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
    for (int i = 0; i < rows; i++)
    {
        free(map[i]);
    }
    free(map);
    track_destroy(trk);

}