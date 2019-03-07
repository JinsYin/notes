# Ubuntu 升级内核

## 添加源

```bash
$ sudo add-apt-repository ppa:kernel-ppa/ppa
$ sudo apt-get update
```

## 查看可升级的内核

```bash
$ sudo apt-cache showpkg linux-headers
```

## 安装内核

```bash
$ sudo apt-get install linux-headers-3.8.0-26 linux-headers-3.8.0-26-generic linux-image-3.8.0-26-generic --fix-missing
```

## 重启

```bash
$ sudo reboot
```

## 参考文章

>http://www.wikihow.com/Update-Ubuntu-Kernel