#include <stdio.h>

int main() {
    int v[20] = {2, 4, 6, 6, 1}, n = 5;
    //scanf("%d",&n);
    //for (int i = 0; i < n; i++) {
    //    scanf("%d", v + i);
    //}
    int i = 0;
    int max = 0;
    startfor:
        if (!(i < n)) goto endfor;
        if (max < v[i]) max = v[i];
        ++i;
        goto startfor;
    endfor:
    
    printf("%d\n", max);
    
    return 0;

}
