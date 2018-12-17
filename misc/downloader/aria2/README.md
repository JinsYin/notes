# Aria2

aria2 是一个轻量级的 `多协议`、`多源` 命令行下载程序，支持 `HTTP`/`HTTPS`、`FTP`、`SFTP`、`BitTorrent` 和 `Metalink` 协议，并且可以通过内置的 `JSON-RPC` 和 `XML-RPC` 接口控制 aria2 进程。

## 安装

```bash
# Debian/Ubuntu
$ sudo apt-get install -y aria2

# RHEL/CentOS
$ sudo yum install -y aria2
```

## 命令行下载

```bash
# HTTP
$ aria2c http://example.org/mylinux.iso

# 两个源、两种协议
$ aria2c http://a/f.iso ftp://b/f.iso

# 两个连接
$ aria2c -x2 http://a/f.iso

# BitTorrent
$ aria2c http://example.org/mylinux.torrent

# BitTorrent Magnet URI
$ aria2c 'magnet:?xt=urn:btih:248D0A1CD08284299DE78D5C1ED359BB46717D8C'

# Metalink
$ aria2c http://example.org/mylinux.metalink

# URI 文本
$ aria2c -i uris.txt
```

## 配置

尽管可以在 `aria2c` 命令后面直接传递参数，但由于参数过多，所以最好还是把参数放到配置文件。

```bash
# 默认配置路径
$ vi ~/.aria2/aria2.conf
dir=/home/yin/Downloads

#rpc-user=user
#rpc-passwd=passwd
#rpc-secret=secret
enable-rpc=true
rpc-listen-all=true
rpc-allow-origin-all=true
rpc-listen-port=6800

save-session-interval=120
input-file=/etc/aria2/aria2.session
save-session=/etc/aria2/aria2.session

continue=true # 断点续传
max-concurrent-downloads=5 # 最大同时下载任务数
max-connection-per-server=5 # 同服务器连接数
min-split-size=10M # 最小文件分片大小, 下载线程数上限取决于能分出多少片, 对于小文件重要
split=10 # 单文件最大线程数, 路由建议值: 5
max-overall-download-limit=0 # 下载速度限制
max-download-limit=0 # 单文件速度限制
max-overall-upload-limit=0 # 上传速度限制
max-upload-limit=0 # 单文件速度限制

check-certificate=false # 不进行证书校验
```

