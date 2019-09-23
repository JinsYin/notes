# 安装准备

```sh
$ ansible all -i inventory -m yum -a 'name=net-tools state=installed'
```

## 安装 ceph-ansible

```sh
# 安装依赖
$ yum install -y python-pip
$ pip install --upgrade pip
```

```sh
# 克隆项目
$ git clone https://github.com/ceph/ceph-ansible.git && cd ceph-ansible

# 选择相应分支（我部署的是 mimic，所有选择的是 stable-3.2）
$ git checkout $branch

# 安装项目依赖
$ pip install -r requirements.txt
```

## 安装 Ansible 2.6

* CentOS

```sh
# https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/
$ yum install https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.9-1.el7.ans.noarch.rpm
```

```sh
$ ansible --version
-------------------
ansible 2.6.9
```

* Ubuntu

```sh
$ sudo add-apt-repository -y ppa:ansible/ansible
$ sudo apt update
$ sudo apt install -y ansible
```
