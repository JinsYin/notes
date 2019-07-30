# 挂载与卸载

## 单根目录层级与多根目录层级

Linux 上所有文件系统中的文件都位于单根目录树下，树根是根目录 `/`。其他文件系统被挂载在根目录之下，视为整个目录层级的子树（subtree）。

## 挂载点

![挂载点](.images/mountpoint.gif)

## 挂载与卸载

挂载文件系统:

```sh
# 将名为 device 的文件系统挂载到 directory 目录
$ sudo mount -t <type> <device> <directory>
```

卸载：

```sh
$ sudo umount <device>
# 或
$ sudo umount <directory>
```

查看已挂载的文件系统：

```sh
$ mount
```

## 示例

```sh
# 查看当前内核所知道的文件系统
$ cat /proc/filesystems

# 第一列是 inode 编号
$ ls -li /etc/passwd
702721 -rw-r--r--  1 root  wheel  6804  2 26 11:36 /etc/passwd
```