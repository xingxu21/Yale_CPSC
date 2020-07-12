#include "io.h"

// Usage: ./gather [-b BLOCKSIZE] [-o OUTFILE] [FILE1 FILE2...]
//    Copies the input FILEs to OUTFILE, alternating between
//    FILEs with every block. (I.e., read a block from FILE1, then
//    a block from FILE2, etc.) This is a "gather" I/O pattern: many
//    input files are gathered into a single output file.
//    Default BLOCKSIZE is 1.

int main(int argc, char* argv[]) {
    // Parse arguments
    io_arguments args = io_parse_arguments(argc, argv, "b:o:#");
    size_t block_size = args.block_size ? args.block_size : 1;

    // Allocate buffer, open files
    char* buf = (char*) malloc(block_size);
    int nfiles = args.n_input_files;

    io_profile_begin();
    io_file** infs = (io_file**) calloc(nfiles, sizeof(io_file*));
    for (int i = 0; i < nfiles; ++i) {
        infs[i] = io_open_check(args.input_files[i], O_RDONLY);
    }
    io_file* outf = io_open_check(args.output_file,
                                      O_WRONLY | O_CREAT | O_TRUNC);

    // Copy file data
    int whichf = 0, ndeadfiles = 0;
    while (ndeadfiles != nfiles) {
        if (infs[whichf]) {
            ssize_t amount = io_read(infs[whichf], buf, block_size);
            if (amount <= 0) {
                io_close(infs[whichf]);
                infs[whichf] = NULL;
                ++ndeadfiles;
            } else {
                io_write(outf, buf, amount);
            }
        }
        whichf = (whichf + 1) % nfiles;
    }

    io_close(outf);
    io_profile_end();
    free(infs);
    free(buf);
}
