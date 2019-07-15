# Ansible 内置模块

## setup

通过 setup module 收集到的系统信息叫做 facts ，这些 facts 可以直接以变量形式使用。

### 用途

查看远程主机的系统信息。

### 用法

查看 facts 变量：

```bash
$ ansible all -m setup
192.168.1.221 | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "198.51.100.1",
            "198.51.100.2",
            "198.51.100.3",
            "172.17.0.1",
            "192.168.1.221"
        ],
        ...
    }
}
```

使用 facts 变量：

```yaml
- hosts: all
  remote_user: root
  tasks:
  - name: echo os family
    shell: echo {{ ansible_os_family }} > /tmp/os-family
  - name: echo ip address
    shell: echo {{ ansible_default_ipv4.address }} > /tmp/ipaddress
  - name: install git on Debian Linux
    apt: name=git state=installed
    when: ansible_os_family == "Debian"
  - name: install git on RedHat Linux
    yum: name=git state=installed
    when: ansible_os_family == "RedHat"
```

关闭 facts:

```yaml
- hosts: whatever
  gather_facts: no
```

## ping

`ping` 模块用于测试远程主机的运行状态。

```bash
$ ansible test_cluster -m ping
192.168.1.222 | success >> {
    "changed": false,
    "ping": "pong"
}

192.168.1.221 | success >> {
    "changed": false,
    "ping": "pong"
}

192.168.1.223 | success >> {
    "changed": false,
    "ping": "pong"
}
```

## file

`file` 模块用于设置文件的属性。

相关选项：

* force: 需要在两种情况下强制创建软链接。一种是源文件不存在，但之后会创建； 另一种是目标软链接已存在，需要先取消之前的软链接，然后在创建新的软链接，有两个选项：yes|no
* group: 设置文件/目录所属的组
* mode: 设置文件/目录的权限
* owner: 设置文件/目录的所有者
* path: 设置文件/目录的路径
* recurse: 递归设置文件的属性，对目录有效
* src: 被链接的源文件路径，只能用于 state=link 的情况
* dest: 被链接的目标文件路径，只能用于 state=link 的情况
* state:
* directory: 如果目录不存在，则创建目录
* file: 即使文件不存在，也不会被创建
* link: 创建软链接
* hark: 创建硬链接
* touch: 如果文件不存在，则创建一个新文件；如果文件/目录已存在，则更新其最后修改时间
* absent: 删除文件、目录，取消链接文件

```bash
# 创建软链接
$ ansible test_cluster -m file -a "src=/etc/resolv.conf dest=/tmp/resolv.conf state=link"

# 删除软链接
$ ansible test_cluster -m file -a "path=/tmp/resolv.conf state=absent"
```

## copy

`copy` 模块用于复制本地文件到远程主机。

相关选项：

* backup: 覆盖之前备份源文件，备份的文件包含时间信息。可选项：yes|no
* content: 用于替换 "src"，可以直接设置指定文件的值
* directory_mode: 递归设定目录的权限，默认为系统的默认权限
* force: 如果目标主机包含该文件，但内容不同，如果设置为 yes，则强制覆盖，如果为 no，则只有当目标主机的目标位置不存在文件时，才复制，默认为 yes
* others: 所有的 file 模块里的选项都可以在此处使用
* src: 被复制到远程主机的本地文件，可以是绝对路径，也可以是相对路径。如果路径是一个目录，则递归复制。如果路径使用 "/" 结尾，则只复制目录里的内容，如果没有使用 "/" 结尾，则包含目录在内的整个内容全部复制，类似 rsync
* dest: 要将源文件复制到的目标主机的绝对路径；如果源文件是一个目录，那么该路径也必须是一个目录

```bash
ansible test_cluster -m copy -a "src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg group=root owner=root mode=0644"
```

## command

`command` 模块用于在远程主机上执行命令。

<!--
不支持 $HOME 和”<”, “>”, “|”, “;” and “&”
-->

相关选项：

* creates: 一个文件名，如果文件存在，则该命令不执行
* free_form: 要执行的 linux 指令
* chdir: 在执行指令之前，先切换到该目录
* remove: 一个文件名，当该文件不存在是，则该选项不执行
* executable: 切换 shell 来执行指令，该执行路径必须是一个绝对路径

```bash
ansible test_cluster -m command -a "uptime"
```

## shell

切换到某个 shell 执行指定的指令，参数与 command 相同。与 command 不同的是，此模块支持命令管道，同时还有另一个模块也具备此功能：raw 。

<!--
支持$HOME和”<”, “>”, “|”, “;” and “&”
-->

```bash
# 在本地创建一个 shell 脚本

$ cat <<EOF > /tmp/getdate.sh
#!/bin/bash
date "+%F %H:%M:%S"
EOF

$ chmod +x /tmp/getdate.sh
```

```bash
# 分发本地脚本到远程主机
$ ansible test_cluster -m copy -a "src=/tmp/getdate.sh dest=/tmp/getdate.sh group=root owner=root mode=0755"

# 远程执行
$ ansible test_cluster -m shell -a "/tmp/getdate.sh"
```

## dnf


## service

### 用法

```bash
ansible all -m service -a 'name=httpd state=started enabled=yes'
```

### 参数

| Parameter | Choices/Defaults                           | Comments                                              |
| --------- | ------------------------------------------ | ----------------------------------------------------- |
| name      |                                            | Service Name                                          |
| state     | reloaded/restarted/running/started/stopped |                                                       |
| enabled   | yes/no                                     | 是否开机自启动。`state` 和 `enabled` 参数至少需要一个 |
| .......   | ................                           | ......                                                |

## user

```bash
ansible all -m user -a "name=alice password=<password>"
```

## git

```bash
ansible web -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"
```

## template

### 用途

拷贝本地文件到远程主机，并替换变量。

### 用法

```bash
ansible all -m template -a 'src=/etc/ansible/hosts dest=/tmp/hosts'
```

## debug

## firewalld

## 更多模块

其他常用模块，比如：service、cron、yum、synchronize就不一一例举，可以结合自身的系统环境进行测试。
service：系统服务管理
cron：计划任务管理
yum：yum软件包安装管理
synchronize：使用rsync同步文件
user：系统用户管理
group：系统用户组管理

```bash
$ ansible-doc -l
acl                  Sets and retrieves file ACL information.
add_host             add a host (and alternatively a group) to the ansible-playbo
airbrake_deployment  Notify airbrake about app deployments
apt                  Manages apt-packages
apt_key              Add or remove an apt key
apt_repository       Add and remove APT repositores
arista_interface     Manage physical Ethernet interfaces
arista_l2interface   Manage layer 2 interfaces
arista_lag           Manage port channel (lag) interfaces
arista_vlan          Manage VLAN resources
assemble             Assembles a configuration file from fragments
assert               Fail with custom message
at                   Schedule the execution of a command or scripts via the at co
authorized_key       Adds or removes an SSH authorized key
...
```

## k8s_raw

Ansible 2.5 支持

## openshift_raw

Ansible 2.5 支持

## 参考

* [](http://blog.51cto.com/sofar/1579894)
* [Ansible modules](https://github.com/ansible/ansible/tree/devel/lib/ansible/modules)