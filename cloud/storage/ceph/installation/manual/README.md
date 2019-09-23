# 手动部署 Ceph

体验部署的乐（烦）趣（恼）

## 目录

* [安装准备](0.preparation.md)
* [安装 Ceph 软件包](1.installation.md)

* [验证集群](varification.md)

## 部署 Monitor

### 时钟同步

```sh
# ntpdate 软件包已被弃用
$ yum install -y ntp

# 同步一次时钟（停止 ntpd 为了避免 ntpdate 不能打开 socket <UDP port 123> 连接 ntp 服务器）
$ systemctl stop ntpd
$ ntpdate -s cn.pool.ntp.org

# 将系统时间写入 BIOS（系统重启后会首先读取 BIOS 时间）
$ hwclock -w

# 后台运行的 ntpd 会不断调整系统时间（具体配置：/etc/ntp.conf）
$ systemctl enable ntpd
$ systemctl start ntpd

# 校验
$ date  # 查看系统时间
$ clock # 查看 BIOS 时间（或 hwclock -r）
```

### 部署

```sh
# 生成一个集群 ID
$ uuidgen
b685757a-7492-4260-b7a9-059852d3894d
```

```sh
$ vi /etc/ceph/ceph.conf
[global]
fsid = b685757a-7492-4260-b7a9-059852d3894d
mon initial members = a b c
auth cluster required = cephx
auth service required = cephx
auth client required = cephx
public_network = 192.168.1.0/24
cluster_network = 192.168.1.0/24

[mon]
mon host = 192.168.1.222:6789 192.168.1.223:6789 192.168.1.224:6789

[mon.a]  # mon_id
host = a # mon_id
mon addr = 192.168.1.222

[mon.b]
host = b
mon addr = 192.168.1.223

[mon.c]
host = c
mon addr = 192.168.1.224
```

```sh
# 生成 Monitor 的 keyring
$ ceph-authtool --create-keyring /etc/ceph/ceph.mon.keyring --gen-key -n mon. --cap mon 'allow *'

$ cat /etc/ceph/ceph.mon.keyring
[mon.]
    key = AQB1IWhbK7P/CxAAtWmkmlx+Q90QZ87eFJh3jw==
    caps mon = "allow *"
```

```sh
# 生成管理员（client.admin） 的 keyring
$ ceph-authtool --create-keyring /etc/ceph/ceph.client.admin.keyring --gen-key -n client.admin --set-uid=0 --cap mon 'allow *' --cap osd 'allow *' --cap mds 'allow *' --cap mgr 'allow *'

$ cat /etc/ceph/ceph.client.admin.keyring
[client.admin]
    key = AQCcUGlbl8EwGxAAj9ybgiyEXoppq3w8MwzjmQ==
    auid = 0
    caps mds = "allow *"
    caps mgr = "allow *"
    caps mon = "allow *"
    caps osd = "allow *"
```

```sh
# 将 client keyring 加入到 Monitor keyring
$ ceph-authtool /etc/ceph/ceph.mon.keyring --import-keyring /etc/ceph/ceph.client.admin.keyring

$ cat /etc/ceph/ceph.mon.keyring
[mon.]
    key = AQAZDmlbhl+VDhAAm9Bn6FK6CwqbwJ78chD/Vw==
    caps mon = "allow *"
[client.admin]
    key = AQCcUGlbl8EwGxAAj9ybgiyEXoppq3w8MwzjmQ==
    auid = 0
    caps mds = "allow *"
    caps mgr = "allow *"
    caps mon = "allow *"
    caps osd = "allow *"
```

```sh
# 生成 monmap
$ monmaptool --create --add a 192.168.1.222 --fsid b685757a-7492-4260-b7a9-059852d3894d /etc/ceph/monmap
```

```sh
# 创建 Monitor （id 设置为 0 后会相应地自动创建 Monitor 目录：/var/lib/ceph/mon/ceph-0）
$ ceph-mon --mkfs --id a --monmap /etc/ceph/monmap --keyring /etc/ceph/ceph.mon.keyring --conf /etc/ceph/ceph.conf
```

```sh
# 修改权限
$ chown ceph:ceph -R /var/lib/ceph/mon/ceph-a
```

```sh
# 启动 Monitor 服务

# 手动方式
$ ceph-mon -f --cluster ceph --id a --setuser ceph --setgroup ceph

# systemd
$ systemctl start ceph-mon@0.service
```

## 参考

* [MANUAL DEPLOYMENT](http://docs.ceph.com/docs/master/install/manual-deployment/)
* [ADDING/REMOVING MONITORS](http://docs.ceph.com/docs/master/rados/operations/add-or-rm-mons/)
