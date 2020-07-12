#include "smap.h"
#include "entry.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct data {
    entry entryd;
    double average_score;
    double score;
    int *distance;
    int number_of_games;
    double number_of_wins;
}data;



//compares scores of two players. If average score of player 2 > average score of player 1, return 1
int compare_scores(const void *player1_orig, const void *player2_orig)
{
    data **player1 = (data**) player1_orig;
    data **player2 = (data**) player2_orig;

    if ((*player1)->average_score < (*player2)->average_score)
    {
        return 1;
    }

    else if ((*player1)->average_score == (*player2)->average_score)
    {
        return (strcmp((*player1)->entryd.id, (*player2)->entryd.id));
    }

    else
    {
        return -1;
    }
    
}




//compares number_of_wins of two players. If wins of player 2 greater than player 1, return 1
int compare_number_of_wins(const void *player1_orig, const void *player2_orig)
{
    data **player1 = (data**) player1_orig;
    data **player2 = (data**) player2_orig;

    if ((*player1)->number_of_wins < (*player2)->number_of_wins)
    {
        return 1;
    }

    else if ((*player1)->number_of_wins == (*player2)->number_of_wins)
    {
        return (strcmp((*player1)->entryd.id, (*player2)->entryd.id));
    }

    else
    {
        return -1;
    }
    
}



int main(int argv, char *argc[])
{
//Read in arguments and stuffffffffffffffffffffff/////////////////////////////////////////////////////////////////////
    if (argv < 4) //checks to make sure that enough arguments are actually provided
    {
        printf("not enough args\n");
        return -1;
    }

    int file_name_length = strlen(argc[1]);  //read in the file and save the length of the file
    char *file_name = malloc(sizeof(char)*(file_name_length + 1));
    strcpy(file_name, argc[1]);

    const char win[4] = "win";
    const char score[6] = "score";
    int winorscore = -1; // 0 if win, 1 if score

    if (strcmp(argc[2], win)==0)
    {
        winorscore=0;
    }

    else if (strcmp(argc[2], score)==0)
    {
        winorscore=1;
    }

    if(winorscore==-1)
    {
        printf("2nd arg should be win or score\n");
        return -1;
    }



    //Assign values to fields//////////////////////////////////////////////////////
    int number_of_fields = argv - 3;
    double *field_values = malloc(sizeof(double) * number_of_fields);

    for(int i = 3; i < argv; i++)
    {
        field_values[i-3] = atoi(argc[i]);
    }

    smap *map = smap_create(smap_default_hash);
    entry temporary;
    bool cont = true;

    while(cont) //populate entries in map
    {
        temporary = entry_read(stdin, 31, number_of_fields);
        if (temporary.id != NULL && *temporary.id != '\0')
        {
            data *temporaryd = malloc(sizeof(data));

            temporaryd->entryd = temporary;
            temporaryd->number_of_games=0;
            temporaryd->number_of_wins=0;

            temporaryd->distance=temporary.distribution;
            temporaryd->score=0;
            temporaryd->average_score=0;

            smap_put(map, temporary.id, temporaryd);
        }

        else
        {
            entry_destroy(&temporary);
            cont = false;
        }   
    }





//read in matchups////////////////////////////////////////////////////////////////////////////////////////////
    FILE *matchups = fopen(file_name,"r");

    if (matchups == NULL)
    {
        printf("invalid matchup file\n");
        return -1;
    }

    char *id1 = malloc(sizeof(char)*31);
    char *id2 = malloc(sizeof(char)*31);
    int read = 0;



    //evaluate the different matchups to see who wins and who loses
    while(((read = fscanf(matchups, "%s %s\n", id1, id2)) == 2))
    {
        data *player1 = smap_get(map, id1);
        data *player2 = smap_get(map, id2);
        if (player1 == NULL || player2 ==NULL)
        {
            return -1;
        }
        
        double score1 = 0;
        double score2 = 0;


        //assign scores for players based on values of different fields
        for (int i = 0; i < number_of_fields; i++)
        {
            if (player1->distance[i] > player2->distance[i])
            {
                score1 += field_values[i];
            }

            else if (player1->distance[i] < player2->distance[i])
            {
                score2 += field_values[i];
            }

            else
            {
                score1+=field_values[i]/2;
                score2+=field_values[i]/2;
            }
        }
        

        //update number of games, scores, and average score for both players
        player1->number_of_games++;
        player1->score= (player1->score+=score1);
        player1->average_score = player1->score/player1->number_of_games;
        
        player2->number_of_games++;
        player2->score= (player2->score+=score2);
        player2->average_score = (player2->score)/(player2->number_of_games);

        if (score1 == score2)
        {
            player1->number_of_wins+=0.5;
            player2->number_of_wins+=0.5;
        }

        else if (score1 < score2)
        {
            player2->number_of_wins+=1;
        }

        else if (score1 > score2)
        {
            player1->number_of_wins+=1;
        }

        smap_put(map, id1, player1);
        smap_put(map, id2, player2);
    }



    free(id1);
    free(id2);





    const char **keys = smap_keys(map);
    int num_players = smap_size(map);
    data **datas = malloc(sizeof(data*) * num_players);

    for (int i = 0; i < num_players; i++)
    {
        datas[i] = (data*)smap_get(map, keys[i]);
    }

    free(keys);
  
//sort the results using quicksort
    if(winorscore == 0)
    {
        qsort(datas, num_players, sizeof(data*), compare_number_of_wins);
    }

    else
    {
        qsort(datas, num_players, sizeof(data*), compare_scores);
    }


//print out the results
    if(winorscore==1)
    {
        for (int i = 0; i < num_players; i++)
        {
            printf("%7.3f %s\n", datas[i]->average_score
        , datas[i]->entryd.id);
        }
    }

    else
    {
        for (int i = 0; i < num_players; i++)
        {
            printf("%7.3f %s\n", ((float)datas[i]->number_of_wins)/((float)(datas[i]->number_of_games)), datas[i]->entryd.id);
        }
    }
    
    for (int i = 0; i < num_players; i++)
    {
        entry_destroy(&(datas[i]->entryd));
        free(datas[i]);
    }
    free(datas);
    free(field_values);
    free(file_name);
    smap_destroy(map); //DESTROY EVERYTHING
    
}