#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

int main() {
    printf("PROT_EXEC=%d\n"
            "PROT_READ=%d\n"
            "PROT_WRITE=%d\n"
            "PROT_NONE=%d\n",
            PROT_EXEC, PROT_READ, PROT_WRITE, PROT_NONE);
    printf("\n");
    printf(
            "MAP_SHARED=%d\n"
            "MAP_PRIVATE=%d\n"
            "MAP_32BIT=%d\n"
            "MAP_ANON=%d\n"
            "MAP_DENYWRITE=%d\n"
            "MAP_EXECUTABLE=%d\n"
            "MAP_FILE=%d\n"
            "MAP_FIXED=%d\n"
            "MAP_GROWSDOWN=%d\n"
            "MAP_HUGETLB=%d\n"
            "MAP_LOCKED=%d\n"
            "MAP_NONBLOCK=%d\n"
            "MAP_NORESERVE=%d\n"
            "MAP_POPULATE=%d\n"
            "MAP_STACK=%d\n",
            MAP_SHARED,
            MAP_PRIVATE,
            MAP_32BIT,
            MAP_ANON,
            MAP_DENYWRITE,
            MAP_EXECUTABLE,
            MAP_FILE,
            MAP_FIXED,
            MAP_GROWSDOWN,
            MAP_HUGETLB,
            MAP_LOCKED,
            MAP_NONBLOCK,
            MAP_NORESERVE,
            MAP_POPULATE,
            MAP_STACK);
    printf("\n");
    printf("EXIT_SUCCES=%d\n"
            "EXIT_FAILURE=%d\n",
            EXIT_SUCCESS, EXIT_FAILURE);
    return 0;
}
