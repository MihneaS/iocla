#include <stdio.h>
#include <ctype.h>

#define PER_LINE 20


int main() {
    int c;
    int count = 0;
    while ((c = fgetc(stdin)) != EOF) {
        count++;
        count %= PER_LINE;
        #ifndef ONLY_HEXA
        if (isalnum(c) || c == '.' || c == '=') {
            printf("   %c  ", c);
        } else if (c == ' ') {
            printf(" _  ");
        } else {
        #endif
            printf("0x%2X  ", c);
        #ifndef ONLY_HEXA
        }
        #endif
        if (c == '\0') {
            printf("\n\n");
            count = 0;
        } else if (count == 0) {
            printf("\n");
        }
        fflush(stdin);
    }
}
