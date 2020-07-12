
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "trackpoint.h"
#include "location.h"
#include "track.h"

struct track 
{
    trackpoint ***segments; //array of pointers to segments
    int *point_count; // number of pointers in each segment
    int array_space; //space allocated for the array of segments (and thus also point_count)
    int segment_count; // number of segment
    int *segments_space; // space allocated for each segment
};

/**
 * Creates a track with one empty segment.
 *
 * @return a pointer to the new track, or NULL if there was an allocation error
 */
track *track_create()
{
    track *t = malloc(sizeof(track));
    t->array_space = 1;
    t->segment_count = 1;

    t->segments = malloc(sizeof(trackpoint**) * t->array_space);
    t->segments[0] = malloc(sizeof(trackpoint*));
    
    t->point_count = malloc(sizeof(int) * t->array_space);
    t->point_count[0]=0;
    
    t->segments_space = malloc(sizeof(int) * t->array_space);
    t->segments_space[0] = 1;
    return t;
}

/**
 * Destroys the given track, releasing all memory held by it.
 *
 * @param trk a pointer to a valid track
 */
void track_destroy(track *trk)
{
    for (int i = 0; i < trk->segment_count; i++)
    {
        for (int j = 0; j < trk->point_count[i]; j++)
        {
            trackpoint_destroy(trk->segments[i][j]);
        }
        free(trk->segments[i]);
    }
    free(trk->segments);
    free(trk->point_count);
    free(trk->segments_space);
    free(trk);
}

/**
 * Returns the number of segments in the given track.
 *
 * @param trk a pointer to a valid track
 */
int track_count_segments(const track *trk)
{
    return trk->segment_count;
}

/**
 * Returns the number of trackpoints in the given segment of the given
 * track.  The segment is specified by a 0-based index.  The return
 * value is 0 if the segment index is invalid.
 *
 * @param trk a pointer to a valid track
 * @param i a nonnegative integer less than the number of segments in trk
 * @return the number of trackpoints in the corresponding segment
 */
int track_count_points(const track *trk, int i)
{
    if (i >= trk->segment_count || i < 0)
    {
        return 0;
    }
    return trk->point_count[i];
}

/**
 * Returns a copy of the given point in this track.  The segment is
 * specified as a 0-based index, and the point within the segment is
 * specified as a 0-based index into the corresponding segment.  The
 * return value is NULL if either index is invalid or if there is a memory
 * allocation error.  It is the caller's responsibility to destroy the
 * returned trackpoint.
 *
 * @param trk a pointer to a valid track
 * @param i a nonnegative integer less than the number of segments in trk
 * @param j a nonnegative integer less than the number of points in segment i
 * of track trk
 */
trackpoint *track_get_point(const track *trk, int i, int j)
{
    if (i > trk->segment_count || i < 0)
    {
        return NULL;
    }
    if (j > trk->point_count[i] || j < 0)
    {
        return NULL;
    }
    return trackpoint_copy(trk->segments[i][j]);
}

/**
 * Returns an array containing the length of each segment in this track.
 * The length of a segment is the sum of the distances between each point
 * in it and the next point.  The length of a segment with fewer than two
 * points is zero.  If there is a memory allocation error then the returned
 * pointer is NULL.  It is the caller's responsibility to free the returned
 * array.
 *
 * @param trk a pointer to a valid track
 */
double *track_get_lengths(const track *trk)
{
    double *lengths = malloc(trk->segment_count * sizeof(double));
    if (lengths == NULL)
    {
        return lengths;
    }
    for (int i = 0; i < trk->segment_count; i++)
    {
        if (trk->point_count[i] < 2)
        {
            lengths[i] = 0;
        }
        else
        {
            int total = 0;
            for (int j = 1; j < trk->point_count[i]; j++)
            {
                location *loc1;
                *loc1 = trackpoint_location(trk->segments[i][j-1]);
                location *loc2;
                *loc2 =  trackpoint_location(trk->segments[i][j]);
                total += location_distance(loc1, loc2);
            }
            lengths[i] = total;
        }
        
    }
    return lengths;
}

/**
 * Adds a copy of the given point to the last segment in this track.
 * The point is not added and there is no change to the track if there
 * is a last point in the track (the last point in the current segment
 * or the last point on the previous segment if the current segment
 * is empty) and the timestamp on the new point is
 * not strictly after the timestamp on the last point.  There is no
 * effect if there is a memory allocation error.  The return value
 * indicates whether the point was added.  This function must execute
 * in amortized O(1) time (so a sequence of n consecutive operations must
 * work in worst-case O(n) time).
 *
 * @param trk a pointer to a valid track
 * @param pt a trackpoint with a timestamp strictly after the last trackpoint
 * in the last segment in this track (if there is such a point)
 * @return true if and only if the point was added
 */
