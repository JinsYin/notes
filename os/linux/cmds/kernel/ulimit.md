# ulimit

User limits - 用于限制用户对 **系统资源** 的使用。ulimit 提供对 shell 可用资源及其启动的进程的控制。soft limit 是 Kernel 对相应资源强制执行的值。

```sh
$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 159888
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 159888
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```

```sh
# 每个进程的 hard nofiles limits
$ ulimit -Hn
4096

# 每个进程的 soft nofiles limits
$ ulimit -Sn
1024
```

修改每个进程的最大文件打开数。

## 设置系统资源限制

### 临时性修改

```sh
# nofiles
$ ulimit -n 1024

# nproc
$ ulimit -u 32768

# memlock
$ ulimit -l ulimited
```

### 永久性修改

* 方式一

```sh
# 退出重新登录即生效
$ echo "ulimit -u unlimited" >> /root/.bashrc
```

* 方式二

```sh
$ vi /etc/security/limits.conf
#<domain>        <type>  <item>  <value>
#*               -       core             <value>
#*               -       data             <value>
#*               -       priority         <value>
#*               -       fsize            <value>
#*               soft    sigpending       <value> eg:57344
#*               hard    sigpending       <value> eg:57444
#*               -       memlock          <value>
#*               -       nofile           <value> eg:1024
#*               -       msgqueue         <value> eg:819200
#*               -       locks            <value>
#*               soft    core             <value>
#*               hard    nofile           <value>
#@<group>        hard    nproc            <value>
#<user>          soft    nproc            <value>
#%<group>        hard    nproc            <value>
#<user>          hard    nproc            <value>
#@<group>        -       maxlogins        <value>
#<user>          hard    cpu              <value>
#<user>          soft    cpu              <value>
#<user>          hard    locks            <value>
```

* `<domain>` 可以是：
  * 用户名
  * 组名，带有 `@group` 语法

* `<type>` 可以是：
  * "soft" 执行 soft limits
  * "hard" 执行 hard limits

* `<item>`

## 其他

```sh
# 获取进程的 PID
$ ps aux | grep <process-name>
```

### 查看某进程的 limits

```sh
# 查看该进程的 limits
$ cat /proc/<pid>/limits
```

```sh
# 用户级限制（针对进程、用户、用户组、或者所有<*>），退出重新登录生效
$ vi /etc/security/limits.conf
* soft nofile 4096
* hard nofile 10240
* soft memlock ulimited
* hard memlock ulimited
* soft nproc 65535
* hard nproc 65535
```

## 示例

* ubuntu 修改 open files

```sh
# 查看系统最大值
$ cat /proc/sys/fs/file-max

# 可用的限制
$ ulimit -n

# 如有必要，可以增加 file-max
$ sudo echo "fs.file-max = 102400" >> /proc/sys/fs/file-max
$ sysctl -p

# 不能超过 fs.file-max
$ sudo vi /etc/security/limits.conf
*    soft     nofile    102400
*    hard     nofile    102400
root soft     nofile    102400
root hard     nofile    102400

# 仅限 ubuntu
$ echo "session required pam_limits.so" >> /etc/pam.d/common-session

# 退出重新登录即可生效
$ ulimit -n
```
