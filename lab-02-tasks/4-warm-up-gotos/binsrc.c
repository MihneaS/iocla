#include <stdio.h>

int main() {
    int v[20] = {1, 2, 4, 6, 6,7,9}, n = 7, x;
    scanf("%d",&x);
    //for (int i = 0; i < n; i++) {
    //    scanf("%d", v + i);
    //}
    int i;
    int beg =0;
    int end =n-1;
    startfor:
        i = (beg + end) / 2;
        if (v[i] == x) goto endfor;
        if ((v[i] <= x && v[i+1] > x) ) {
            i = -1;
            goto endfor;
        }
        if (x < v[i]) {
            end = i;
            goto startfor;
        }
        if (x > v[i]) {
            beg = i;
            goto startfor;
        }
        goto startfor; // reduntant
    endfor:
    
    printf("%d\n", i);
    
    return 0;

}
