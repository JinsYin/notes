# inode 对象

单个 dentry 通常有一个指向 inode 的指针。inode 是文件系统对象，如常规文件、目录、FIFO 。它们要么存在于磁盘上（对于块设备文件系统），要么存在于内存中（对于伪文件系统）。存储在磁盘上的 inode 会在需要时复制到内存中，对 inode 所做的更改会写会磁盘。一个 inode 可以被多个 dentry（如硬链接）指向。


要查找一个 inode，需要 VFS 调用父目录 inode 的 `lookup()` 方法。此方法由 inode 所在的特定文件系统实现安装。一旦 VFS 有了所需的 dentry（因此也有了 inode），就可以执行 `open()` 来打开文件，执行 `stat()` 来查看 inode 数据。`stat()` 相对简单：一旦 VFS 有了 dentry，它就会偷看 inode 数据，并将其中一些数据传递会用户空间。