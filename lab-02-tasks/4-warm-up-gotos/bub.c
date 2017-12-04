#include <stdio.h>

int main()
{
    int v[] = {321, 3, 4, 12, 51, 22, 123}, n = 6;
    int i, j, aux;
    i = 0;
    for1:
    if (i >= n-1) goto end1;
        j = i+1;
        for2:
        if (j >= n) goto end2;
            if (v[i] > v[j]) {
                aux = v[i];
                v[i] = v[j];
                v[j] = aux;

            }
        j++;
        goto for2;
        end2:
    i++;
    goto for1;
    end1:

    i=0;
    for3:
    if(i >= n) goto end3;
        printf("%d ", v[i]);
        i++;
    goto for3;
    end3:
    
    printf("\n");

    return 0;
}
