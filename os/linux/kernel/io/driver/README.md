# Linux 设备驱动（Linux Device Driver）

Linux 驱动（Driver）也叫 Linux 模块（module）。

每种设备类型（由主设备号标识）都有与之相对应的设备驱动，用来处理设备的所有 I/O 请求。设备驱动属于内核代码单元，可以执行一系列操作，通常与相关硬件的输入或输出相对应。无论是物理设备还是伪设备，内核都会提供一种设备驱动，并实现与真实设备相同的 API 。

* Display Driver
* Camera Driver
* Flash Memory Driver
* Binder（IPC） Driver
* Keypad Driver
* WiFi Driver
* Audio Driver

---

* Block Device Drivers
* Network Device Drivers
* Character Device Drivers
* GPU Drivers

## 参考

* [Linux Hardware Monitoring](https://www.kernel.org/doc/html/latest/hwmon/index.html)
* [The Linux driver implementer’s API guide](https://www.kernel.org/doc/html/latest/driver-api/index.html)