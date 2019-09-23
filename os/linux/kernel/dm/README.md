# Linux 设备管理

## 目录

* [设备文件](device-file.md)
* [设备驱动程序](drivers/README.md)
* [中断和中断处理](interrupt/README.md)
* [udev](udev/README.md)

## 作用

Linux 内核中，每种设备类型（由主设备号标识）都有与之相对应的设备驱动，用来处理（来自 buffer cache）面向设备（Disk controller）的所有 I/O 请求。设备驱动属于内核代码单元，可以执行一系列操作，通常与相关硬件的输入或输出相对应。无论是物理设备还是伪设备，内核都会提供一种设备驱动，并实现与真实设备相同的 API 。

## 设备类型

* 字符设备：提供连续的数据流，应用程序可以顺序读取，通常不支持随机存取。相反，此类设备支持按字节或字符来读写数据。
* 块设备：应用程序可以随机访问设备数据，即自行确定读取数据的位置。此外，数据的读写只能以块（即扇区，通常是 512B）的倍数进行。

编写块设备驱动程序比字符设备更复杂，因为内核为提高系统性能使用了缓存机制。（字符设备不经过缓存？）

## 参考

* [Device Drivers](https://www.tldp.org/LDP/tlk/dd/drivers.html)
* [Linux Hardware Monitoring](https://www.kernel.org/doc/html/latest/hwmon/index.html)
* [The Linux driver implementer’s API guide](https://www.kernel.org/doc/html/latest/driver-api/index.html)
