# KVM 安装

## 安装准备

安装虚拟机之前，需要先检查宿主机是否支持 KVM 虚拟化。

### BIOS 支持

需要在 BIOS 中开启虚拟化选项。

```BIOS
Intel(R) Virtualization Tech [Enabled]
```

### 内核支持

KVM 的内核组件已经从 Linux `2.6.20` 版本集成到主线中。

```bash
$ uname -r
3.10.0-514.26.2.el7.x86_64

# 检查是否加载了 kvm 模块
$ lsmod | grep kvm

# 加载 kvm 模块
$ modprobe kvm
$ modprobe kvm-intel # Intel
$ modprobe kvm-amd   # AMD
```

### 硬件支持

KVM 虚拟化要求宿主机的 CPU 支持虚拟化，其中 Intel 处理器是 `VT-x`，而 AMD 处理器是 `AMD-V`。

```bash
$ lscpu | grep -i "Virtualization"
Virtualization: VT-x

# Intel: vmx, AMD: svm
$ grep -E "(vmx|svm)" /proc/cpuinfo
```

## 命令行安装

### 安装组件

* CentOS

```bash
$ yum install -y qemu-kvm libvirt virt-install bridge-utils # qemu-kvm-tools

# 安装成功后
$ ls /dev/kvm
INFO: /dev/kvm exists
KVM acceleration can be used

$ systemctl start libvirtd
$ systemctl enable libvirtd
$ systemctl status libvirtd
```

* Ubuntu

```bash
$ apt-get install -y qemu-kvm libvirt-bin virtinst bridge-utils

# 安装成功后
$ kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used

$ service libvirt-bin start
$ service libvirt-bin status
```

### 验证

```bash
# 连接 libvirt（/var/run/libvirt/libvirt-sock） 查看虚拟机列表
$ virsh list --all

# 查看自动创建的网桥
$ brctl show
virbr0    8000.5254003c0a6a yes   virbr0-nic
```

### 安装虚拟机

```bash
# 镜像尽量放在 /home 目录下，否则可能导致没有权限
$ mkdir -p /home/kvm/{img,vms}

# 创建网桥设备
$ brctl addbr kvm0

# 开启路由转发
$ sysctl net.ipv4.ip_forward=1

# 安装 CentOS 虚拟机
$ virt-install \
  --virt-type=kvm \
  --name=centos73 \
  --vcpus=2 \
  --memory=8192 \
  --location=/home/kvm/img/CentOS-7-x86_64-Minimal-1611.iso \
  --extra-args='console=ttyS0' \
  --os-type=linux \
  --os-variant=rhel7.3 \
  --disk path=/home/kvm/vms/centos73.qcow2,size=40,format=qcow2 \
  --network bridge=kvm0 \
  --graphics=none \
  --autostart \
  --force
```

参数说明：

* `--virt-type`: Hypervisor 类型，如：kvm、qemu、xen 等。
* `--vcpu`: 配置虚拟机 vcpu 的数量。
* `--cpu`: CPU 型号和特点。
* `--metadata`: 配置虚拟机 metadata，如：--metadata name=centos73,describe="CentOS 7.3 base"
* `--connect`: 支持远程安装，如：--connect qemu+ssh://x.x.x.x/system。
* `--location`: 安装所需的镜像源，如：nfs:host/path, http://host/path, ftp://host/path。
* `--extra-args='console=ttyS0'`: 传递给 `--location` 的附加参数，允许通过 `virsh console` 连接虚拟机。
* `--os-type`: 操作系统类型，如：linux、windows、unix。
* `--os-variant`: 操作系统发行版本，如：rhel7、fedora6、win2k。
* `--disk`: 存储选项，如：'path=/exist/disk'、'path=/new/disk,size=5'（GB）、'vol=poolname/volname,device=cdrom,bus=scsi,...'。
* `--filesystem`: 拷贝宿主机目录到虚拟机，如：'/source/dir,/dir/in/guest'、'template_name,/,type=template'
* `--network`: 配置虚拟机网络，如：'bridge=mybr0'、'network=default'、'network=my_libvirt_virtual_net'、'network=mynet,model=virtio,mac=00:11...'、'bridge=br0,model=virtio'。
* `--graphics`: 配置虚拟机的显示设置，如：'vnc'、'spice,port=5901,tlsport=5902'、'none'、'vnc,listen=0.0.0.0,port=5910,password=x'
* `--autostart`: 随宿主机自启动。
* `--force`: 所有提示一律 yes。

### 配置虚拟机（CentOS7.3）

通过命令行安装虚拟机还需要配置系统基础设置，带 `[!]` 基本都需要配置。

```
1) [x] Language settings                 2) [!] Time settings
      (English (United States))                (Timezone is not set.)
3) [!] Installation source               4) [!] Software selection
      (Processing...)                          (Processing...)
5) [!] Installation Destination          6) [x] Kdump
      (No disks selected)                      (Kdump is enabled)
7) [ ] Network configuration             8) [!] Root password
      (Not connected)                          (Password is not set.)
9) [!] User creation
      (No user will be created)
```

* 时间设置（Time settings）

`2` => `1` => `5` => `62`
`2` => `2` => `1` => `cn.pool.ntp.org` => `c`

* Installation source

`3` => `2` => `c`

* Software selection

`4` => `1` => `c`

* Installation Destination

`5` => `c` => `2` => `c` => `1` => `c`

* Network configuration

`7` => `1` => `centos73`
`7` => `2` => `1` => `192.168.10.122`
           => `2` => `255.255.255.0`
           => `3` => `192.168.10.1`
           => `6` => `114.114.114.114`
           => `7`
           => `8`
           => `c` => `c`

