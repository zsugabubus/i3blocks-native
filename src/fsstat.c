#include <errno.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/statvfs.h>
#include <unistd.h>

#include "sizef.h"

int
main(void) {
	char *path;
	struct statvfs st;
	char buf[4];

	(path = getenv("BLOCK_INSTANCE")) || (path = "/");

	while (-1 == statvfs(path, &st)) {
		switch (errno) {
		case EACCES:
		case ENOENT:
			return EXIT_SUCCESS;
		case EINTR:
			continue;
		}

		fprintf(stderr, "Couldn't open %s: %s.", path, strerror(errno));
		return EXIT_FAILURE;
	}

	sizef(&buf, st.f_bsize * st.f_bavail);
	printf("%c%.*s\n", (st.f_flag & ST_RDONLY ? '*' : ' '), 4, buf);
	return EXIT_SUCCESS;
}
/* vi:set ts=4 sw=4 noet: */
