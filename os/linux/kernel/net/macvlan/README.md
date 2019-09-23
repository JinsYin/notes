# MacVLAN

```c
/*
 * <drivers/net/macvlan.c>
 *
 */
struct macvlan_port {
	struct net_device	*dev;
	struct hlist_head	vlan_hash[MACVLAN_HASH_SIZE];
	struct list_head	vlans;
	struct sk_buff_head	bc_queue;
	struct work_struct	bc_work;
	u32			flags;
	int			count;
	struct hlist_head	vlan_source_hash[MACVLAN_HASH_SIZE];
	DECLARE_BITMAP(mc_filter, MACVLAN_MC_FILTER_SZ);
	unsigned char           perm_addr[ETH_ALEN];
};
```

## 参考

* [MACVLAN](https://github.com/freelancer-leon/notes/blob/master/kernel/networking/macvlan.md)
* [linux 网络虚拟化：macvlan](https://cizixs.com/2017/02/14/network-virtualization-macvlan/)
* [Docker Networking: macvlan bridge](http://hicu.be/docker-networking-macvlan-bridge-mode-configuration)
