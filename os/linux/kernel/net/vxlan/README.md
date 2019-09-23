# VXLAN

```c
/* 
 * <drivers/net/vxlan.c>
 *
 * per-network namespace private data for this module
 */
struct vxlan_net {
	struct list_head  vxlan_list;
	struct hlist_head sock_list[PORT_HASH_SIZE];
	spinlock_t	  sock_lock;
};
```

## 参考

* []()