```bash
$ vi ~/.aria2/aria2.conf
## 下载设置 ##

# 断点续传
continue=true
# 最大同时下载任务数, 运行时可修改, 默认:5
max-concurrent-downloads=5
# 单个任务最大线程数, 添加时可指定, 默认:5
split=16
# 最小文件分片大小, 添加时可指定, 取值范围1M -1024M, 默认:20M
# 假定size=10M, 文件为20MiB 则使用两个来源下载; 文件为15MiB 则使用一个来源下载
min-split-size=1M
# 同一服务器连接数, 添加时可指定, 默认:1
max-connection-per-server=16
# 断开速度过慢的连接
lowest-speed-limit=0
# 整体下载速度限制, 运行时可修改, 默认:0
#max-overall-download-limit=0
# 单个任务下载速度限制, 默认:0
#max-download-limit=0
# 整体上传速度限制, 运行时可修改, 默认:0
#max-overall-upload-limit=0
# 单个任务上传速度限制, 默认:0
#max-upload-limit=0
# 禁用IPv6, 默认:false
#disable-ipv6=true
# 当服务器返回503错误时, aria2会尝试重连
# 尝试重连次数, 0代表无限, 默认:5
max-tries=0
# 重连冷却, 默认:0
#retry-wait=0

## 进度保存相关 ##

# 从会话文件中读取下载任务
# 开启该参数后aria2将只接受session中的任务, 这意味着aria2一旦使用conf后将不再接受来自终端的任务, 所以该条只需要在启动rpc时加上就可以了
#input-file=/Users/name/.aria2/aria2.session
# 在Aria2退出时保存`错误/未完成`的下载任务到会话文件
save-session=/Users/name/.aria2/aria2.session
# 定时保存会话, 0为退出时才保存, 需1.16.1以上版本, 默认:0
save-session-interval=60
# 强制保存会话, 即使任务已经完成, 默认:false
# 较新的版本开启后会在任务完成后依然保留.aria2文件
#force-save=false

## RPC相关设置 ##

# 启用RPC, 默认:false
enable-rpc=true
# 允许所有来源, 默认:false
rpc-allow-origin-all=true
# 允许非外部访问, 默认:false
rpc-listen-all=true
# 事件轮询方式, 取值:[epoll, kqueue, port, poll, select], 不同系统默认值不同
event-poll=kqueue
# RPC监听端口, 端口被占用时可以修改, 默认:6800
#rpc-listen-port=6800
# 设置的RPC授权令牌, v1.18.4新增功能, 取代 --rpc-user 和 --rpc-passwd 选项
#rpc-secret=<TOKEN>
# 设置的RPC访问用户名, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-user=<USER>
# 设置的RPC访问密码, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-passwd=<PASSWD>

## BT/PT下载相关 ##

# 当下载的是一个种子(以.torrent结尾)时, 自动开始BT任务, 默认:true
#follow-torrent=true
# BT监听端口, 当端口被屏蔽时使用, 默认:6881-6999
#listen-port=51413
# 单个种子最大连接数, 默认:55
#bt-max-peers=55
# 打开DHT功能, PT需要禁用, 默认:true
#enable-dht=false
# 打开IPv6 DHT功能, PT需要禁用, 默认:true
#enable-dht6=false
# DHT网络监听端口, 默认:6881-6999
#dht-listen-port=6881-6999
# 本地节点查找, PT需要禁用, 默认:false
bt-enable-lpd=true
# 种子交换, PT需要禁用, 默认:true
#enable-peer-exchange=true
# 每个种子限速, 对少种的PT很有用, 默认:50K
#bt-request-peer-speed-limit=50K
# 客户端伪装, PT需要
#peer-id-prefix=-TR2770-
#user-agent=Transmission/2.77
# 当种子的分享率达到这个数时, 自动停止做种, 0为一直做种, 默认:1.0
#seed-ratio=0
# BT校验相关, 默认:true
#bt-hash-check-seed=true
# 继续之前的BT任务时, 无需再次校验, 默认:false
bt-seed-unverified=true
# 保存磁力链接元数据为种子文件(.torrent文件), 默认:false
bt-save-metadata=true
# 强制加密, 防迅雷必备
#bt-require-crypto=true

## 磁盘相关 ##

#文件保存路径, 默认为当前启动位置
dir=~/Downloads
#另一种Linux文件缓存方式, 使用前确保您使用的内核支持此选项, 需要1.15及以上版本(?)
enable-mmap=true
# 文件预分配方式, 能有效降低磁盘碎片, 默认:prealloc
# 预分配所需时间: 快none < trunc < falloc < prealloc慢
# falloc仅仅比trunc慢0.06s
# 磁盘碎片: 无falloc = prealloc < trunc = none有
# 推荐优先级: 高falloc --> prealloc --> trunc -->none低
# EXT4, btrfs, xfs, NTFS等新型文件系统建议使用falloc, falloc(fallocate)在这些文件系统上可以瞬间创建完整的空文件
# trunc(ftruncate) 同样是是瞬间创建文件, 但是与falloc的区别是创建出的空文件不占用实际磁盘空间
# prealloc 传统的创建完整的空文件, aria2会一直等待直到分配结束, 也就是说如果是在HHD上下载10G文件，那么你的aria2将会一直等待你的硬盘持续满载工作直到10G文件创建完成后才会开始下载
# none将不会预分配, 磁盘碎片程度受下面的disk-cache影响, trunc too
# 请勿在传统文件系统如:EXT3, FAT32上使用falloc, 它的实际效果将与prealloc相同
# MacOS建议使用prealloc, 因为它不支持falloc, 也不支持trunc, but可以尝试用brew安装truncate以支持trunc(ftruncate)
# 事实上我有些不能理解trunc在aria2中的角色, 它与none几乎没有区别, 也就是说:太鸡肋了
file-allocation=trunc
# 启用磁盘缓存, 0为禁用缓存, 需1.16以上版本, 默认:16M
disk-cache=64M
```

```bash
# 后台启动 aria2c 守护进程
$ aria2c --conf-path=/home/yin/.aria2/aria2.conf --enable-rpc --daemon
```

```bash
# http://hostname:port/jsonrpc
$ aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all

# http://token:secret@hostname:port/jsonrpc
$ aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all --rpc-secret=<secret>

# http://username:passwd@hostname:port/jsonrpc
$ aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all --rpc-user=<username> --rpc-passwd=<passwd>
```

### aria2.service

