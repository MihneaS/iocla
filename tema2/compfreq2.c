#include <stdio.h>
#include <ctype.h>

#define LETTERS_IN_ALPHABET 'z' - 'a' + 1


int main() {
    int c;
    int table[LETTERS_IN_ALPHABET] = {0};
    while ((c = getchar()) != EOF) {
        if (isalpha(c)) {
            table[tolower(c) - 'a']++;
        }
    }

    for (int i = 0; i < LETTERS_IN_ALPHABET; i++) {
        printf("%c: %d\n", i+'a', table[i]);
    }
    return 0;
}
