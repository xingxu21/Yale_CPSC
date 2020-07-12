#include "io.h"

// Usage: ./scatter [-b BLOCKSIZE] [FILE1 FILE2...]
//    Copies the standard input to the FILEs, alternating between FILEs
//    with every block. (I.e., write a block to FILE1, then
//    a block to FILE2, etc.) This is a "scatter" I/O pattern: one
//    input file is scattered into many output files.
//    Default BLOCKSIZE is 1.

int main(int argc, char* argv[]) {
    // Parse arguments
    io_arguments args = io_parse_arguments(argc, argv, "b:#");
    size_t block_size = args.block_size ? args.block_size : 1;
    // Note that we use `args.input_files` for OUTPUT files.

    // Allocate buffer, open files
    char* buf = (char*) malloc(block_size);

    int nfiles = args.n_input_files;
    io_profile_begin();
    io_file* inf = io_fdopen(STDIN_FILENO, O_RDONLY);
    io_file** outfs = (io_file**) calloc(nfiles, sizeof(io_file*));
    for (int i = 0; i < nfiles; ++i) {
        outfs[i] = io_open_check(args.input_files[i],
                                   O_WRONLY | O_CREAT | O_TRUNC);
    }

    // Copy file data
    int whichf = 0;
    while (1) {
        ssize_t amount = io_read(inf, buf, block_size);
        if (amount <= 0) {
            break;
        }
        io_write(outfs[whichf], buf, amount);
        whichf = (whichf + 1) % nfiles;
    }

    io_close(inf);
    for (int i = 0; i < nfiles; ++i) {
        io_close(outfs[i]);
    }
    io_profile_end();
    free(outfs);
    free(buf);
}
