# Ceph-ansible 部署 Ceph（虚拟机环境）

## 简述

* 8 台 ZEN 虚拟机
* 1 个千兆网络
* 1 块虚拟硬盘
* 小型测试环境，目的是验证各项功能

## Todo

* 升级：Mimic -> N

## 目录

* [集群环境](00.md)
* [安装准备](../pre.md)

## 清除集群

```bash
$ ansible-playbook -i hosts infrastructure-playbooks/purge-cluster.yml

# 卸载所有 ceph 相关软件包
$ ansible all -i hosts -m yum -a 'name=*ceph* state=removed'
```