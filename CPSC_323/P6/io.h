#ifndef IO_H
#define IO_H
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

typedef struct io_file io_file;

io_file* io_fdopen(int fd, int mode);
io_file* io_open_check(const char* filename, int mode);
int io_close(io_file* f);

off_t io_filesize(io_file* f);

int io_seek(io_file* f, off_t pos);

int io_readc(io_file* f);
int io_writec(io_file* f, int ch);

ssize_t io_read(io_file* f, char* buf, size_t sz);
ssize_t io_write(io_file* f, const char* buf, size_t sz);

int io_eof(io_file* f);
int io_flush(io_file* f);

void io_profile_begin(void);
void io_profile_end(void);


typedef struct {
    size_t input_size;          // `-s` option: input size. Defaults to SIZE_MAX
    size_t block_size;          // `-b` option: block size. Defaults to 0
    size_t stride;              // `-t` option: stride. Defaults to 1
    const char* output_file;    // `-o` option: output file. Defaults to NULL
    const char* input_file;     // input file. Defaults to NULL
    int n_input_files;          // number of input files; at least 1
    const char** input_files;   // all input files; NULL-terminated array
} io_arguments;

io_arguments io_parse_arguments(int argc, char* argv[], const char* opts);

#endif
