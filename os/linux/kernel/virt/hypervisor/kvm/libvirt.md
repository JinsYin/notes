# Libvirt

Libvirt 是一个管理虚拟化主机的工具包，为不同的虚拟化技术提供统一的 API 接口，包括 `KVM`、`QEMU`、`Xen`、`VMWare ESX` 等。

## 安装部署

* CentOS

```sh
# 安装
$ yum install -y libvirt

# 运行
$ systemctl start libvirtd
```

* Ubuntu

```sh
# 安装
$ apt-get install -y libvirt-bin

# 运行
$ service start libvirt-bin
```

## 命令行工具
