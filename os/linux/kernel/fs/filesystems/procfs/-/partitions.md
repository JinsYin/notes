# /proc/partitions

记录了每个磁盘分区的 **主设备号**、**副设备号**、**大小** 和 **名称**。

```sh
$ cat /proc/partitions
major minor  #blocks  name

   7        0     166764 loop0
   7        1      88980 loop1
   7        2      89024 loop2
   7        3      88964 loop3
   7        4     391672 loop4
   7        5     176632 loop5
   7        6     259556 loop6
   7        7     346216 loop7
   8        0  976762584 sda
   8        1  104859648 sda1
   8        2  564700160 sda2
   8        3  307197952 sda3
   8       16  117220824 sdb
   8       17  117218304 sdb1
  11        0    1048575 sr0
```
