#include <stdlib.h>
#include <stdio.h>

int check_tab(int* tab, int n, int* max);

int main(int argc, char *args[]){
    int tab[] = {2,2,2,2,2,2,2,5,5,5,5,6};
    int* max = malloc(sizeof(int));
    printf("%d\n", check_tab(tab, 12, max));
    return 0;
}

// int check_tab(int* tab, int n, int* max){
//     for(int i=0;i<n;i++){
//         printf("Outter = %d\n", tab[i]);
//     }
// }