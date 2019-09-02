# OpenSSH

## 工作原理

## SSHPASS

SSH 直接通过 TTY 获取用户密码并登录目标主机，以确保密码确实是由交互式键盘用户输入的。SSHPASS 在专用 TTY 中运行 SSH，以欺骗它这是从交互式用户中获取到的密码，从而实现免交互 SSH 登录。

`sshpass` 选项之后指定的是需要运行的命令，通常是带参数的 `ssh`、`ssh-copy-id` 等，不过也可以是任何其他命令。

* 安装

```sh
$ yum install -y sshpass
```

* sshpass & ssh-copy-id

```sh
$ sshpass -p <password> ssh-copy-id root@192.168.1.100
```

## 技巧

* 制作虚拟机模板时最好将控制节点的公钥添加到模板中，这样控制节点将可以直接免密钥登录基于该模板创建的虚拟机，即使虚拟机更改密码也不会有任何影响