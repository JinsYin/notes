---
title: Ansible 快速入门
---

# Ansible 快速入门

## 安装

```sh
# CentOS 7
$ yum install -y ansible
```

## 配置

* SSH 免密钥配置

```sh
# 生成 RSA 公私钥：`~/.ssh/id_rsa` 和 `~/.ssh/id_rsa.pub`
$ ssh-keygen -t rsa -P ''

# 将 RSA 公钥写入被监控主机的 authorized_keys 文件中
$ ssh-copy-id <user@host>
```

* 配置 Ansible

```sh
# 备份一份默认配置
$ cp /etc/ansible/{ansible.cfg,ansible.cfg.bak}

# 修改 SSH 的配置
$ vi /etc/ansible/ansible.cfg
remote_port = 22
private_key_file = ~/.ssh/id_rsa
```

* 设置 Ansible Inventory

```sh
$ vi /etc/ansible/hosts
[host22x]
192.168.1.[221:223] # 包含 221 和 223
```

## 示例

```sh
# ping 所有 `host22x` 节点（Ansible 默认使用当前用户名连接远程主机）
$ ansible host22x -m ping  # 试着将 host22x 改成 all
192.168.1.221 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.1.222 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.1.223 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## 访问权限

```sh
# 使用 jinsyin 用户连接远程主机
$ ansible all -m ping -u jinsyin

# 使用 jinsyin 用户连接远程主机，并 sudo 到 root 用户
$ ansible all -m ping -u jinsyin --sudo

# 使用 jinsyin 用户连接远程主机，并 sudo 到 weplay 用户
$ ansible all -m ping -u jinsyin --sudo --sudo-user weplay
```
