#include <stdio.h>
#include <stdlib.h>

int main() {
	FILE *v = NULL;
	FILE *c = NULL;
	FILE *Com = NULL;
	
	int sv, sc, cont = 0;
	char tv,tc;
	v = fopen("Verilog.txt", "r");
	c = fopen("resultadoc.txt", "r");
	while (!feof(v) && !feof(c)){
		fread(&tv, sizeof(char),1, v);
 		fread(&tc, sizeof(char),1, c);
		if (tv != tc)
			cont++;
	}
	printf("Numero de diferencas: %d\n",cont++);
	return 0;
}