#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int	_ft_strlen(char *);
extern int	_ft_strcmp(char *, char *);
extern int	_ft_write(int, char *, size_t);
extern int	_ft_read(int, void *, size_t);
extern char	*_ft_strcpy(char *, char *);

int	main(int argc, char **argv) {

	if (argc < 2 || argc > 3)
		exit(127);
	printf("__ft_strlen = %d\n", _ft_strlen(argv[1]));
	//printf("   strlen = %lu\n", strlen(argv[1]));

	char	*strcpydst = malloc(_ft_strlen(argv[1]));
	_ft_strcpy(strcpydst, argv[1]);
	_ft_write(1, "_ft_strcpy -> ", _ft_strlen("_ft_strcpy -> "));
	_ft_write(1, strcpydst, _ft_strlen(strcpydst));
	_ft_write(1, "\n", 1);
	free(strcpydst);
	
	char	*rbuf = malloc(20);
	_ft_write(1, "Write some thing: ", _ft_strlen("Write some thing: "));
	_ft_read(1, rbuf, 19);
	_ft_write(1, "rbuf -> ", _ft_strlen("rbuf -> "));
	_ft_write(1, rbuf, _ft_strlen(rbuf));
	_ft_write(1, "\n", 1);
	free(rbuf);

	if (argc == 3)
	{
		if (!_ft_strcmp(argv[1], argv[2]))
			printf("_ft_strcmp -> are equal\n");
		else
			printf("_ft_strcmp -> aren't equal\n");
	}
	
	return 0;
}
