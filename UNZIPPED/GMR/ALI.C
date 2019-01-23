#include <stdio.h>

typedef struct{
    char a;
    double b;
}exp;

void main(void)
{
    printf("\nAlinhamento: %d", sizeof(exp) - sizeof(double));
}
