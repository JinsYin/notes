# GRUB

## /etc/default/grub

GRUB_DEFAULT 其值为 GRUB 启动菜单中高级选项（如 “Advananced options for Ubuntu”）的索引值，菜单选项定义在 /boot/grub/grub.cfg 文件。

对 /etc/default/grub 更改后，使用 `sudo update-grub` 更新

## 启动设置

主菜单：

```txt
Ubuntu                                          # index: 0
Advanced options for Ubuntu                     # index: 1
Memory test (memtest86+)                        # index: 2
Memory test (memtest86+, serial console 115200) # index: 3
```

子菜单 “Advanced options for Ubuntu”：

```txt
Ubuntu, with Linux 5.2.8
Ubuntu, with Linux 5.2.8 (recovery mode)
Ubuntu, with Linux 4.4.0-148-generic
Ubuntu, with Linux 4.4.0-148-generic (recovery mode)
Ubuntu, with Linux 4.4.0-121-generic
Ubuntu, with Linux 4.4.0-121-generic (recovery mode)
Ubuntu, with Linux 4.2.0-42-generic
Ubuntu, with Linux 4.2.0-42-generic (recovery mode)
Ubuntu, with Linux 4.2.0-27-generic
Ubuntu, with Linux 4.2.0-27-generic (recovery mode)


Ubuntu, with Linux 4.13.0-26-generic                  # index: "1> 0"
Ubuntu, with Linux 4.13.0-26-generic (upstart)        # index: "1> 1"
Ubuntu, with Linux 4.13.0-26-generic (recovery mode)  # index: "1> 2"
Ubuntu, with Linux 4.10.0-42-generic                  # index: "1> 3"
Ubuntu, with Linux 4.10.0-42-generic (upstart)        # index: "1> 4"
Ubuntu, with Linux 4.10.0-42-generic (recovery mode)  # index: "1> 5"
```

更新 GRUB:

```sh
$ sudo update-grub
```

重启
