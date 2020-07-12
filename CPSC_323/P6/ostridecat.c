#include "io.h"

// Usage: ./ostridecat [-b BLOCKSIZE] [-t STRIDE] [-o OUTFILE] [FILE]
//    Copies the input FILE to OUTFILE in blocks, shuffling its
//    contents. Reads FILE sequentially, but writes to its output in a
//    strided access pattern. Default BLOCKSIZE is 1 and default STRIDE is
//    1024. This means the output file's bytes are written in the sequence
//    0, 1024, 2048, ..., 1, 1025, 2049, ..., etc.

int main(int argc, char* argv[]) {
    // Parse arguments
    io_arguments args = io_parse_arguments(argc, argv, "b:t:o:");
    size_t block_size = args.block_size ? args.block_size : 1;

    // Allocate buffer, open files, measure file sizes
    char* buf = (char*) malloc(block_size);

    io_profile_begin();
    io_file* inf = io_open_check(args.input_file, O_RDONLY);

    args.input_size = io_filesize(inf);
    if ((ssize_t) args.input_size < 0) {
        fprintf(stderr, "ostridecat: input file is not seekable\n");
        exit(1);
    }

    io_file* outf = io_open_check(args.output_file,
                                      O_WRONLY | O_CREAT | O_TRUNC);
    if (io_seek(outf, 0) < 0) {
        fprintf(stderr, "ostridecat: output file is not seekable\n");
        exit(1);
    }

    // Copy file data
    size_t pos = 0, written = 0;
    while (written < args.input_size) {
        // Copy a block
        ssize_t amount = io_read(inf, buf, block_size);
        if (amount <= 0) {
            break;
        }
        io_write(outf, buf, amount);
        written += amount;

        // Move `outf` file position to next stride
        pos += args.stride;
        if (pos >= args.input_size) {
            pos = (pos % args.stride) + block_size;
            if (pos + block_size > args.stride) {
                block_size = args.stride - pos;
            }
        }
        int r = io_seek(outf, pos);
        assert(r >= 0);
    }

    io_close(inf);
    io_close(outf);
    io_profile_end();
    free(buf);
}
