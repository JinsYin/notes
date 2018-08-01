# Ansible 快速入门

## 安装

* centos

```bash
$ yum install -y epel-release
$ yum install -y ansible

$ ansible --version
ansible 2.4.2.0
```

* ubuntu

```bash
$ apt-get install software-properties-common
$ apt-add-repository ppa:ansible/ansible
$ apt-get update
$ apt-get install -y ansible

$ ansible --version
ansible 2.4.3.0
```

* pip

```bash
$ pip install --upgrade pip
$ pip install --upgrade ansible
```

* 一键安装

```bash
$ ops/ansible/install-ansible.sh
```


## 配置

* 免秘钥配置

```bash
# 生成公私钥
$ ssh-keygen -t rsa -P ''

# 将公钥写入被监控主机的 authorized_keys 文件中
$ ssh-copy-id <host>
```

* ansible 配置

```bash
$ cp /etc/ansible/{ansible.cfg,ansible.cfg.bak}

$ vi /etc/ansible/ansible.cfg
remote_port = 22
private_key_file = ~/.ssh/id_rsa
```

```bash
$ vi /etc/ansible/hosts
[test_cluster]
192.168.1.[221:223]
```

* 小测试

```bash
# ping 所有节点（Ansible 默认使用当前用户名连接远程主机）
$ ansible all -m ping
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

```bash
# 使用 bruce 用户连接远程主机
$ ansible all -m ping -u bruce

# 使用 bruce 用户连接远程主机，并 sudo 到 root 用户
$ ansible all -m ping -u bruce --sudo

# 使用 bruce 用户连接远程主机，并 sudo 到 batman 用户
$ ansible all -m ping -u bruce --sudo --sudo-user batman
```
