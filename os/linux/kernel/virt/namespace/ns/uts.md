# UTS Namespace

## 数据结构

```c
/*
 * <include/linux/utsname.h>
 */
struct uts_namespace {
	struct kref kref; /* 嵌入的引用计数器，用于跟踪内核中有多少地方使用了 struct uts_namespace 的实例*/
	struct new_utsname name;
	struct user_namespace *user_ns;
	struct ucounts *ucounts;
	struct ns_common ns;
} __randomize_layout;
```

```c
/*
 * <include/uapi/linux/ustname.h>
 */
#define __NEW_UTS_LEN 64

struct new_utsname {
	char sysname[__NEW_UTS_LEN + 1];  /* 系统名称 */
	char nodename[__NEW_UTS_LEN + 1];
	char release[__NEW_UTS_LEN + 1];
	char version[__NEW_UTS_LEN + 1];
	char machine[__NEW_UTS_LEN + 1];
	char domainname[__NEW_UTS_LEN + 1];
};
```

## 初始设置

```c
/*
 * <init/version.c>
 */
struct uts_namespace init_uts_ns = {
	.kref = KREF_INIT(2),
	.name = {
		.sysname	= UTS_SYSNAME,
		.nodename	= UTS_NODENAME,
		.release	= UTS_RELEASE,
		.version	= UTS_VERSION,
		.machine	= UTS_MACHINE,
		.domainname	= UTS_DOMAINNAME,
	},
	.user_ns = &init_user_ns,
	.ns.inum = PROC_UTS_INIT_INO,
#ifdef CONFIG_UTS_NS
	.ns.ops = &utsns_operations,
#endif
};
```

## uname 工具

**struct new_utsname** 包含的信息可以使用 uname 工具获取。

| 参数                     | 描述                                             | 示例                                  |
| ------------------------ | ------------------------------------------------ | ------------------------------------- |
| `-a`                     | 打印所有信息                                     | ~                                     |
| `-s`、`--kernel-name`    | 打印内核名称，即系统名称                         | `Linux`                               |
| `-n`、`--nodename`       | 打印网络节点的主机名                             | `ip-110.kvm.ew`                       |
| `-r`、`--kernel-release` | 打印内核发行版本（kernel release）               | `3.10.0-693.el7.x86_64`               |
| `-v`、`--kernel-version` | 打印内核版本（kernel version），通常指发行版版本 | `#1 SMP Tue Aug 22 21:09:27 UTC 2017` |
| `-m`、`machine`          | 打印机器硬件名称                                 | `x86_64`                              |

除此之外，也可以在 /proc/sys/kernel/ 中获取到

```sh
$ cat /proc/sys/kernel/ostype    # sysname
$ cat /proc/sys/kernel/osrelease # release
```