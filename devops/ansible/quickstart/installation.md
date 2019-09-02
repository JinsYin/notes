# 安装 Ansible

## CentOS 系统

### 内置源安装

如果系统软件源中有符合条件的 ansible 版本，直接安装即可。

```sh
# EPEL 源中的 ansible 版本更新一些
$ yum install -y epel-release

# 查看存在的 ansible 版本
$ yum list ansible --showduplicates

# 安装系统源中存在的指定版本
$ yum install ansible-2.7*

# 安装系统源中存在的最新版本
$ yum install ansible

# 检查
$ ansible --version
```

### RPM 包安装

如果系统软件源中没有符合条件的 ansible 版本，可以直接 [下载](https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/) RPM 包自行安装。

```sh
# ansible 2.6.9
$ curl -OL https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.9-1.el7.ans.noarch.rpm
$ yum install ansible-2.6.9-1.el7.ans.noarch.rpm

# 检查
$ ansible --version
```

## Ubuntu 系统

```sh
$ apt-get install software-properties-common
$ apt-add-repository ppa:ansible/ansible
$ apt-get update
$ apt-get install -y ansible

$ ansible --version
ansible 2.4.3.0
```

## PIP 安装

```sh
pip install --upgrade pip
pip install --upgrade ansible
```