```bash
$ vi /usr/lib/systemd/system/aria2.service
[Unit]
Description=Aria2c download manager
Requires=network.target
After=dhcpcd.service

[Service]
Type=forking
User=root
RemainAfterExit=yes
ExecStart=/usr/bin/aria2c --conf-path=~/.aria2/aria2.conf --daemon
ExecReload=/usr/bin/kill -HUP $MAINPID
RestartSec=1min
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

### Aria2 init.d script

```bash
# chmod +x /etc/init.d/aria2c
$ vi /etc/init.d/aria2
#!/bin/sh
### BEGIN INIT INFO
# Provides:          Aria2
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop::    $network $local_fs $remote_fs
# Should-Start:      $all
# Should-Stop:       $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Aria2 - Download Manager
### END INIT INFO

NAME=aria2c
ARIA2C=/usr/bin/$NAME
PIDFILE=/var/run/$NAME.pid
CONF=/etc/aria2/aria2.conf
ARGS="--conf-path=${CONF}"
USER="www-data"
GROUP="www-data"

test -f $ARIA2C || exit 0

. /lib/lsb/init-functions

echo $PIDFILE

case "$1" in
start)  log_daemon_msg "Starting aria2c" "aria2c"
        start-stop-daemon --start --quiet -b -m --pidfile $PIDFILE --chuid $USER:$GROUP --startas $ARIA2C -- $ARGS
        ;;
stop)   log_daemon_msg "Stopping aria2c" "aria2c"
        start-stop-daemon --stop --quiet --pidfile $PIDFILE
        ;;
restart|reload|force-reload)
        log_daemon_msg "Restarting aria2c" "aria2c"
        start-stop-daemon --stop --retry 5 --quiet --pidfile $PIDFILE
        start-stop-daemon --start --quiet -b -m --pidfile $PIDFILE --chuid $USER:$GROUP --startas $ARIA2C -- $ARGS
        ;;
status)
        status_of_proc -p $PIDFILE $ARIA2C aria2c && exit 0 || exit $?
        ;;
*)      log_action_msg "Usage: /etc/init.d/aria2c {start|stop|restart|reload|force-reload|status}"
        exit 2
        ;;
esac
exit 0
```

* [Aria2 init.d script](https://gist.github.com/KyonLi/f8937a1f486bf35437d340b9e445e997)

## Web UI

WebUI 作为客户端连接 aria2 守护进程，所以需要先在后台启动 aria2c。

* [webui-aria2](https://github.com/ziahamza/webui-aria2)
* [AriaNg](https://github.com/mayswind/AriaNg)
* [YAAW](https://github.com/binux/yaaw)

### webui-aria2

```bash
# Go to "http://localhost"
$ docker run -d --name webui-aria2 --restart=always -p 80:80 timonier/webui-aria2:latest
```

### YAAW

* [YAAW for Chrome](https://chrome.google.com/webstore/detail/yaaw-for-chrome/dennnbdlpgjgbcjfgaohdahloollfgoc)

## 浏览器导出插件

浏览器导出插件负责将各类网盘的资源下载链接通过 RPC 方式传送给 aria2c 下载进程，由 aria2c 负责下载，从而绕开各类网盘的奇葩限制（比如：限速）。

* [迅雷离线助手](https://chrome.google.com/webstore/detail/thunderlixianassistant/eehlmkfpnagoieibahhcghphdbjcdmen?hl=zh-CN)
* [ThunderLixianExporter](https://github.com/binux/ThunderLixianExporter)
* [BaiduExporter](https://chrome.google.com/webstore/detail/baiduexporter/jgebcefbdjhkhapijgbhkidaegoocbjj)
* [115Exporter](https://github.com/acgotaku/115)

> 迅雷官方宣布"7月17日起陆续停止提供第三方远程下载服务"

### 百度网盘 Chrome 插件

* [BaiduExporter](https://github.com/acgotaku/BaiduExporter) - 等待页面刷新完成后才会出现 `导出下载` 按钮
* [baidu-dl](https://chrome.google.com/webstore/detail/baidu-dl/lflnkcmjnhfedgibjackiibmcdnnoadb)

BaiduExporter：

![BaiduExporter 示例](.images/baidu-exporter-example.png)

baidu-dl：

![baidu-dl 示例](.images/baidu-dl-example.png)

## 参考

* [github.com/aria2/aria2](https://github.com/aria2/aria2)
* [aria2.github.io](https://aria2.github.io)