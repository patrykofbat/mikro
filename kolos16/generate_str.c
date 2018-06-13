#include <stdio.h>
#include <stdlib.h>

char* generate_str(char *s, int c, int n, int inc);

int main(int argc, char *argv[]){
    char *s;
    char a[1] = {'b'};
    s = malloc(sizeof(char) * 3);
    generate_str(s, 65, 4, 1);
    printf("Hello %s\n", s);
    return 0;
}