bool track_add_point(track *trk, const trackpoint *pt)
{
    int current_seg = trk->segment_count - 1; //index of current segment
    int last_index = trk->point_count[current_seg] - 1; //index of last point in current segment
    if (last_index > -1)
    {
        if (trackpoint_time(trk->segments[current_seg][last_index]) >= trackpoint_time(pt))
        {
            //check time of last trackpoint with input trackpoint
            return false;
        }
    }


    if ((last_index + 1) < trk->segments_space[current_seg]) //checks allocated space for segment
    {
        trk->segments[current_seg][last_index + 1] = trackpoint_copy(pt);
        trk->point_count[current_seg]++;
        return true;
    }
    else
    {
        //increases and reallocs as needed
        
        trk->segments_space[current_seg] = trk->segments_space[current_seg] * 2;
        trackpoint **temp = malloc((trk->point_count[current_seg]+1) * sizeof(trackpoint*));
        for (int i = 0; i < trk->point_count[current_seg]; i++) //copies current contents into temp
        {
            temp[i] = trackpoint_copy(trk->segments[current_seg][i]);
            trackpoint_destroy(trk->segments[current_seg][i]);
        }
        temp[trk->point_count[current_seg]] = trackpoint_copy(pt); //adds new trackpoint to temp
        
        free(trk->segments[current_seg]); 
       
        trk->segments[current_seg] = malloc(trk->segments_space[current_seg]*sizeof(trackpoint*));
        for (int i = 0; i < trk->point_count[current_seg] + 1; i++)
        {
            trk->segments[current_seg][i] = trackpoint_copy(temp[i]);
            trackpoint_destroy(temp[i]);
        }
        free(temp);

        trk->point_count[current_seg]++;
        
        return true;
    }
    
            
}
        

/**
 * Starts a new segment in the given track.  There is no effect on the track
 * if the current segment is empty or if there is a memory allocation error.
 *
 * @param trk a pointer to a valid track
 */
void track_start_segment(track *trk)
{
    if (trk->point_count[trk->segment_count - 1] != 0)
    {
        trk->segment_count++; //segment count reflects the number of segments after adding one
        
        if (trk->segment_count > trk->array_space) //checks if expansion is necessary
        {
            trk->array_space = trk->array_space * 2;

            //alloc new point_count array with increased space
            
            int *temp_point_count = malloc(sizeof(int) * (trk->array_space));
            for (int i = 0; i < (trk->segment_count - 1); i++)
            {
                temp_point_count[i] = trk->point_count[i];
            }
            free(trk->point_count);
            trk->point_count = malloc(sizeof(int) * (trk->array_space));
            for (int i = 0; i < (trk->segment_count - 1); i++)
            {
                trk->point_count[i] = temp_point_count[i];
            }
            
            free(temp_point_count);
            

            //alloc new array of segments w/ increased space
            trackpoint ***temp_segment_arr = malloc(sizeof(trackpoint**) * (trk->segment_count-1));
            memcpy(temp_segment_arr, trk->segments, sizeof(trackpoint**) * (trk->segment_count - 1));
            free(trk->segments);
            trk->segments = malloc(sizeof(trackpoint**) * trk->array_space);
            for (int i = 0; i < (trk->segment_count - 1); i++)
            {
                trk->segments[i] = temp_segment_arr[i];
            }
            
            free(temp_segment_arr);

            //alloc new segment_space array w/ increased space
            int *temp_space_count = malloc(sizeof(int) * (trk->array_space));
            memcpy(temp_space_count, trk->segments_space, sizeof(int)*(trk->segment_count - 1));
            free(trk->segments_space);
            trk->segments_space = malloc(sizeof(int) * (trk->array_space));
            for (int i = 0; i < (trk->segment_count - 1); i++)
            {
                trk->segments_space[i] = temp_space_count[i];
            }
           
            
            free(temp_space_count);
        }
        

        
        trk->segments[trk->segment_count-1] = malloc(sizeof(trackpoint*)); //initialize pointer to new segment
        trk->point_count[trk->segment_count-1] = 0; //initialize point counter for new segment
        trk->segments_space[trk->segment_count-1] = 1; //initialize counter for space allocated for segment
        
        
    }
    
    
}

/**
 * Merges the given range of segments in this track into one.  The segments
 * to merge are specified as the 0-based index of the first segment to
 * merge and one more than the index of the last segment to merge.
 * The resulting segment replaces the first merged one and later segments
 * are moved up to replace the other merged segments.  If the range is
 * invalid then there is no effect.
 *
 * @param trk a pointer to a valid track
 * @param start an integer greather than or equal to 0 and strictly less than
 * the number if segments in trk
 * @param end an integer greater than or equal to start and less than or
 * equal to the number of segments in trk
 */