也进入 VM 系统后再配置网络。

* Root password

`8` => `test1234` => `test1234` => `yes` => `b`

安装完全后会自动重启宿主机，重启后手动连接虚拟机：

```bash
$ virsh list --all
$ virsh console centos73 # ctrl+] 退出
```

### 配置网络（Bridge 模式）

我采用的网络方案：网桥当做路由器，虚拟机共享物理机进出网络（共享物理设备）。

```
┌─────────────────────────┐      ┌─────────────────┐
│          HOST           │      │Virtual Machine 1│
│ ┌──────┐      ┌───────┐ │      │    ┌──────┐     │
│ │ kvm0 │──┬───│ vnet0 │─│─ ─ ─ │    │ eth0 │     │
│ └──────┘  │   └───────┘ │      │    └──────┘     │
│     │     │             │      └─────────────────┘
│     │     │   ┌───────┐ │      ┌─────────────────┐
│ ┌──────┐  └───│ vnet1 │─│─     │Virtual Machine 2│
│ │ em1  │      └───────┘ │ │    │    ┌──────┐     │
│ └──────┘                │  ─ ─ │    │ eth1 │     │
│ ┌──────┐                │      │    └──────┘     │
│ │ em2  │                │      └─────────────────┘
│ └──────┘                │
└─────────────────────────┘
```

* 宿主机网卡设备

```bash
# 添加网桥设备
$ echo 'BRIDGE="kvm0"' >> /etc/sysconfig/network-scripts/ifcfg-em1

$ cat /etc/sysconfig/network-scripts/ifcfg-em1
TYPE="Ethernet"
BOOTPROTO="none"
IPADDR="192.168.10.120"
GATEWAY="192.168.10.1"
NETMASK="255.255.255.0"
NM_CONTROLLED="no"
DEFROUTE="yes"
PEERDNS="yes"
PEERROUTES="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_PEERDNS="yes"
IPV6_PEERROUTES="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="em1"
UUID="0d6e186c-fe43-42c1-b567-e863fa7cb1f3"
DEVICE="em1"
ONBOOT="yes"
BRIDGE="kvm0"
```

* 宿主机网桥设备

```bash
$ cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-kvm0
TYPE="Bridge" # 桥接类型
BOOTPROTO="static"
DEFROUTE="yes"
PEERDNS="yes"
PEERROUTES="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_PEERDNS="yes"
IPV6_PEERROUTES="yes"
IPV6_FAILURE_FATAL="no"
NM_CONTROLLED="no"
NAME="kvm0"
UUID="0d6e186c-fe43-42c1-b567-e863fa7cb1f3"
DEVICE="kvm0"
ONBOOT="yes"
IPADDR="192.168.10.121" # 选择一个未分配的 IP
PREFIX="24"
GATEWAY="192.168.10.1"
DNS1="114.114.114.114" # 必须添加一个 DNS，否则远程到这个地址没有办法访问外网
```

* 虚拟机网络设备

```bash
$ cat /etc/sysconfig/network-scripts/ifcfg-eth0
TYPE="Ethernet"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth0"
UUID="39b0d9bd-f02f-45cb-91be-ead67bfa5ae9"
DEVICE="eth0"
ONBOOT="yes"
IPADDR="192.168.10.120"
PREFIX="24"
GATEWAY="192.168.10.1"
IPV6_PEERDNS="yes"
IPV6_PEERROUTES="yes"
```

* 重启网卡

```bash
$ ifup kvm0 && ifup em1
$ systemctl restart network

# kvm0 获得新的 IP
$ ifconfig kvm0
kvm0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
      inet 192.168.10.121  netmask 255.255.255.0  broadcast 192.168.10.255
      inet6 fe80::1a66:daff:fe4d:881f  prefixlen 64  scopeid 0x20<link>
      ether 18:66:da:4d:88:1f  txqueuelen 1000  (Ethernet)
      RX packets 22131  bytes 5765367 (5.4 MiB)
      RX errors 0  dropped 0  overruns 0  frame 0
      TX packets 8092  bytes 1107993 (1.0 MiB)
      TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

# 没办法再获取 IP，访问该宿主机只能通过 kvm0 的　IP
$ ifconfig em1
em1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
      inet6 fe80::1a66:daff:fe4d:881f  prefixlen 64  scopeid 0x20<link>
      ether 18:66:da:4d:88:1f  txqueuelen 1000  (Ethernet)
      RX packets 17110  bytes 4143727 (3.9 MiB)
      RX errors 0  dropped 22  overruns 0  frame 0
      TX packets 5556  bytes 776492 (758.2 KiB)
      TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
      device interrupt 51

$ brctl show kvm0
bridge name  bridge id          STP enabled  interfaces
kvm0         8000.1866da4d881f  yes          em
```

## GUI 安装

* 服务端

```bash
# 关闭 SELinux
$ setenforce 0
$ sed -e 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/sysconfig/selinux

# 添加第三方源
$ yum install epel-release

$ yum install -y qemu-kvm libvirt
```

* 桌面端

```bash
# CentOS
$ yum install -y virt-manager

# Ubuntu
$ apt-get -y install virt-manager
```

（截图）



## 参考

* [CentOS7 安装 KVM 虚拟机详解](https://github.com/jaywcjlove/handbook/blob/master/CentOS/CentOS7%E5%AE%89%E8%A3%85KVM%E8%99%9A%E6%8B%9F%E6%9C%BA%E8%AF%A6%E8%A7%A3.md)