# 设备文件

_设备文件_（Device file）也叫 _设备节点_（Device node）

## 字符设备与块设备

| 设备类型 | 描述                                                         | 例子       |
| -------- | ------------------------------------------------------------ | ---------- |
| 字符设备 | 基于每个字符来处理数据                                       | 终端、键盘 |
| 块设备   | 每次处理一块数据；块的大小取决于设备类型，通常是 512B 的倍数 | 磁盘       |

## 物理设备与伪设备

设备文件不一定对应于物理设备，而缺少这种对应关系的设备文件称为 _伪设备_（Psesudo Device）。

伪设备可以是字符设备或块设备，常见的基于字符设备的伪设备：

| 伪设备        | 描述                                                                                   |
| ------------- | -------------------------------------------------------------------------------------- |
| `/dev/null`   | 写入时，接受并丢弃写入的所有输入；<br> 读取时，提供一个 EOF                            |
| `/dev/zero`   | 写入时，接受并丢弃写入的所有输入；<br> 读取时，产生一个连续的 Null 字符（零值字节）流  |
| `/dev/full`   | 写入时，产生一个 “disk full” 错误；<br> 读取时，产生一个连续的 Null 字符（零值字节）流 |
| `/dev/random` | 变体：`/dev/urandom` 或 `/dev/arandom`                                                 |
| `/dev/pf`     |                                                                                        |
| `/dev/bio`    |                                                                                        |
| `/dev/sysmon` |                                                                                        |

## 创建设备文件

* mknod（make file-system inode）

## 命名约定

以下前缀用于 `/dev` 结构下某些设备的命名，以识别设备的类型。

| 前缀                          | 设备类型                                                                                                                                                                                                                |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lp`                          | 行式打印机（line printer）                                                                                                                                                                                              |
| `pt`                          | 伪终端（psesudo terminal）/虚拟终端（virtual terminal）                                                                                                                                                                 |
| `tty`                         | 终端（terminal）                                                                                                                                                                                                        |
| `fb`                          | 帧缓冲器                                                                                                                                                                                                                |
| `fd`                          | 文件描述符                                                                                                                                                                                                              |
| `hd`                          | IDE 驱动程序                                                                                                                                                                                                            |
| `parport`、`pp`               | 并口（Parallel port）                                                                                                                                                                                                   |
| `nmve`                        | NVMe 驱动程序                                                                                                                                                                                                           |
| `sd`、`ses`、`sg`、`sr`、`st` | SCSI 驱动程序，也被 libata（现代 PATA/SATA 驱动程序）等使用：<br> * `sd`：大容量存储驱动程序 <br> * `ses`：机箱驱动程序 <br> * `sg`：通用 SCSI 层 <br> * `sr`：ROM 驱动程序（面向数据的光驱） <br> * `st`：磁带驱动程序 |
| `tty`                         | 终端 <br> * `ttyS`：串口驱动程序 <br> * `ttyUSB`：USB 串口转换器、调制解调器等                                                                                                                                          |

## 设备号

每个设备文件都有一个 _主设备号_（major number） 和一个 _副设备号_（minor number），可以通过命令 `ls -l /dev/*` 来查看。设备文件的 inode 记录了设备文件的主设备号和副设备号。

| 设备号   | 描述                                                                                                                                                                                                                                              |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 主设备号 | 标识设备对应的驱动程序；常见的主设备号/驱动程序：<br> * **1**：管理 `/dev/null`、`/dev/zero` 等伪设备 <br> * **4**：管理所有终端（`/dev/tty*`）和串口终端（`/dev/ttyS*`） <br> * **7**：管理 `/dev/loop*`、`/dev/vcs*` 和 `/dev/vcsa*` 等设备文件 |
| 副设备号 | 唯一标识具体驱动程序管理的特定设备                                                                                                                                                                                                                |

```sh
# 主设备号：1，副设备号：3
$ ls -l /dev/null
crw-rw-rw- 1 root root 1, 3  7月 10 08:24 /dev/null

# 查询由驱动程序 1 管理的设备
$ ls -l /dev | awk '$5=="1,"'

# 鼠标
$ ls -l /dev/input/mouse*

$ cat /proc/devices
```

## 查找设备驱动

```sh
# 获取设备的类型（b：块设备），以及主设备号（8）和副设备号（0）
$ ls -l /dev/sda
brw-rw---- 1 root disk 8, 0  7月 10 08:24 /dev/sda

# 包含两种类型的设备
$ ls /sys/dev
block char

# 该设备的驱动为 sd（注：分区设备没有 device 子目录）
$ ls readlink /sys/dev/block/8\:0/device/driver # 若不确定设备类型，可用 * 代替 block
../../../../../../../bus/scsi/drivers/sd

# 如果是块设备文件，也可以使用以下两种方式（注：分区设备没有 device 子目录）
$ readlink /sys/block/sda/device/driver
$ readlink /sys/class/block/sda/device/driver
../../../../../../../bus/scsi/drivers/sd
```

```sh
# 使用 udevadm
$ udevadm info -a -n /dev/sda | grep -oP 'DRIVERS?=="\K[^"]+'
```

## 参考

* [mknod 用法以及主次设备号](https://www.cnblogs.com/hnrainll/archive/2011/06/10/2077583.html)
* [How to find the driver (module) associated with a device on Linux?](https://unix.stackexchange.com/questions/97676/how-to-find-the-driver-module-associated-with-a-device-on-linux)