void track_merge_segments(track *trk, int start, int end)
{
    //check range
    if (start >= trk->segment_count || end > trk->segment_count || (end < start) || (end - start < 2))
    {
        return;
    }
    int total_points = 0;
    for (int i = start; i < end ; i++)
    {
        total_points += trk->point_count[i] ;
    }
    
    //move all points to temp array
    trackpoint **temp = malloc(total_points * sizeof(trackpoint*));
    int temp_counter = 0;
    for (int i = start; i < end; i++)
    {
        for (int j = 0; j < trk->point_count[i]; j++)
        {
            temp[temp_counter] = trackpoint_copy(trk->segments[i][j]);
            trackpoint_destroy(trk->segments[i][j]);
            temp_counter++;
        }
    }

    //move merged values back into track, update the track accordingly, and destroy temp
    trk->point_count[start] = total_points;
    trk->segments_space[start] = total_points;
    free(trk->segments[start]);
    trk->segments[start] = malloc(total_points * sizeof(trackpoint*));
    
    for (int i = 0; i < total_points; i++)
    {
        trk->segments[start][i] = trackpoint_copy(temp[i]);
        trackpoint_destroy(temp[i]);
    }
    
    for (int i = start+1; i < trk->segment_count - (end-start-1); i++) //replace segments w/ later ones
    {   
        if (i != (trk->segment_count - (end-start)))
        {
            free(trk->segments[i]);
        }
        trk->segments[i] = malloc(sizeof(trackpoint*) * trk->point_count[i+end-start-1]);
        memcpy(trk->segments[i], trk->segments[i+end-start-1], sizeof(trackpoint*) * trk->point_count[i+end-start-1]);
        trk->point_count[i] = trk->point_count[i+end-start-1];
        trk->segments_space[i] = trk->point_count[i+end-start-1];
        free(trk->segments[i+end-start-1]);
        trk->point_count[i+end-start-1] = 0;
        trk->segments_space[i+end-start-1] = 0;
    }
    
    trk->segment_count = trk->segment_count - (end - start-1);
    free(temp);
    
}

/**
 * Creates a heapmap of the given track.  The heatmap will be a
 * rectangular 2-D array with each row separately allocated.  The last
 * three paramters are (simulated) reference parameters used to return
 * the heatmap and its dimensions.  Each element in the heatmap
 * represents an area bounded by two circles of latitude and two
 * meridians of longitude.  The circle of latitude bounding the top of
 * the top row is the northernmost (highest) latitude of any
 * trackpoint in the given track.  The meridian bounding the left of
 * the first column is the western edge of the smallest spherical
 * wedge bounded by two meridians the contains all the points in the
 * track (the "western edge" for a nontrivial wedge being the one
 * that, when you move east from it along the equator, you stay in the
 * wedge).  When there are multple such wedges, choose the one with
 * the lowest normalized (adjusted to the range -180 (inclusive) to
 * 180 (exclusive)) longitude.  The distance (in degrees) between the
 * bounds of adjacent rows and columns is given by the last two
 * parameters.  The heat map will have just enough rows and just
 * enough columns so that all points in the track fall into some cell.
 * The value in each entry in the heatmap is the number of trackpoints
 * located in the corresponding cell.  If a trackpoint is on the
 * border of two or more cells then it is counted in the bottommost
 * and rightmost cell it is on the border of, but do not add a row or
 * column just to place points on the south and east borders into
 * them and instead place the points on those borders by breaking ties
 * only between cells that already exist.
 * If there are no trackpoints in the track then the function
 * creates a 1x1 heatmap with the single element having a value of 0.
 * If the cell size is invalid or if there is a memory allocation
 * error then the map is set to NULL and the rows and columns
 * parameters are unchanged.  It is the caller's responsibility to
 * free each row in the returned array and the array itself.
 *
 * @param trk a pointer to a valid trackpoint
 * @param cell_width a positive double less than or equal to 360.0
 * @param cell_height a positive double less than or equal to 180.0
 * @param map a pointer to a pointer to a 2-D array of ints
 * @param rows a pointer to an int
 * @param cols a pointer to an int
 */

//finds boundaries of given track and returns through an array of doubles with the topmost
//boundary as the first element, the bottom boundary as the second, the westernmost as the third,
// and the eastmost as the fourth
void find_boundaries(const track *trk, double *bounds);

//populates the given initialized heatmap with trackpoints from trk
void populate_heatmap(const track *trk, int ***map, int rows, int cols, double cell_width, double cell_height, double *boundaries);

