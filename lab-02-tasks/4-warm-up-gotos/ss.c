#include <stdio.h>

int main () {
    char S[] = "dsakkjdsakdsababcsadsa";
    char s[] = "abc";
    int N = 23, n =4;
    int i =0, j, k;
    for1:
    if (i >= N) goto endfor1;

        if (S[i] == s[0]) {
            j = 0;
            k = i;
            for2:
                if (j == n - 1) goto end;
                if (s[j] != S[k]) goto endfor2;
                j++;
                k++;
                goto for2;
            endfor2:
                j++; //reduntant, folosita pt a desenaliza un warning
        }
        i++;
    goto for1;
    endfor1:
    printf("nu am gasit\n");
    return 0;

    end:
    printf ("am gasit la pozitia %d\n", i);
    return 0;
}
