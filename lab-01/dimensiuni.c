#include <stdio.h>
int main () {
    printf( "char are %lu\n"
            "short are %lu\n"
            "int are %lu\n"
            "unsingned int are %lu\n"
            "long are %lu\n"
            "long long are %lu\n"
            "void* are %lu\n",
            sizeof(char),
            sizeof(short),
            sizeof(int),
            sizeof(unsigned int),
            sizeof(long),
            sizeof(long long),
            sizeof(void*));
    return 0;
}
