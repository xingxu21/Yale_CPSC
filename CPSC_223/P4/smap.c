
#ifndef __SMAP_H__
#define __SMAP_H__

#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>



//def of all the structs we will use
//struct of type entry, used in struct type smap
typedef struct entry
{
    char *key;
    void *value;
    bool occupied;
} entry;



/**
    struct of type smap as required by smap.h
**/
typedef struct smap 
{
    int capacity;
    int size; 
    entry *table;
    int (*hash)(const char*);
} smap;



//helper functions to make my life easier
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Given a key, hash function, and size of the hash table, returns the index of the key in the hastable
int smap_index(const char *key, int(*hash)(const char *s), int cap)
{
    return (hash(key) % cap + cap) % cap;
}



//checks the number of key-value pairs in a given smap type struct against its capacity. If no size change is needed 0, if the struct needs to be expanded 1, if the struct needs to be shrunk 2.
int smap_check_size(smap *m)
{
    const float upperbound = 0.6;
    const float lowerbound = 0.1;

    if (((float)(*m).size / (float)(*m).capacity) > upperbound)
    {
        return 1;
    }

    else if (((float)(*m).size / (float)(*m).capacity) < lowerbound)
    {
        return 2;
    }

    else
    {
        return 0;
    }
}



//function declarations of stuff that are needed in the rest of my helper functions. These following functions are required by smap.h.
bool smap_put(smap *m, const char *key, void *value);
const char **smap_keys(smap *m);
void *smap_get(smap *m, const char *key);



//smap_enlarge and smap_shrink call this function. It makes a new hash table with max capacity and fills it in with values. Returns 1 if there are no reallocation errors to help me debug this shit 
bool smap_rehash(smap *m, const char **keys, void** values)
{
    free((*m).table);
    (*m).table = malloc(sizeof(entry) * (*m).capacity);

    int size  = (*m).size;
    (*m).size = 0;

    if((*m).table == NULL)
    {
        return false;
    }

    for (int i = 0; i < (*m).capacity; i++)
    {
        (*m).table[i].occupied = false;
    }
    
    for (int i = 0; i < size; i++)
    {
        smap_put(m, keys[i],values[i]);
    }

    return true;
}



//enlarges the input hash table (smap type struct). Returns 1 if it is sucessfully enlarged and there were no memory allocation errors. If it returns 0 something fucked up.
bool smap_enlarge(smap *m)
{
    const char **keys = smap_keys(m);
    void **vals = malloc(sizeof(void*) * (*m).size);
    
    for (int i = 0; i < (*m).size; i++)
    {
        vals[i] = smap_get(m,keys[i]);
    }

    (*m).capacity = (*m).capacity * 2;
    bool rehash = smap_rehash(m, keys, vals);

    for (int i = 0; i < (*m).size; i++)
    {
        free(keys[i]);
    }

    free(keys);
    free(vals);
    return rehash;

}



