#include <alloc.h>
#include <stdio.h>


int main(void)
{
    unsigned mf1, mf2;
    char *pm[2];

    mf1 = coreleft();
    printf("Mem¢ria livre: %u\n", mf1);

    pm[0] = (char *)malloc(21);
    printf("Pedido de reserva de 21 bytes\n");

    mf2 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %u\n", mf2, mf1-mf2);

    pm[1] = (char *)malloc(121);
    printf("Pedido de reserva de 121 bytes\n");

    mf1 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %u\n", mf1, mf2-mf1);

    pm[2] = (char *)malloc(2);
    printf("Pedido de reserva de 2 bytes\n");

    mf2 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %u\n", mf2, mf1-mf2);

    free((char *)pm[1]);
    printf("Libertar 121 bytes\n");

    mf1 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %d\n", mf1, mf2-mf1);

    free((char *)pm[2]);
    printf("Libertar 2 bytes\n");

    mf2 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %d\n", mf2, mf1-mf2);

    free((char *)pm[0]);
    printf("Libertar 21 bytes\n");

    mf1 = coreleft();
    printf("Mem¢ria livre: %u\nDiferen‡a = %d\n", mf1, mf2-mf1);

    return 0;
}