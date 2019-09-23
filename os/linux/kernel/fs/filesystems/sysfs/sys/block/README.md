# /sys/block/

块目录包含在系统中发现的每个块设备的子目录。在每个块设备的目录中都有描述许多事情的属性，包括设备的大小和它映射到的dev_t编号。有一个符号链接指向块设备映射到的物理设备（在物理设备树中，稍后解释）。还有一个目录向I/O调度程序公开接口。这个接口提供了一些关于设备请求队列的统计信息，以及一些用户或管理员可以用来优化性能的可调特性，包括动态地更改要使用的I/O调度程序的能力。每个块设备的每个分区都表示为块设备的子目录。这些目录中包含有关分区的只读属性

该目录包含在系统中发现的每个块设备的子目录（符号链接，指向块设备映射到的物理设备 /sys/devices）。每个块设备目录包含诸多属性，包括设备大小、设备编号（major:minor）等。

## 示例

```sh
$ ls -l /sys/block
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop0 -> ../devices/virtual/block/loop0
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop1 -> ../devices/virtual/block/loop1
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop2 -> ../devices/virtual/block/loop2
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop3 -> ../devices/virtual/block/loop3
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop4 -> ../devices/virtual/block/loop4
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop5 -> ../devices/virtual/block/loop5
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop6 -> ../devices/virtual/block/loop6
lrwxrwxrwx 1 root root 0  8月 19 16:30 loop7 -> ../devices/virtual/block/loop7
lrwxrwxrwx 1 root root 0  8月 19 16:30 sda -> ../devices/pci0000:00/0000:00:1f.2/ata1/host0/target0:0:0/0:0:0:0/block/sda
lrwxrwxrwx 1 root root 0  8月 19 16:30 sdb -> ../devices/pci0000:00/0000:00:1f.2/ata2/host1/target1:0:0/1:0:0:0/block/sdb
lrwxrwxrwx 1 root root 0  8月 19 16:30 sr0 -> ../devices/pci0000:00/0000:00:1f.2/ata3/host2/target2:0:0/2:0:0:0/block/sr0
```
