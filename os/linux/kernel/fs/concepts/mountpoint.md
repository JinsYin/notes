# 挂载点（mountpoint）

![挂载点](.images/mountpoint.gif)

## 内核代码

```c
/*
 * <fs/mount.h>
 */
struct mountpoint {
	struct hlist_node m_hash;
	struct dentry *m_dentry;
	struct hlist_head m_list;
	int m_count;
};
```