#include <stdio.h>
#include <ctype.h>

#define PER_LINE 20

int main() {
    FILE *fp;
    fp = fopen("./input.dat", "r");
    int c;
    int count = 0;
    while ((c = fgetc(fp)) != EOF) {
        count++;
        count %= PER_LINE;
        if (isalnum(c)) {
            printf("\\%c  ", c);
        } else {
            printf("%2X  ", c);
        }
        if (c == '\0') {
            printf("\n\n");
            count = 0;
        } else if (count == 0) {
            printf("\n");
        }
        fflush(fp);
    }
}
