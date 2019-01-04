# 设备文件

在类 Unix 操作系统中，设备文件是设备驱动程序的接口，像普通文件一样出现在文件系统中。

## 伪设备（Pseudo-devices）

* `/dev/null` – 接受并丢弃所有输入；不产生任何输出
* `/dev/zero` – 接受并丢弃所有输入；产生连续的 NUL（zero value）字节流
* `/dev/full` – 读取时产生连续的 NUL（zero value）字节流，并在写入时返回“disk full”信息
* `/dev/random` & `/dev/urandom` – 产生可变长度的伪随机数字流