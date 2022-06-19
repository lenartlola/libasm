#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int	ft_strlen(char *);
extern int	ft_strcmp(char *, char *);
extern char	*ft_strcpy(char *, char *);

int	main(int argc, char **argv) {

	if (argc < 2 || argc > 3)
		exit(127);
	printf("ft_strlen = %d\n", ft_strlen(argv[1]));
	//printf("   strlen = %lu\n", strlen(argv[1]));

	char	*strcpydst = malloc(ft_strlen(argv[1]));
	ft_strcpy(strcpydst, argv[1]);
	printf("strcpydst -> %s\n", strcpydst);

	free(strcpydst);
	
	if (argc == 3)
	{
		if (!ft_strcmp(argv[1], argv[2]))
			printf("ft_strcmp -> are equal\n");
		else
			printf("ft_strcmp -> aren't equal\n");
	}
	
	return 0;
}
