# 符号链接

符号链接（Symbolic link）也称为软链接（Soft link），是一种特殊的文件类型，其数据是另一个文件的文件名，而非 inode 编号，因此可以用来链接不同文件系统中的文件。

Uninx/Linux 的符号链接相当于 Windows 的 “快捷方式”。

## 文件权限和所有权

## 软链接与硬链接

![软链接与硬链接](.images/hardlink-vs-softlink.png)


## 系统调用

* `link()` - 创建硬链接
* `unlink()` - 移除硬链接
* `rename()` - 更改文件名