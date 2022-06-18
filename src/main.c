#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int ft_strlen(char *);

int	main(int argc, char **argv) {
	if (argc != 2)
		exit(127);
	printf("ft_strlen = %d\n", ft_strlen(argv[1]));
	printf("   strlen = %lu\n", strlen(argv[1]));
	return 0;
}
