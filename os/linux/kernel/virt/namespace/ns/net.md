# Net Namespace

## 内核代码

```c
/*
 * <include/net/net_namespace.h>
 *
 *
 *
 */
struct net {
	refcount_t		passive;	/* To decided when the network
						 * namespace should be freed.
						 */
	refcount_t		count;		/* To decided when the network
						 *  namespace should be shut down.
						 */
	spinlock_t		rules_mod_lock;

	u32			hash_mix;
	atomic64_t		cookie_gen;

	struct list_head	list;		/* list of network namespaces */
	struct list_head	exit_list;	/* To linked to call pernet exit
						 * methods on dead net (
						 * pernet_ops_rwsem read locked),
						 * or to unregister pernet ops
						 * (pernet_ops_rwsem write locked).
						 */
	struct llist_node	cleanup_list;	/* namespaces on death row */

	struct user_namespace   *user_ns;	/* Owning user namespace */
	struct ucounts		*ucounts;
	spinlock_t		nsid_lock;
	struct idr		netns_ids;

	struct ns_common	ns;

	struct proc_dir_entry 	*proc_net;
	struct proc_dir_entry 	*proc_net_stat;

#ifdef CONFIG_SYSCTL
	struct ctl_table_set	sysctls;
#endif

	struct sock 		*rtnl;			/* rtnetlink socket */
	struct sock		*genl_sock;

	struct uevent_sock	*uevent_sock;		/* uevent socket */

	struct list_head 	dev_base_head;
	struct hlist_head 	*dev_name_head;
	struct hlist_head	*dev_index_head;
	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
	int			ifindex;
	unsigned int		dev_unreg_count;

	/* core fib_rules */
	struct list_head	rules_ops;

	struct list_head	fib_notifier_ops;  /* Populated by
						    * register_pernet_subsys()
						    */
	struct net_device       *loopback_dev;          /* The loopback */
	struct netns_core	core;
	struct netns_mib	mib;
	struct netns_packet	packet;
	struct netns_unix	unx;
	struct netns_ipv4	ipv4;
#if IS_ENABLED(CONFIG_IPV6)
	struct netns_ipv6	ipv6;
#endif
#if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
	struct netns_ieee802154_lowpan	ieee802154_lowpan;
#endif
#if defined(CONFIG_IP_SCTP) || defined(CONFIG_IP_SCTP_MODULE)
	struct netns_sctp	sctp;
#endif
#if defined(CONFIG_IP_DCCP) || defined(CONFIG_IP_DCCP_MODULE)
	struct netns_dccp	dccp;
#endif
#ifdef CONFIG_NETFILTER
	struct netns_nf		nf;
	struct netns_xt		xt;
#if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
	struct netns_ct		ct;
#endif
#if defined(CONFIG_NF_TABLES) || defined(CONFIG_NF_TABLES_MODULE)
	struct netns_nftables	nft;
#endif
#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
	struct netns_nf_frag	nf_frag;
	struct ctl_table_header *nf_frag_frags_hdr;
#endif
	struct sock		*nfnl;
	struct sock		*nfnl_stash;
#if IS_ENABLED(CONFIG_NETFILTER_NETLINK_ACCT)
	struct list_head        nfnl_acct_list;
#endif
#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
	struct list_head	nfct_timeout_list;
#endif
#endif
#ifdef CONFIG_WEXT_CORE
	struct sk_buff_head	wext_nlevents;
#endif
	struct net_generic __rcu	*gen;

	struct bpf_prog __rcu	*flow_dissector_prog;

	/* Note : following structs are cache line aligned */
#ifdef CONFIG_XFRM
	struct netns_xfrm	xfrm;
#endif
#if IS_ENABLED(CONFIG_IP_VS)
	struct netns_ipvs	*ipvs;
#endif
#if IS_ENABLED(CONFIG_MPLS)
	struct netns_mpls	mpls;
#endif
#if IS_ENABLED(CONFIG_CAN)
	struct netns_can	can;
#endif
#ifdef CONFIG_XDP_SOCKETS
	struct netns_xdp	xdp;
#endif
	struct sock		*diag_nlsk;
	atomic_t		fnhe_genid;
} __randomize_layout;
```