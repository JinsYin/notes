# POSIX

POSIX is a superset of the standard C library, and it's important to note that it defers to it. If C and POSIX is ever in conflict, C wins.

Sockets, file descriptors, shared memory etc. are all part of POSIX, but do not exist in the C library.
