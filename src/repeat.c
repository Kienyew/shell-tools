/* repeat a string several times */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage(char* argv[]) {
	printf("Usage: %s CHARS COUNT\n", argv[0]);
}

int main(int argc, char* argv[]) {
	if (argc != 3) {
		usage(argv);
		exit(1);
	}
		
	long count = atoi(argv[2]);	
	const char* word = argv[1];
	size_t word_length = strlen(word);
	for (long i = 0; i < count; ++i) {
		fwrite(word, sizeof(char), word_length, stdout);
	}
	return 0;
}