//shrinks the input hash table (smap type struct). Returns 1 if it is sucessfully enlarged and there were no memory allocation errors. If it returns 0 something fucked up.
bool smap_shrink(smap *m)
{
    const char **keys = smap_keys(m);
    void **vals = malloc(sizeof(void*) * (*m).size);
    
    for (int i = 0; i < (*m).size; i++)
    {
        vals[i] = smap_get(m,keys[i]);
    }

    (*m).capacity = (*m).capacity / 2;
    bool rehash = smap_rehash(m, keys, vals);

    for (int i = 0; i < (*m).size; i++)
    {
        free(keys[i]);
    }

    free(keys);
    free(vals);
    return rehash;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////






//things are required by smap.h, except struct defs
/** as described by smap.h:
    Returns a hash value for the given string.
 
    @param s a string, non-NULL
    @return an int
**/
int smap_default_hash(const char *s)
{
    int val = 0;
    
    unsigned const char *us;
    us = (unsigned const char *) s;

    while(*us != '\0')
    {
        val = val * 97 + *us;
        us++;
    }

    return val;
}



/** as described by smap.h:
    Creates an empty map that uses the given hash function.
 
    @param h a pointer to a function that takes a string and returns
    its hash code, non-NULL
    @return a pointer to the new map or NULL if it could not be created;
    it is the caller's responsibility to destroy the map
 **/
smap *smap_create(int (*h)(const char *s))
{
    smap *m = malloc(sizeof(smap));
    (*m).capacity = 1000;
    (*m).table = malloc(sizeof(entry) * ((*m).capacity));
    (*m).size = 0;
    (*m).hash = h;

    for(int i = 0; i < (*m).capacity; i++)
    {
        (*m).table[i].occupied = false;
    }

    return m;
} 



/** as described by smap.h:
    Returns the number of (key, value) pairs in the given map.
 
    @param m a pointer to a map, non-NULL
    @return the size of m
 **/
int smap_size(const smap *m)
{
    return (*m).size;
}



/** according to smap.h:
    Adds a copy of the given key with value to this map.
    If the key is already present then the old value is replaced.
    The caller retains ownership of the value.  If key is new
    and space could not be allocated then there is no effect on the map
    and the return value is false.
 
    @param m a pointer to a map, non-NULL
    @param key a string, non-NULL
    @param value a pointer
    @return true if the put was successful, false otherwise
 **/
bool smap_put(smap *m, const char *key, void *value)
{
    int index = smap_index(key, (*m).hash, (*m).capacity);
    
    char *newkey = malloc(sizeof(char) * (strlen(key) + 1));
    strcpy(newkey, key);
    
    while((*m).table[index].occupied)
    {
        if (((*m).table[index].key != NULL) && strcmp((*m).table[index].key, key) == 0)
        {
            (*m).table[index].value = value;
            free(newkey);
            return true;
        }
        index = (index+1) % (*m).capacity;
    }

    (*m).table[index].key = newkey;
    (*m).table[index].value = value;
    (*m).table[index].occupied = true;
    (*m).size++;

    if(smap_check_size(m) == 1)
    {
        return smap_enlarge(m);
    }

    return true;
}



/** according to smap.h:
    Determines if the given key is present in this map.
 
    @param m a pointer to a map, non-NULL
    @param key a string, non-NULL
    @return true if key is present in this map, false otherwise
 **/
bool smap_contains_key(const smap *m, const char *key)
{
    int index = smap_index(key, (*m).hash, (*m).capacity);

    while((*m).table[index].occupied)
    {
        if (((*m).table[index].key != NULL) && strcmp((*m).table[index].key, key) == 0)
        {
            return true;
        }
        index = (index+1) % (*m).capacity;
    }

    return false;
}



/** according to smap.h:
    Returns the value associated with the given key in this map.
    If the key is not present in this map then the returned value is
    NULL.  The value returned is the original value passed to smap_put,
    and it remains the responsibility of whatever called smap_put to
    release the value (no ownership transfer results from smap_get).
 
    @param m a pointer to a map, non-NULL
    @param key a string, non-NULL
    @return the assocated value, or NULL if they key is not present
 **/
void *smap_get(smap *m, const char *key)
{
    if (smap_contains_key(m, key))
    {
        int index = smap_index(key, (*m).hash, (*m).capacity);
        while((*m).table[index].occupied)
        {
            if (((*m).table[index].key!=NULL) && (strcmp((*m).table[index].key, key) == 0))
            {
                return (*m).table[index].value;
            }
            index = (index+1) % (*m).capacity;
        }
        return NULL;
    }

    else
    {
        return NULL;
    }
}



/** according to smap.h:
    Removes the given key and its associated value from the given map if
    the key is present.  The return value is NULL and there is no effect
    on the map if the key is not present.
 
    @param m a pointer to a map, non-NULL
    @param key a key, non-NULL
    @return the value associated with the key
 **/
void *smap_remove(smap *m, const char *key)
{
    if (smap_contains_key(m,key))
    {
        int index = smap_index(key, (*m).hash, (*m).capacity);
        while((*m).table[index].occupied)
        {
            if (strcmp((*m).table[index].key, key) == 0)
            {
                void *value = (*m).table[index].value;
                free((*m).table[index].key);
                (*m).table[index].key = NULL;
                (*m).table[index].value=NULL;
                (*m).size--;

                if(smap_check_size(m) == 2)
                {
                    smap_shrink(m);
                }
                return value;
            }
            index = (index+1) % (*m).capacity;
        }
        return NULL;
    }

    else
    {
        return NULL;
    }
}



/** according to smap.h:
    Calls the given function for each (key, value) pair in this map, passing
    the extra argument as well.  This function does not add or remove from
    the map.
 
    @param m a pointer to a map, non-NULL
    @param f a pointer to a function that takes a key, a value, and an
    extra argument, and does not add to or remove from the map, no matter
    what the extra argument is; non-NULL
    @param arg a pointer
 **/
void smap_for_each(smap *m, void (*f)(const char *, void *, void *), void *arg)
{
    for(int i = 0; i < (*m).capacity; i++)
    {
        if((*m).table[i].occupied)
        {
            f((*m).table[i].key, (*m).table[i].value, arg);
        }
    }
}



/** according to smap.h:
    Returns a dynamicall]y array containing pointers to the keys in the
    given map.  It is the caller's responsibility to free the array,
    but the map retains ownership of the keys.  If there is a memory
    allocation error then the returned value is NULL.  If the map is empty
    then the returned value is NULL.
 
    @param m a pointer to a map, non NULL
    @return a pointer to a dynamically allocated array of pointer to the keys
 **/
const char **smap_keys(smap *m)
{
    const char **keys = malloc(sizeof(char*) * (*m).size);

    if (keys == NULL)
    {
        return NULL;
    }

    int tableindex=0;

    for (int i = 0; i < (*m).size; i++)
    {
        while(!((*m).table[tableindex].occupied) || ((*m).table[tableindex].key==NULL))
        {
            tableindex = (tableindex+1) % (*m).capacity;
        }
        keys[i] = (*m).table[tableindex].key;
        tableindex = (tableindex+1) % (*m).capacity;
    }

    return keys;
}



/** according to smap.h:
    Destroys the given map.
    
    @param m a pointer to a map, non-NULL
 **/
void smap_destroy(smap *m)
{
    const char **keys = smap_keys(m);
    
    for (int i = 0; i < (*m).size; i++)
    {
        free(keys[i]);
    }

    free(keys);
    free((*m).table);
    free(m);
}



#endif
