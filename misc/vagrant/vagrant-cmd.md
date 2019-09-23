# Vagrant 命令

## 别名

实际使用过程中发现，`vagrant` 命令特别容易输错，而且有些子命令也有些不方便。

```sh
$ # 方式一
$ alias va='vagrant'

$ # 方式二
$ vi ~/.bashrc
va() {
  if [[ $# -eq 0 ]]; then
    vagrant
    exit 0
  fi
  case $@ in
    -s) vagrant status ;;
    -gs) vagrant global-status ;;
    *) vagrant -h ;;
  esac
}
$ source ~/.bashrc

```

## Box 管理

```sh
$ # 从官网添加，默认添加到 ~/.vagrant.d/boxes 目录，官网：https://app.vagrantup.com/boxes/search
$ vagrant box add centos/7
$
$ # 从官网添加指定版本、并指定 provider
$ vagrant box add centos/7 --box-version=1707.01 --provider=virtualbox
$
$ # 从本地添加
$ vagrant box add centos/7.0 ~/box/centos-7.0-x86_64.box
$
$ # 查看 box 列表
$ vagrant box list
$
$ # 移除 box
$ vagrant box remove [name]
```


## 生理周期管理

* 初始化、启动开发环境

初始化完成后会在当前目录下生成一个 Vagrantfile 文件，基于该文件可以即可启动开发环境，启动后打开 VirtualBox 找到运行虚拟机（默认没有 GUI）。另外，也可以直接从已编辑的 Vagrantfile 中启动 VM 开发环境。

```sh
$ # 初始化
$ vagrant init centos/7
$
$ # 配置文件
$ cat Vagrantfile
$
$ # 启动（启动后进入 running 状态）
$ vagrant up
$
$ # 启动并指定 provider，不执行 provisison 任务
$ vagrant up --provider=virtualbox --no-provision
$
$ # 启动后执行 provision 任务
$ vagrant provision
$
$ # 启动后执行特定的 provision 任务
$ vagrant provision --provision-with shell
```

* 状态

```sh
$ # 查看全局状态（可以获取虚拟机的 ID 和状态）
$ vagrant global-status
$
$ # 通过虚拟机 ID 获取状态
$ vagrant status 1a2b3c4d
$
$ # 根据 Vagrantfile 获取状态（要求与 Vagrantfile 同目录运行该命令）
$ vagrant status
```

* 暂停、重启、关机、开机、删除

如果不指定 ID，默认是针对所有 VM 进行操作。

```sh
$ # 暂停（暂停后进入 saved 状态）
$ vagrant suspend 1a2b3c4d
$
$ # 从暂停状态重启
$ vagrant resume 1a263c4d
$
$ # 关机（关机后进入 poweroff 状态）
$ vagrant halt 1a2b3c4d
$
$ # 开机
$ vagrant up 1a2b3c4d
$
$ # 重启，并重新加载 Vagrantfile 配置
$ vagrant reload 1a2b3c4d
$
$ # 重启但不执行 provision
$ vagrant reload --no-provision 1a2b3c4d
$
$ # 删除
$ vagrant destroy 1a2b3c4d
```


## 远程管理

* 远程连接

默认的用户名/密码：`vagrant/vagrant`。

```sh
$ # ssh 配置
$ vagrant ssh-config
$ vagrant ssh-config 1a2b3c4d
$
$ # 对外开放的端口
$ vagrant port
$ vagrant port 1a2b3c4d
$
$ # 默认使用 vagrant 用户登录
$ vagrant ssh 1a2b3c4d
```

* vagrant-hostmanager 插件

```sh
$ # 先修改配置，再更新虚拟机与宿主机的 hosts 文件
$ vagrant hostmanager
```


## 包管理

* 打包分发

配置好开发环境后即可打包分发给其他用户，打包好后在当前目录下生成一个 package.box 文件。

```sh
$ # 会自动关机
$ vagrant package 1a2b3c4d
```
