# Linux 命令

## 输出打印

`echo`、`cat`、`nl`、`exec`、`wc -l` 、`split`、`xargs`、`tee`

`nl`，为每行文本显示行号

```bash
$ nl x.md
```

## 环境变量

`set`、`env`、`export`

## 文本过滤

`grep`、`sed`(`tr`)、`awk`

## 资源管理

`top`、`free`、`df`、`du`、`fdisk`

`free`，查看内存容量

```bash
$ free -m # -b: B, -k: KB, -m: MB, -g: GB
```

## 进程管理

`pgrep`、`ps`、`netstat`、`systemd`(`upstart`)、`supervisor`

`pgrep`、`lsof`, 获取进程 pid

```bash
$ pgrep sshd # 通过 /var/run/ 目录下的进程名获取 pid
$ lsof -t -i:22 # 通过端口获取 pid
```

## 文件权限

`chmod`、`chown`

## 网络资源

`iftop`, `nc`(nmap-netcat)

cpu
内存
磁盘
磁盘IO
网络IO

## 远程操作

`ssh`(sftp、pssh)、`scp`(pscp)、 `rsync`(prsync)

## 系统安全

`iptables`、`firewall-cmd`、`ufw`、`selinux`、`apparmor`

## LXC (Linux Container)

`cgroups`、`namespace`
