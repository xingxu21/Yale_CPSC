#include "smap.h"
#include "entry.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct data {
    entry entryd;
    int games;
    double wins;
    int *dist;
    double score;
    double avgscore;
}data;

//comparison operators for qsort that operates on two elements in an array of data pointers
//returns: 1 if the second element is greater, -1 if the first is greater, 0 if equal
int comparewins(const void *data1_raw, const void *data2_raw)
{
    data **data1 = (data**) data1_raw;
    data **data2 = (data**) data2_raw;
    if ((*data1).wins < (*data2).wins)
    {
        return 1;
    }
    else if ((*data1).wins == (*data2).wins)
    {
        return (strcmp((*data1).entryd.id, (*data2).entryd.id));
    }
    else
    {
        return -1;
    }
    
}

int comparescores(const void *data1_raw, const void *data2_raw)
{
    data **data1 = (data**) data1_raw;
    data **data2 = (data**) data2_raw;
    if ((*data1).avgscore < (*data2).avgscore)
    {
        return 1;
    }
    else if ((*data1).avgscore == (*data2).avgscore)
    {
        return (strcmp((*data1).entryd.id, (*data2).entryd.id));
    }
    else
    {
        return -1;
    }
    
}

int main(int argv, char *argc[])
{
    if (argv < 4)
    {
        printf("not enough args\n");
        return -1;
    }
    int fname_length = strlen(argc[1]);
    char *fname = malloc(sizeof(char)*(fname_length + 1));
    strcpy(fname, argc[1]);
    const char win[4] = "win";
    const char score[6] = "score";
    int win_or_score = -1; // 0 if win, 1 if score
    if (strcmp(argc[2], win)==0)
    {
        win_or_score=0;
    }
    else if (strcmp(argc[2], score)==0)
    {
        win_or_score=1;
    }
    if(win_or_score==-1)
    {
        printf("2nd arg should be win or score\n");
        return -1;
    }
    //fill out field values
    int num_fields = argv - 3;
    double *field_values = malloc(sizeof(double) * num_fields);
    for(int i = 3; i < argv; i++)
    {
        field_values[i-3] = atoi(argc[i]);
    }

    smap *map = smap_create(smap_default_hash);
    entry temp;
    bool cont = true;
    while(cont) //populate entries in map
    {
        temp = entry_read(stdin, 31, num_fields);
        if (temp.id != NULL && *temp.id != '\0')
        {
            data *tempd = malloc(sizeof(data));
            (*tempd).entryd = temp;
            (*tempd).games=0;
            (*tempd).wins=0;
            (*tempd).dist=temp.distribution;
            (*tempd).score=0;
            (*tempd).avgscore=0;
            smap_put(map, temp.id, tempd);
        }
        else
        {
            entry_destroy(&temp);
            cont = false;
        }   
    }

    FILE *matchups = fopen(fname,"r");
    if (matchups == NULL)
    {
        printf("invalid matchup file\n");
        return -1;
    }
    char *id1 = malloc(sizeof(char)*31);
    char *id2 = malloc(sizeof(char)*31);
    int read = 0;
    //evaluate matchups
    while(((read = fscanf(matchups, "%s %s\n", id1, id2)) == 2))
    {
        data *data1 = smap_get(map, id1);
        data *data2 = smap_get(map, id2);
        if (data1 == NULL || data2 ==NULL)
        {
            return -1;
        }
        
        double score1 = 0;
        double score2 = 0;
        //printf("ids: %s %s\n", id1, id2);
        //printf("score1: %f score2: %f\n", score1, score2);
        for (int i = 0; i < num_fields; i++)
        {
            if ((*data1).dist[i] > (*data2).dist[i])
            {
                score1 += field_values[i];
            }
            else if ((*data1).dist[i] < (*data2).dist[i])
            {
                score2 += field_values[i];
            }
            else
            {
                score1+=field_values[i]/2;
                score2+=field_values[i]/2;
            }
            
            //printf("score1: %f %s score2: %f %s\n", score1, (*data1).entryd.id, score2, (*data2).entryd.id);
        }
        
        (*data1).games++;
        (*data2).games++;
        (*data1).score= ((*data1).score+=score1);
        (*data1).avgscore = (*data1).score/(*data1).games;
        (*data2).score= ((*data2).score+=score2);
        (*data2).avgscore = ((*data2).score)/((*data2).games);
        if (score1 == score2)
        {
            (*data1).wins+=0.5;
            (*data2).wins+=0.5;
        }
        else if (score1 < score2)
        {
            (*data2).wins+=1;
        }
        else if (score1 > score2)
        {
            (*data1).wins+=1;
        }
        smap_put(map, id1, data1);
        smap_put(map, id2, data2);
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
    //sort results
    if(win_or_score == 0)
    {
        qsort(datas, num_players, sizeof(data*), comparewins);
    }
    else
    {
        qsort(datas, num_players, sizeof(data*), comparescores);
    }
    //print results
    if(win_or_score==1)
    {
        for (int i = 0; i < num_players; i++)
        {
            printf("%7.3f %s\n", (*datas[i]).avgscore, (*datas[i]).entryd.id);
        }
    }
    else
    {
        for (int i = 0; i < num_players; i++)
        {
            printf("%7.3f %s\n", ((float) * (*datas[i]).wins)/((float) * ((*datas[i]).games)), (*datas[i]).entryd.id);
        }
    }
    
    for (int i = 0; i < num_players; i++)
    {
        entry_destroy(&( (*datas[i]).entryd));
        free(datas[i]);
    }
    free(datas);
    free(field_values);
    free(fname);
    smap_destroy(map);
    
}