# 虚拟网络

默认的虚拟网络配置包括实现用户模式网络的桥接和iptables规则。流量通过主机接口到外部网络进行NAT。

要使外部主机能够直接访问虚拟机上的服务，需要配置与默认不同类型的网桥。这允许虚拟接口通过物理接口连接到外部网络，从而使其显示为网络其余部分的普通主机。

## 网络模式

摘要：KVM虚拟机网络配置的两种方式：NAT方式和Bridge方式。Bridge方式的配置原理和步骤。Bridge方式适用于服务器主机的虚拟化。NAT方式适用于桌面主机的虚拟化。

* NAT
* Bridge

## 实践

### 虚拟机双网卡

宿主机层面： 需要分别从两块网卡建立两个网桥：eth0->br0, eth1->br1

```bash
# 从libvirt层面：需要配置两个网桥
$ vi /etc/libvirt/qemu/MYVM.xml
<domain type='kvm'>
  ...
  <devices>
    <interface type='bridge'>
      <mac address='54:52:00:**:**:**'/>
      <source bridge='br0'/>
      <target dev='vnet7'/>
      <model type='virtio'/>
    </interface>
    <interface type='bridge'>
      <mac address='54:52:00:**:**:**'/>
      <source bridge='br1'/>
      <target dev='vnet8'/>
      <model type='virtio'/>
    </interface>
  </devices>
  ...
</domain>
```

```bash
# 虚拟机层面：需要添加两块网卡

DEVICE="eth0"
HWADDR="54:52:00:**:**:**"
IPADDR="****"
NETMASK="255.255.255.0"
GATEWAY="*****"
TYPE="Ethernet"
ONBOOT="yes"

DEVICE="eth1"
HWADDR="54:52:00:**:**:**"
IPADDR="*****"
NETMASK="255.255.255.0"
TYPE="Ethernet"
ONBOOT="yes"
```

### 配置多网卡绑定的 KVM 桥接模式

* 绑定网卡

```bash
# 从网卡没有 IP
$ cat /etc/sysconfig/network-scripts/ifcfg-em1
TYPE=Ethernet
BOOTPROTO=none
NAME=em1
DEVICE=em1
ONBOOT=yes
MASTER=bond0
SLAVE=yes
NM_CONTROLLED=no
USERCTL=no

# 从网卡没有 IP
$ cat /etc/sysconfig/network-scripts/ifcfg-em2
TYPE=Ethernet
BOOTPROTO=none
NAME=em2
DEVICE=em2
ONBOOT=yes
MASTER=bond0
SLAVE=yes
NM_CONTROLLED=no
USERCTL=no

# 主网卡有 IP
$ cat /etc/sysconfig/network-scripts/ifcfg-bond0
NAME=bond0
DEVICE=bond0
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode=2 miimon=100"
BOOTPROTO=static
IPADDR=192.168.10.120
NETMASK=255.255.255.0
```

Bonding mode:

* mode=0: Balance Round Robin
* mode=1: Active backup
* mode=2: Balance XOR
* mode=3: Broadcast
* mode=4: 802.3ad
* mode=5: Balance TLB
* mode=6: Balance ALB

```BASH
$ systemctl restart network

$ ifconfig

$ dmesg

$ tail -f /var/log/messages

# 测试拔掉网线，或者关闭网卡连接
$ cat /proc/net/bonding/bond0
```

* 桥接

```bash
# 加载 bonding 模块
$ modprobe --first-time bonding
$ lsmod | grep bonding
```

```bash
# 创建 kvm0 网桥
$ cat /etc/sysconfig/network-scripts/ifcfg-kvm0
TYPE=Bridge
NAME=kvm0
DEVICE=kvm0
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
BOOTPROTO=static
IPADDR=192.168.10.120
NETMASK=255.255.255.0

# 修改 bond0
$ cat /etc/sysconfig/network-scripts/ifcfg-bond0
NAME=bond0
DEVICE=bond0
ONBOOT=yes
NM_CONTROLLED=no
USERCTL=no
BONDING_OPTS="mode1 miimon=100"
BOOTPROTO=none
BRIDGE=kvm0

$ systemctl restart network

$ ifconfig

$ brctl show
```

## 参考

* [kvm 四种简单的网络模型](https://www.cnblogs.com/hukey/p/6436211.html)
* [虚拟机双网卡（外网 and 内网）](http://cloudera.iteye.com/blog/1390080)
* [微课 - KVM 虚拟化下的多网卡绑定 1](https://v.qq.com/x/page/i0360zriu40.html)
* [微课 - KVM 虚拟化下的多网卡绑定 2](https://v.qq.com/x/page/b03609jwnlz.html)