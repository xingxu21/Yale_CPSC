#include "io.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <limits.h>
#include <errno.h>

// io.c
//    YOUR CODE HERE!


// io_file
//    Data structure for io file wrappers. Add your own stuff.
#define CACHE_SIZE 4096

struct io_file {
    int fd;
    int cached;
    char read_cache[CACHE_SIZE];
    int READ_CACHE_INDEX;
    int read_cache_contains;
    char write_cache[CACHE_SIZE];
    int WRITE_CACHE_INDEX;
    int write_cache_contains;
    //off_t offset;
};


// io_fdopen(fd, mode)
//    Return a new io_file for file descriptor `fd`. `mode` is
//    either O_RDONLY for a read-only file or O_WRONLY for a
//    write-only file. You need not support read/write files.

io_file* io_fdopen(int fd, int mode) {
    assert(fd >= 0);
    io_file* f = (io_file*) malloc(sizeof(io_file));
    f->fd = fd;
    (void) mode;
    return f;
}


// io_close(f)
//    Close the io_file `f` and release all its resources.

int io_close(io_file* f) {
    io_flush(f);
    int r = close(f->fd);
    free(f);
    return r;
}


// io_readc(f)
//    Read a single (unsigned) character from `f` and return it. Returns EOF
//    (which is -1) on error or end-of-file.
/*
int io_readc(io_file* f) {
    unsigned char buf[1];
    if (read(f->fd, buf, 1) == 1) {
        return buf[0];
    } else {
        return EOF;
    }
}*/

int io_readc(io_file* f) {
    unsigned char ch;
    if (f->cached == 1) //file has been cached 
    {
        if (f->READ_CACHE_INDEX < f->read_cache_contains) //cache hit
        {
           ch = f->read_cache[f->READ_CACHE_INDEX];
           f->READ_CACHE_INDEX++;
        }

        else //cache miss
        {
            f->read_cache_contains = io_read(f, f->read_cache, CACHE_SIZE); //read next set of things into buffer
            f->READ_CACHE_INDEX = 0; //reset read index
            if (f->read_cache_contains <= 0)
            {
                return EOF;
            }
            ch = io_readc(f);
        }

    }

    else //file has not been cached. cache it and then call io_readc on it again. 
    {   
        f->read_cache_contains = io_read(f, f->read_cache, CACHE_SIZE);
         if (f->read_cache_contains <= 0)
            {
                return EOF;
            }
        f->cached = 1;
        //f->offset = 0;
        ch = io_readc(f);
    }
    
    return ch;
}


// io_read(f, buf, sz)
//    Read up to `sz` characters from `f` into `buf`. Returns the number of
//    characters read on success; normally this is `sz`. Returns a short
//    count, which might be zero, if the file ended before `sz` characters
//    could be read. Returns -1 if an error occurred before any characters
//    were read.

ssize_t io_read(io_file* f, char* buf, size_t sz) {
    size_t nread = 0;
    nread = read(f->fd, buf, sz);
    if (nread != 0 || sz == 0 || io_eof(f)) {
        //f->offset += nread;
        return nread;
    } else {
        return -1;
    }
}


// io_writec(f)
//    Write a single character `ch` to `f`. Returns 0 on success or
//    -1 on error.
/*
int io_writec(io_file* f, int ch) {
    unsigned char buf[1];
    buf[0] = ch;
    if (write(f->fd, buf, 1) == 1) {
        return 0;
    } else {
        return -1;
    }
}*/


int io_writec(io_file* f, int ch) {
    /*if (f->cached !=1)
    {
        f->cached = 1;
        f->offset = 0;
    }*/

    if (ch == EOF)//we reached the end of the file 
    {
        if (io_write(f, f->write_cache, f->write_cache_contains) == f->write_cache_contains)
        {
            return 0;
        }
        else{
            return -1;
        }
    }

    else if (f->write_cache_contains == CACHE_SIZE){ //we have filled the cache previously
        if (io_write(f, f->write_cache, f->write_cache_contains) == f->write_cache_contains)
        {
            f->write_cache_contains = 0;
            f->WRITE_CACHE_INDEX = 0;

            return io_writec(f,ch);
        }
        else{
            return -1;
        }
    }

    else
    {
        unsigned char ch1 = (unsigned char) ch;
        f->write_cache[f->WRITE_CACHE_INDEX] = ch1;
        f->write_cache_contains++;
        f->WRITE_CACHE_INDEX++;
        return 0;
    }
}



// io_write(f, buf, sz)
//    Write `sz` characters from `buf` to `f`. Returns the number of
//    characters written on success; normally this is `sz`. Returns -1 if
//    an error occurred before any characters were written.

ssize_t io_write(io_file* f, const char* buf, size_t sz) {
    size_t nwritten = 0;
    nwritten = write(f->fd, buf, sz);
    if (nwritten != 0 || sz == 0) {
        //f->offset += nwritten;
        return nwritten;
    } else {
        return -1;
    }
}


// io_flush(f)
//    Forces a write of all buffered data written to `f`.
//    If `f` was opened read-only, io_flush(f) may either drop all
//    data buffered for reading, or do nothing.

int io_flush(io_file* f) {
    if (io_write(f, f->write_cache, f->write_cache_contains) == f->write_cache_contains)
    {
        return 0;
    }
    return -1;
}


// io_seek(f, pos)
//    Change the file pointer for file `f` to `pos` bytes into the file.
//    Returns 0 on success and -1 on failure.

int io_seek(io_file* f, off_t pos) {
    off_t r = lseek(f->fd, (off_t) pos, SEEK_SET);
    if (r == (off_t) pos) {
        return 0;
    } else {
        return -1;
    }
}
/*
int io_seek(io_file* f, off_t pos) {
    if (pos == f->offset)
    {
        return 0;
    }

    else{
        off_t r = lseek(f->fd, (off_t) pos, SEEK_SET);
        if (r == (off_t) pos) {
            return 0;
        } else {
            return -1;
        }
    }
}*/



// You shouldn't need to change these functions.

// io_open_check(filename, mode)
//    Open the file corresponding to `filename` and return its io_file.
//    If `filename == NULL`, returns either the standard input or the
//    standard output, depending on `mode`. Exits with an error message if
//    `filename != NULL` and the named file cannot be opened.

io_file* io_open_check(const char* filename, int mode) {
    int fd;
    if (filename) {
        fd = open(filename, mode, 0666);
    } else if ((mode & O_ACCMODE) == O_RDONLY) {
        fd = STDIN_FILENO;
    } else {
        fd = STDOUT_FILENO;
    }
    if (fd < 0) {
        fprintf(stderr, "%s: %s\n", filename, strerror(errno));
        exit(1);
    }
    return io_fdopen(fd, mode & O_ACCMODE);
}


// io_filesize(f)
//    Return the size of `f` in bytes. Returns -1 if `f` does not have a
//    well-defined size (for instance, if it is a pipe).

off_t io_filesize(io_file* f) {
    struct stat s;
    int r = fstat(f->fd, &s);
    if (r >= 0 && S_ISREG(s.st_mode)) {
        return s.st_size;
    } else {
        return -1;
    }
}




// io_eof(f)
//    Test if readable file `f` is at end-of-file. Should only be called
//    immediately after a `read` call that returned 0 or -1.

int io_eof(io_file* f) {
    char x;
    ssize_t nread = read(f->fd, &x, 1);
    if (nread == 1) {
        fprintf(stderr, "Error: io_eof called improperly\n\
  (Only call immediately after a read() that returned 0 or -1.)\n");
        abort();
    }
    return nread == 0;
}
