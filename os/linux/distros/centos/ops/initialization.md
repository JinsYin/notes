# CentOS 系统初始化

* 添加/修改 YUM 源
* 修改 Hostname
* 安装常用工具
* 禁用 SELINUX/firewalld
* Vim 优化
* 同步时间
* 修改 SSH 配置：端口、UseDNS

## 常用工具

* git
* wget
* sshpass - 通常是管理节点
* rsync - 两端都需要安装；文件小可以直接使用 scp 代替
* net-tools

## 添加/修改 EPEL 源

* EPEL 源

EPEL（Extra Packages for Enterprise Linux）由 Fedora 社区打造的开源项目，旨在为 RHEL 及其发行版提供额外的软件包。

```sh
# 安装 epel-release 以自动配置 EPEL 软件源
# 见：'/etc/yum.repos.d/epel.repo' 与 '/etc/yum.repos.d/epel-testing.repo'
$ yum install -y epel-release
```

## 修改主机名

```sh
# 可以单独修改 pretty hostname
hostnamectl set-hostname ip-192-168-1-100.ceph.local
```

## 同步时间