# Dentry

目录项缓存（Directory Entry Cache，简称 dentry cache 或 dcache）。

VFS 实现了 `open()`、`stat()` 等系统调用，传递给这些系统调用的 pathname 参数由 VFS 用于搜索 dentry cache 。这提供了一种非常快速的查找机制，可以将 pathname（filename）转换为特定的 dentry 。Dentry 存在于内存中而非磁盘（为了性能）。

dentry cache 用来查看整个文件空间（filespace）的视图。由于大多数计算机不能同时在内存中装入所有 dentry，所以会缺少一些缓存位。为了将 pathname 解析为 dentry，VFS 可能需要一路创建 dentry，然后加载 inode 。这是通过查找 inode 来完成的。