void track_heatmap(const track *trk, double cell_width, double cell_height,
		    int ***map, int *rows, int *cols)
{
    if (trk->segment_count == 0 || trk->point_count[0] == 0)
    {
        *rows = 1;
        *cols = 1;
        map = malloc(sizeof(int**));
        *map = malloc(sizeof(int*));
        **map = malloc(sizeof(int));
        ***map = 0;
    }
    if (cell_width < 0 || cell_width > 360 || cell_height < 0 || cell_height > 180)
    {
        map = NULL;
    }

    double boundaries[4] = {1000, 1000, 1000, 1000};
    find_boundaries(trk, boundaries);
    for (int i = 0; i < 4; i++)
    {
        if (boundaries[i]==1000)
        {
            exit(0);
        }
    }

    int num_rows = ceil((boundaries[0] - boundaries[1])/cell_height);
    int num_cols = ceil((boundaries[3] - boundaries[2])/cell_width);

    *map = malloc(sizeof(int*) * num_rows);
    
    for (int i = 0; i < num_rows; i++)
    {
        map[0][i] = malloc(sizeof(int) * num_cols);
        for (int j = 0; j < num_cols; j++)
        {
            map[0][i][j] = 0;
        }
    }
    populate_heatmap(trk, map, num_rows, num_cols, cell_width, cell_height, boundaries);
    *rows = num_rows;
    *cols = num_cols;
}            

void find_boundaries(const track *trk, double *bounds)
{
    double top = -360;
    double bottom = 360;
    for (int i = 0; i < trk->segment_count; i++) //iterate through every point and keep the highest lat
    {
        for (int j = 0; j < trk->point_count[i]; j++)
        {
            if (trackpoint_location(trk->segments[i][j]).lat > top)
                {
                    top = trackpoint_location(trk->segments[i][j]).lat;
                }
            if (trackpoint_location(trk->segments[i][j]).lat < bottom)
                {
                    bottom = trackpoint_location(trk->segments[i][j]).lat;
                }    
        }
    }
    bounds[0] = top;
    bounds[1] = bottom;

    double diff = 0;
    double lon1 = -1000;
    double lon2 = -1000;
    //iterate through every point and find the next closest lon; keep the lons of the points 
    //resulting in the highest difference
    for (int current_seg = 0; current_seg < trk->segment_count; current_seg++) //iterate through every point and keep the highest lat
    {
        for (int current_point = 0; current_point < trk->point_count[current_seg]; current_point++)
        {
            for (int temp_seg = 0; temp_seg < trk->segment_count; temp_seg++)
            {
                double current_lon = trackpoint_location(trk->segments[current_seg][current_point]).lon;

                for (int temp_point = 0; temp_point < trk->point_count[temp_seg]; temp_point++)
                {
                    if ( !((current_seg==temp_seg) && (current_point==temp_point)) )
                    {
                        double temp_lon = trackpoint_location(trk->segments[temp_seg][temp_point]).lon;
                        if (temp_lon != current_lon)
                        {
                            double raw_diff = current_lon - temp_lon;
                            if (raw_diff < 0)
                            {
                                raw_diff = raw_diff*(-1);
                            }
                            if (raw_diff > 180)
                            {
                                raw_diff = 360 - raw_diff;
                            }

                            if (raw_diff > diff)
                            {
                                diff = raw_diff;
                                lon1 = current_lon;
                                lon2 = temp_lon;
                            }
                        }
                    }
                }
            }
        }
    }

    if (lon1 < lon2)
    {
        bounds[2] = lon1;
        bounds[3] = lon2;
    }
    else
    {
        bounds[2] = lon2;
        bounds[3] = lon1;
    }
    
}

void populate_heatmap(const track *trk, int ***map, int rows, int cols, double cell_width, double cell_height, double *boundaries)
{
    double top = boundaries[0];
    double left = boundaries[2];
    

    for (int i = 0; i < trk->segment_count; i++)
    {
        int current_row = floor((top - trackpoint_location(trk->segments[i][0]).lat)/ cell_height);
        int current_col = floor((-1*(left - trackpoint_location(trk->segments[i][0]).lon))/ cell_width);
        map[0][current_row][current_col]++;    

        for (int j = 1; j < trk->point_count[i]; j++)
        {
            double current_lat = trackpoint_location(trk->segments[i][j]).lat;
            double current_lon = trackpoint_location(trk->segments[i][j]).lon;
            while (current_lat < (top - ((current_row+1)*cell_height))) //checks for change in row
            {
                current_row++;
            }
            while (current_lat > (top - ((current_row)*cell_height)))
            {
                current_row--;
            }
            
            while (current_lon > (left + ((current_col+1)*cell_width))) //checks for change in column
            {
                current_col++;
            }
            while (current_lon < (left + ((current_col)*cell_width)))
            {
                current_col--;
            }

            //check for weird border stuff
            if (current_lat == (top - ((current_row+1)*cell_height)))
            {
                if (!(current_row == rows - 1))
                {
                    current_row++;
                }
            }
            if (current_lon == (((current_col+1)*cell_width))+left)
            {
                if (!(current_col == cols - 1))
                {
                    current_col++;
                }
            }
            
            map[0][current_row][current_col]++;
            
        }
    }
    
}


