#include <cstdio>
#include <cstdlib>
using namespace std;

int main()
{
    char *fbuf = NULL;
    size_t bufsize = 256;
    char rbuf[bufsize];

    FILE *fp = open_memstream(&fbuf, &bufsize);
    if (fp == NULL) {
        fprintf(stderr, "fopen error\n");
        return 1;
    }

    // write data to fp
    const char *msg = "Hello, Buffer as FILE!";
    printf("write message = %s\n", msg);
    fputs(msg, fp);

    fflush(fp);  // shoud flush before read buffer
    printf("buffer = %s\n", fbuf);

    // rewind fp to head
    if (fseek(fp, 0L, SEEK_SET) != 0) {
        fprintf(stderr, "fseek error\n");
        goto err;
    }

    // read data from fp
    fgets(rbuf, sizeof(rbuf), fp);
    printf("read buffer = \"%s\"\n", rbuf);

err:
    fclose(fp);
    free(fbuf);

    return 0;
}

