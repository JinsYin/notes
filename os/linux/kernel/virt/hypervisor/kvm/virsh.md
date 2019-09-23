# virsh

## 管理虚拟机

* 虚拟机

```sh
# 查看运行的虚拟机（连接 /var/run/libvirt/libvirt-sock）
$ virsh list

# 查看关闭和运行的虚拟机
$ virsh list --all

# 启动虚拟机
$ virsh start centos-vm-1

# 重启虚拟机
$ virsh reboot centos-vm-1

# 关闭虚拟机
$ virsh shutdown centos-vm-1

# 强制关机
$ virsh destroy centos-vm-1

# 删除虚拟机配置文件（默认路径：/etc/libvirt/qemu/kube-node-122.xml）
# 如果虚拟机同时还被关机，将自动删除虚拟机
$ virsh undefine centos-vm-1

# 虚拟机随宿主机启动而启动
$ virsh autostart centos-vm-1

# 关闭自启动
$ virsh autostart --disable centos-vm-1

# 连接虚拟机（退出：'CTRL' + ']'）
$ virsh console centos-vm-1
```

* 网络

```sh
# 查看虚拟机网络
$ virsh net-list --all

# 查看具体的网络配置
$ virsh net-dumpxml default

# 查看网络接口
$ virsh iface-list

# 修改
$ virsh net-edit default

# 启动
$ virsh net-start default

# 开机自启动
$ virsh net-autostart default

# 删除
$ virsh net-destroy <net-name>
$ virsh net-undefine <net-name>
```

网桥方式的配置与虚拟机支持模块安装时预置的虚拟网络桥接接口virbr0没有任何关系，配置网桥方式时，可以把virbr0接口（即NAT方式里面的default虚拟网络）删除。

## 连接虚拟机

* ssh

```sh
$ ssh username@ip
```

* virsh console

```sh
# 本地
$ virsh console kube-node-122  # ctrl+] 退出
$ virsh -c qemu:///system kube-node-122

# 远程
$ virsh -c qemu+ssh://192.168.10.120/system console kube-node-122
```

注：`virsh console` 只支持最多一个会话连接。

* virt-viewer

```sh
# 本地
$ virt-viewer kube-node-122
$ virt-viewer -c qemu:///system kube-node-122

# 远程
$ virsh -c qemu+ssh://192.168.10.120/system console kube-node-122
```

* vnc

需要虚拟机事先配置好 vnc 服务。

```sh
# 本地
$ vncviewer $(virsh vncdisplay kube-node-122)
```

* virt-manager

（截个图）

## 参考

* [KVM 通过 virsh console 连入虚拟机](http://www.cnblogs.com/xieshengsen/p/6215168.html)
* [kvm：连接虚拟机的几种方式（ssh，vnc，console，virt-viewer）](http://blog.csdn.net/lidonghat/article/details/70833486)
