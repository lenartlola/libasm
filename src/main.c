#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int ft_strlen(char *);
extern char *ft_strcpy(char *, char *);

int	main(int argc, char **argv) {

	if (argc != 2)
		exit(127);
	//printf("ft_strlen = %d\n", ft_strlen(argv[1]));
	//printf("   strlen = %lu\n", strlen(argv[1]));

	char	*strcpydst = malloc(sizeof(argv[1]));
	ft_strcpy(strcpydst, argv[1]);
	printf("strcpydst -> %s\n", strcpydst);

	free(strcpydst);
	return 0;
}
