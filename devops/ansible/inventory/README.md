# Ansible Inventory

Ansible 可以同时操作一个组中的多台主机（也可以同时操作所有主机），组与主机之间的关系通过 inventory 文件配置，默认文件路径为 `/etc/ansible/hosts`。除默认文件外，还可以同时使用多个 inventory 文件，也可以从动态源，或云上拉取 inventory 配置信息。


## 主机和组

方括号 `[]` 中是组名，用于对系统进行分类，便于对不同系统进行个别的管理。

```sh
$ cat /etc/ansible/hosts
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```

```sh
# 如果远程主机的 ssh 端口不是标准的 22 端口
git.example.com:22022

# 为静态 IP 地址设置别名 jumper
jumper ansible_ssh_port=5555 ansible_ssh_host=192.168.1.50

# 相似的 hostname
www[1:50].example.com
www-[a:f].example.com

# 指定连接类型和连接用户名
other1.example.com ansible_connection=ssh ansible_ssh_user=mpdehaan
other2.example.com ansible_connection=ssh ansible_ssh_user=mdehaan
```


## 主机变量

分配变量给主机很容易做到,这些变量定义后可在 playbooks 中使用。

```sh
[atlanta]
host1 http_port=80 maxRequestsPerChild=808
host2 http_port=303 maxRequestsPerChild=909
```


## 组的变量

也可以定义属于整个组的变量

```sh
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```


## 把一个组作为另一个组的子成员

可以把一个组作为另一个组的子成员,以及分配变量给整个组使用. 这些变量可以给 /usr/bin/ansible-playbook 使用,但不能给 /usr/bin/ansible 使用

```
[atlanta]
host1
host2

[raleigh]
host2
host3

[southeast:children]
atlanta
raleigh

[southeast:vars]
some_server=foo.southeast.example.com
halon_system_timeout=30
self_destruct_countdown=60
escape_pods=2

[usa:children]
southeast
northeast
southwest
northwest
```


## Inventory 参数

```
ansible_ssh_host
      将要连接的远程主机名.与你想要设定的主机的别名不同的话,可通过此变量设置.

ansible_ssh_port
      ssh端口号.如果不是默认的端口号,通过此变量设置.

ansible_ssh_user
      默认的 ssh 用户名

ansible_ssh_pass
      ssh 密码(这种方式并不安全,我们强烈建议使用 --ask-pass 或 SSH 密钥)

ansible_sudo_pass
      sudo 密码(这种方式并不安全,我们强烈建议使用 --ask-sudo-pass)

ansible_sudo_exe (new in version 1.8)
      sudo 命令路径(适用于1.8及以上版本)

ansible_connection
      与主机的连接类型.比如:local, ssh 或者 paramiko. Ansible 1.2 以前默认使用 paramiko.1.2 以后默认使用 'smart','smart' 方式会根据是否支持 ControlPersist, 来判断'ssh' 方式是否可行.

ansible_ssh_private_key_file
      ssh 使用的私钥文件.适用于有多个密钥,而你不想使用 SSH 代理的情况.

ansible_shell_type
      目标系统的shell类型.默认情况下,命令的执行使用 'sh' 语法,可设置为 'csh' 或 'fish'.

ansible_python_interpreter
      目标主机的 python 路径.适用于的情况: 系统中有多个 Python, 或者命令路径不是"/usr/bin/python",比如  \*BSD, 或者 /usr/bin/python
      不是 2.X 版本的 Python.我们不使用 "/usr/bin/env" 机制,因为这要求远程用户的路径设置正确,且要求 "python" 可执行程序名不可为 python以外的名字(实际有可能名为python26).

      与 ansible_python_interpreter 的工作方式相同,可设定如 ruby 或 perl 的路径....
```
