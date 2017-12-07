#include <stdio.h>
#include <ctype.h>

#define LETTERS_IN_ALPHABET 'z' - 'a' + 1


int main() {
    FILE *fp;
    fp = fopen("./codtask6.txt", "r");
    int c;
    int table[LETTERS_IN_ALPHABET + 2] = {0};
    while ((c = fgetc(fp)) != EOF) {
        if (isalpha(c)) {
            table[c - 'a']++;
        } else if (c == '.') {
            table[LETTERS_IN_ALPHABET]++;
        } else if (c == '_') {
            table[LETTERS_IN_ALPHABET + 1]++;
        }
    }

    for (int i = 0; i < LETTERS_IN_ALPHABET; i++) {
        printf("%c: %d\n", i+'a', table[i]);
    }
        printf(".: %d\n", table[LETTERS_IN_ALPHABET]);
        printf("_: %d\n", table[LETTERS_IN_ALPHABET + 1]);
    return 0;
}
