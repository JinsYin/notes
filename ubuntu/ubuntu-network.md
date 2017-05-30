# Ubuntu 网络

## 设置静态IP
```bash
$ sufo vi /etc/network/interfaces
auto eth0
iface eth0 inet static
  address 192.168.0.100
  gateway 192.168.0.1
  netmask 255.255.255.0
  network 192.168.0.0
  broadcast 192.168.0.255
```

## 没有ifconfig命令
```bash
$ sudo apt-get install net-tools
```

## Ubuntu 没有网络
  1. ifconfig 检查是否有网卡驱动

  2. iwconfig 检查是否连上网

  3. sudo iw wlan0 scan | grep SSID 显示周围wifi

  4. sudo if up wlan0 或 sudo ifconfig wlan0 up 开启网络接口

  5. 确保bios使用IEFI
