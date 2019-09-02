# 安装 Infiniband 驱动

## Option 1: Mellanox Driver

<http://www.mellanox.com/pdf/prod_software/Red_Hat_Enterprise_Linux_(RHEL)_7.4_Driver_User_Manual.pdf>

## Option 2: CentOS Driver

<https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/ch-configure_infiniband_and_rdma_networks>

### 安装 RDMA 软件包

```sh
# 安装 RDMA（卸载：yum -y groupremove "Infiniband Support"）
$ yum groupinfo "Infiniband Support"
$ yum -y groupinstall "Infiniband Support"

# 安装可选包
$ yum -y install infiniband-diags opensm # infiniband-diags perftest gperf
```

### 启动 RDMA 服务

```sh
$ systemctl start rdma
$ systemctl start opensm

# 查看状态
$ systemctl start rdma
$ systemctl start opensm # 所有 IB 节点选举一个 MASTER，其余都是 STANDBY

# 开机自动启动
$ systemctl enable rdma
$ systemctl enable opensm

# 必须重启机器
$ reboot
```

### 修改 memlock

```sh
# 临时修改
$ ulimit -l unlimited

# 永久修改（重新登录即可生效，无需重启；使用 ‘ulimit -l’ 命令进行验证）
$ echo '* soft memlock unlimited' >> /etc/security/limits.conf
$ echo '* hard memlock unlimited' >> /etc/security/limits.conf
```

## Option 3: OFED Driver

<https://www.openfabrics.org/index.php/openfabrics-software.html>