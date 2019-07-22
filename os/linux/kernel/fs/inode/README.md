# inode

术语 _inode_（索引节点） 名称来源：“index node” -> “i-node” -> “inode”

驻留于文件系统之上的每个文件，在 inode 表中都包含一个 inode 。对 inode 的标识，采用的是其在 inode 表中的位置（即数组索引）来表示。文件的 inode 编号是 `ls -li` 命令所显示的第一列。

inode 包含如下信息：

* 文件类型：常规文件、目录...
* 文件所有者：即 UID
* 文件所属组：即 GID
* 三类用户的访问权限
  * “用户”（文件所有者）
  * “组”（文件所属组）
  * “其他人”（所属组之外的用户）
* 三个时间戳（其他命令：`stat`、`touch`）
  * mtime：文件的最后修改时间（通过 `ls -l` 命令查看）
  * atime：文件的最后访问时间（通过 `ls -lu` 命令查看）
  * ctime：文件状态（权限等）的最后改动时间（通过 `ls -lc` 命令查看），Linux 等类 Unix 均不会记录文件的创建时间
* 指向文件的硬链接数量
* 文件大小：以字节为单位
* 分配给文件的数据块数量：以 512 字节一个块为单位
* 指向文件数据块（简称 _文件块_）的指针

## 示例

```sh
$ ls -lid /sys
1 dr-xr-xr-x. 13 root root 0 7月   5 02:53 /sys
```

```sh
$ df -i
Filesystem   Inodes   IUsed   IFree   IUse%   Mounted on
/dev/vda1   7331840 1712167 5619673     24%   /
```

## 参考

* [理解 inode](http://www.ruanyifeng.com/blog/2011/12/inode.html)