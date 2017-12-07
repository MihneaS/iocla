#include <stdio.h>
#define LETTERS_IN_ALPHABET 'z' - 'a' + 1

int main() {
    FILE *fp;
    fp = fopen("./codfinal.txt", "r");
    int c, i;
    char engfreq[] =  "_etaosinrdhmlcwu.fpygvbkjxzq";
    char foundfreq[] ="c_kqgli.seyhfwnmxudztjrpobva";
    while ((c = fgetc(fp)) != EOF) {
        for (i = 0; i < LETTERS_IN_ALPHABET + 2; i++) {
            if (c == foundfreq[i])
                break;
        }
        printf("%c", engfreq[i]);
    }
    printf("\n");

    return 0;
}
