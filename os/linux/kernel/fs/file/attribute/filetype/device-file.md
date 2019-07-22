# 设备文件

_设备文件_（Device file）也称为 _设备节点_（Device node）。

## 字符设备与块设备

| 设备类型 | 描述                                                         | 例子       |
| -------- | ------------------------------------------------------------ | ---------- |
| 字符设备 | 基于每个字符来处理数据                                       | 终端、键盘 |
| 块设备   | 每次处理一块数据；块的大小取决于设备类型，通常是 512B 的倍数 | 磁盘       |

## 物理设备与伪设备

设备文件不一定对应于物理设备，而缺少这种对应关系的设备文件称为 _伪设备_（Pseudo Device）。

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

## 命名约定

以下前缀用于 `/dev` 结构下某些设备的命名，以识别设备的类型。

| 前缀                          | 设备类型                                                                                                                                                                                                                |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lp`                          | 行式打印机（line printer）                                                                                                                                                                                              |
| `pt`                          | 伪终端（pseudo terminal、pseudotty、pty）/虚拟终端（virtual terminal）                                                                                                                                                  |
| `tty`                         | 终端（terminal）                                                                                                                                                                                                        |
| `fb`                          | 帧缓冲器                                                                                                                                                                                                                |
| `fd`                          | 文件描述符                                                                                                                                                                                                              |
| `hd`                          | IDE 驱动程序                                                                                                                                                                                                            |
| `parport`、`pp`               | 并口（Parallel port）                                                                                                                                                                                                   |
| `nmve`                        | NVMe 驱动程序                                                                                                                                                                                                           |
| `sd`、`ses`、`sg`、`sr`、`st` | SCSI 驱动程序，也被 libata（现代 PATA/SATA 驱动程序）等使用：<br> * `sd`：大容量存储驱动程序 <br> * `ses`：机箱驱动程序 <br> * `sg`：通用 SCSI 层 <br> * `sr`：ROM 驱动程序（面向数据的光驱） <br> * `st`：磁带驱动程序 |
| `tty`                         | 终端 <br> * `ttyS`：串口驱动程序 <br> * `ttyUSB`：USB 串口转换器、调制解调器等                                                                                                                                          |

### 伪终端

_伪终端_（pseudo terminal、pseudotty、pty） 是一对伪设备，其中从伪设备（slave pseudo-device）模拟硬件 _文件终端_ 设备，而主伪设备（master pseudo-device）提供 _终端模拟器进程_ 控制 slave 的方法。

脚本使用的伪终端：

![伪终端](.images/pseudo-terminal.svg)

终端模拟器进程的作用：

* 与用户交互
* 向主伪设备（master pseudo-device）输入文本，供连接到从伪设备（slave pseudo-device）的 shell 使用
* 读取主伪设备（master pseudo-device）的文本输出，并显示给用户

除此之外，终端模拟器进程还必须处理终端的控制命令，如调整终端窗口大小。

常用的终端模拟器程序：

* xterm
* GNOME Terminal
* Konsole
* iTerm2

#### 变种

在 BSD PTY 系统中，从伪设备（形式：`/dev/tty[p-za-e][0-9a-f]`）支持适用于 _文本终端_ 设备的所有系统调用，因此它支持 _登录回话_。主伪设备（形式：`/dev/pty[p-za-e][0-9a-f]`）是与终端模拟器通信的端点（endpoint）。

Unix98 PTY 已将 BSD PTY 淘汰，其命名系统不限制伪终端的数量，也不限制在不存在竞争条件危险的情况下访问这些终端。`/dev/ptmx` 是 “主伪终端多路复用器”。打开它将返回主节点的文件描述符，并导致创建关联的从节点 `/dev/pts/n`。

## 设备号

每个设备文件都有一个 _主设备号_（major device number） 和一个 _副设备号_（minor device number），可以通过命令 `ls -l /dev/*` 查看。

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

* macOS（基于 BSD）的主从伪设备

```sh
$ ls /dev/pty*
$ ls /dev/tty*
```

## 相关命令

* `mknod`（make filesystem inode）- 创建设备文件

## 参考

* [mknod 用法以及主次设备号](https://www.cnblogs.com/hnrainll/archive/2011/06/10/2077583.html)
* [How to find the driver (module) associated with a device on Linux?](https://unix.stackexchange.com/questions/97676/how-to-find-the-driver-module-associated-with-a-device-on-linux)
* [Pseudoterminal](https://en.wikipedia.org/wiki/Pseudoterminal)