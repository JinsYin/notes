# 部署 NFS 集群

## 集群环境

| IP            | Role       |
| ------------- | ---------- |
| 192.168.1.224 | nfs server |
| 192.168.1.225 | nfs client |

## 服务端部署

* 安装

```bash
# centos
$ yum install -y rpcbind nfs-utils

# ubuntu
$ apt-get install rpcbind nfs-kernel-server
```

* 配置

```bash
# 创建存储目录
$ mkdir -p /data/nfs

# 配置（指定了两个网段，不同网段的机器有不同的权限）
$ vi /etc/exports
/data/nfs 192.168.1.0/24(rw,no_root_squash,no_all_squash,sync,anonuid=501,anongid=501) 192.168.5.0/24(rw)

# 配置立即生效，通过这种方式不需要再重启 nfs 服务
$ exportfs -r
```

相关说明：

* `/data/nfs`: 希望共享的目录
* `192.168.1.0/24(...)`: 共享给哪些网段、IP 、域名或者所有机器（设置为 '*'），多个之间使用空格分隔；括号里面是权限参数

权限参数：

| 参数值                     | 参数说明                                                                                                                                                                                                                                                                            |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rw/ro                      | 共享目录的权限为可读写或只读，最终权限与文件系统的 rwx 及身份有关                                                                                                                                                                                                                   |
| sync/async                 | sync: 数据会同步写入到内存和磁盘；async: 数据先暂存于内存中，而非直接写入磁盘                                                                                                                                                                                                       |
| root_squash/no_root_squash | 客户端使用 NFS 文件系统的账号若为 root 时，系统该如何判断这个账号的身份？预设的情况下，客户端 root 的身份会由 root_squash 的设定压缩成 nfsnobody， 如此对服务器的系统会较有保障。但如果你想要开放客户端使用 root 身份来操作服务器的文件系统，那么这里就得要开 no_root_squash 才行！ |
| all_squash                 | 不论客户端使用什么身份访问服务端，都将其当做是匿名用户，通常是 `nobody(nfsnobody)`                                                                                                                                                                                                  |
| anonuid/anongid            | 上面的 *_squash 提到的匿名用户的 UID 通常是 `nobody(nfsnobody)`，但是可以自行定义。同时这个 UID 必须存在于 /etc/passwd 中；anonuid 指的是匿名用户的 UID 而 anongid 则是匿名用户的 GID                                                                                               |

* 启动

启动 NFS 之前需要先启动 RPC，否则 NFS 会无法向 RPC 注册。另外，RPC 若重新启动时，原本注册的数据会丢失，因此 RPC 重新启动后，它管理的所有服务都需要重新启动来重新向 RPC 注册。

```bash
# 启动服务
$ systemctl start rpcbind nfs

# 查看状态
$ systemctl status rpcbind nfs

# 开机自启动
$ systemctl enable rpcbind nfs

# 查看端口
$ netstat -tpln | grep -E "111|2049"
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/systemd
tcp        0      0 0.0.0.0:2049            0.0.0.0:*               LISTEN      -
tcp6       0      0 :::111                  :::*                    LISTEN      1/systemd
tcp6       0      0 :::2049                 :::*                    LISTEN      -

# 查看 nfs 相关的服务
$ systemctl list-unit-files | grep nfs
proc-fs-nfsd.mount                          static
var-lib-nfs-rpc_pipefs.mount                static
nfs-blkmap.service                          disabled
nfs-config.service                          static
nfs-idmap.service                           static
nfs-idmapd.service                          static
nfs-lock.service                            static
nfs-mountd.service                          static
nfs-rquotad.service                         disabled
nfs-secure.service                          static
nfs-server.service                          enabled
nfs-utils.service                           static
nfs.service                                 enabled
nfslock.service                             static
nfs-client.target                           enabled
```

## 客户端挂载

* 安装客户端

```bash
# centos
$ yum install -y nfs-utils

# ubuntu
$ apt-get install -y nfs-common
```

* 挂载

```bash
# 查看可挂载列表
$ showmount -e 192.168.1.224
Export list for 192.168.1.224:
/data/nfs 192.168.1.0/24

$ mkdir -p /mnt/host224
$ mount -t nfs 192.168.1.224:/data/nfs /mnt/host224

$ df -h | grep mnt
192.168.1.224:/data/nfs  42G  15G  28G  34%  /mnt/host224
```

客户端在挂载的时候遇到的一个问题如下，可能是网络不太稳定，NFS 默认是用 UDP 协议，换成 TCP 协议即可：

```bash
# TCP 协议
$ mount -t nfs 192.168.1.224:/data/nfs /mnt/host224 -o proto=tcp -o nolock
```

* 卸载

```bash
# umount -t nfs /mnt/host224
$ umount -t nfs 192.168.1.224:/data/nfs
```

## 高可用

* [1 NFS高可用解决方案之DRBD+heartbeat搭建](http://www.cnblogs.com/liaojiafa/p/6129499.html)
* [2 NFS高可用解决方案之NFS的搭建](http://www.cnblogs.com/liaojiafa/p/6129514.html)

## 参考

* [鸟哥的私房菜 - NFS 服务器](http://cn.linux.vbird.org/linux_server/0330nfs.php)
* [NFS\Samba\Http\FTP四个协议合一目录](https://jingyan.baidu.com/article/73c3ce280d83f2e50343d917.html)