# vmap_area

```c
#include <linux/vmalloc.h>

struct vmap_area {
	unsigned long va_start;
	unsigned long va_end;

	/*
	 * Largest available free size in subtree.
	 */
	unsigned long subtree_max_size;
	unsigned long flags;
	struct rb_node rb_node;         /* address sorted rbtree */
	struct list_head list;          /* address sorted list */
	struct llist_node purge_list;    /* "lazy purge" list */
	struct vm_struct *vm;
};
```