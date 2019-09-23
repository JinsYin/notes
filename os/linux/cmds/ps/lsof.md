# lsof

`lsof`（**L**i**S**t **O**pen **F**ile）显示所有进程的 Open Files （包括开启的套接字）。不过它可能显示重复的结果，比如 `/dev/null`。

## 用法

### 列出所有 open files

```sh
$ lsof
COMMAND     PID   TID    USER   FD      TYPE             DEVICE      SIZE/OFF       NODE NAME
systemd       1          root  cwd       DIR              9,127          4096          2 /
systemd       1          root  rtd       DIR              9,127          4096          2 /
systemd       1          root  txt       REG              9,127       1523624     265115 /usr/lib/systemd/systemd
......
```

**FD**（File Descriptor） 的值（`r` 表示读，`w` 表示写，`u` 表示读和写）：

```plain
cwd - Current working directory
txt - Text file
mem - Memory Mapped file
mmap - Memory Mapped device
Number - It represent the actual file descriptor. For example, 0u, 1w and 3r
```

**Type** 表示文件的类型，其值：

```plain
REG - Regular file 常规文件
DIR - Directory
CHR - Character special file 字符特殊文件
FIFO - First in first out
```

### 根据端口查看进程

```sh
$ lsof -i :22 # 设置端口范围 lsof -i :1-1024
COMMAND   PID USER   FD   TYPE     DEVICE SIZE/OFF NODE NAME
sshd     1646 root    3u  IPv4      28299      0t0  TCP *:ssh (LISTEN)
sshd     1646 root    4u  IPv6      28301      0t0  TCP *:ssh (LISTEN)
sshd     6646 root    3u  IPv4 2657432209      0t0  TCP ip-160.node.k8s.ew:ssh->192.168.18.219:11806 (ESTABLISHED)
sshd    13501 root    3u  IPv4 1373497715      0t0  TCP ip-160.node.k8s.ew:ssh->192.168.18.219:7267 (ESTABLISHED)
sshd    14260 root    3u  IPv4 1083515099      0t0  TCP ip-160.node.k8s.ew:ssh->192.168.18.219:14690 (ESTABLISHED)
sshd    24754 root    3u  IPv4 2609265143      0t0  TCP ip-160.node.k8s.ew:ssh->192.168.18.219:10783 (ESTABLISHED)
sshd    26302 root    3u  IPv4 1110132794      0t0  TCP ip-160.node.k8s.ew:ssh->192.168.8.220:37094 (ESTABLISHED)
```

### 列出某进程的 open files

```sh
% lsof -p <pid>
```

### 列出某用户的 open files

```sh
% lsof -u <username>
```

### 干掉某用户的所有操作

```sh
% killall -9 `lsof -t -u <username>`
```

### 目录下的 open files

```sh
% lsof +D <path_of_the_directory>
```

### 基于进程/命令名称查看 open files

```sh
# lsof -c <process_name>
$ lsof -c ssh
COMMAND   PID USER   FD   TYPE             DEVICE SIZE/OFF       NODE NAME
sshd     1646 root  cwd    DIR              9,127     4096          2 /
sshd     1646 root  rtd    DIR              9,127     4096          2 /
sshd     1646 root  txt    REG              9,127   823744     265869 /usr/sbin/sshd
......
```

### 列出所有的网络连接

```sh
$ lsof -i
COMMAND     PID    USER   FD   TYPE     DEVICE SIZE/OFF NODE NAME
chronyd    1133  chrony    1u  IPv4      18522      0t0  UDP localhost:323
chronyd    1133  chrony    2u  IPv6      18523      0t0  UDP localhost:323
rpcbind    1135     rpc    6u  IPv4      13472      0t0  UDP *:sunrpc
rpcbind    1135     rpc    7u  IPv4      13473      0t0  UDP *:878
```

## 参考

* [lsof command usages with example](https://www.crybit.com/lsof-command-usages/)
