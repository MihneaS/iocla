#include <stdio.h>
 
int main(void)
{
    short a = 20000;
    short b = 14000;
 
    short c = a + b;
    unsigned short d = 3 * a + b;
    short e = a << 1;
 
    printf("%i\n%u\n%i\n", c, d, e);
 
    unsigned char *p; 
    size_t i;
  
    p = &c; 
    printf("c:");
    for (i = 0; i < sizeof(c); i++)
        printf(" 0x%02x", p[i]);
    printf("\n");
    p = &d; 
    printf("d:");
    for (i = 0; i < sizeof(d); i++)
        printf(" 0x%02x", p[i]);
    printf("\n");
    p = &e; 
    printf("e:");
    for (i = 0; i < sizeof(e); i++)
        printf(" 0x%02x", p[i]);
    printf("\n");

    return 0;
}
