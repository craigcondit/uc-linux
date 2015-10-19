#include <pwd.h>
#include <grp.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define NGROUPS (1024)

int main(int argc, char *argv[]) {
  struct passwd pwd;
  struct passwd *result;
  char *buf;
  size_t bufsize;
  int s;
  int ngroups = NGROUPS;
  gid_t *groups;
  int j;
  struct group *gr;

  if (argc < 3) {
    fprintf(stderr, "Usage: %s username command [args...]\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  groups = malloc(ngroups * sizeof (gid_t));
  if (groups == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  bufsize = sysconf(_SC_GETPW_R_SIZE_MAX);
  if (bufsize == -1)      /* Value was indeterminate */
    bufsize = 16384;    /* Should be more than enough */

  buf = malloc(bufsize);
  if (buf == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  s = getpwnam_r(argv[1], &pwd, buf, bufsize, &result);
  if (result == NULL) {
    if (s == 0) {
      printf("User %s not found\n", argv[1]);
    } else {
      errno = s;
      perror("getpwnam_r");
    }
    exit(EXIT_FAILURE);
  }

  /* set HOME */
  errno = 0;
  if (setenv("HOME", pwd.pw_dir, 1) == -1) {
    perror("setenv");
    exit(EXIT_FAILURE);
  }

  /* get group list */
  if (getgrouplist(pwd.pw_name, pwd.pw_gid, groups, &ngroups) == -1) {
    fprintf(stderr, "getgrouplist() returned -1; ngroups = %d\n", ngroups);
    exit(EXIT_FAILURE);
  }

  /* set groups */
  errno = 0;
  if (setgroups(ngroups, groups) != 0) {
    perror("setgroups");
    exit(EXIT_FAILURE);
  }

  /* set gid */
  errno = 0;
  if (setgid(pwd.pw_gid) != 0) {
    perror("setgid");
    exit(EXIT_FAILURE);
  }

  /* set uid */
  errno = 0;
  if (setuid(pwd.pw_uid) != 0) {
    perror("setuid");
    exit(EXIT_FAILURE);
  }

  /* exec cmd */
  errno = 0;
  if (execvp(argv[2], (argv +2)) != 0) {
    perror("execve");
    exit(EXIT_FAILURE);
  }

  /* shouldn't get here */
  exit(EXIT_SUCCESS);
}

