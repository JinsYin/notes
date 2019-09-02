# xattr_handlers

```c
#include <linux/xattr.h>

/*
 * <include/linux/xattr.h>
 *
 * struct xattr_handler: When @name is set, match attributes with exactly that
 * name.  When @prefix is set instead, match attributes with that prefix and
 * with a non-empty suffix.
 */
struct xattr_handler {
	const char *name;
	const char *prefix;
	int flags;      /* fs private flags */
	bool (*list)(struct dentry *dentry);
	int (*get)(const struct xattr_handler *, struct dentry *dentry,
		   struct inode *inode, const char *name, void *buffer,
		   size_t size);
	int (*set)(const struct xattr_handler *, struct dentry *dentry,
		   struct inode *inode, const char *name, const void *buffer,
		   size_t size, int flags);
};
```