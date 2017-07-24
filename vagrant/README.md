# Vagrant

Vagrant 是一个基于 Ruby 开发的工具，用于创建和部署虚拟化开发环境，默认使用 Oracle 开源的 VirtualBox 虚拟化系统，使用 Chef 创建自动化虚拟化环境。


## 安装

* VirtualBox

Vagrant 默认使用 virtualbox 作为 provider, 同时也支持 hyperv、libvirt、vmware_desktop。

```bash
$ # ubuntu
$ sudo apt-get install -y virtualbox
$
$ # 官网
$ curl https://www.virtualbox.org/wiki/Downloads
```

* Vagrant

```bash
$ # ubuntu
$ sudo apt-get install -y vagrant
$
$ # 版本
$ vagrant version
$
$ # 官网
$ curl https://www.vagrantup.com/downloads.html
```


## 操作

* 添加、查看、移除 box

```bash
$ # 从官网添加，默认添加到 ~/.vagrant.d/boxes 目录，官网：https://app.vagrantup.com/boxes/search
$ vagrant box add centos/7
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

* 初始化、启动开发环境

初始化完成后会在当前目录下生成一个 Vagrantfile 文件，基于该文件可以即可启动开发环境，启动后打开 VirtualBox 找到运行虚拟机（默认没有 GUI）。

```bash
$ # 初始化
$ vagrant init centos/7
$
$ # 配置文件
$ cat Vagrantfile
$
$ # 启动（启动后进入 running 状态）
$ vagrant up
```

* 状态

```bash
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

```bash
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
$ # 删除
$ vagrant destroy 1a2b3c4d
```

* 远程连接

默认的用户名/密码：`vagrant/vagrant`。

```bash
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

* 打包分发

配置好开发环境后即可打包分发给其他用户，打包好后在当前目录下生成一个 package.box 文件。

```bash
$ # 会自动关机
$ vagrant package 1a2b3c4d
```

* 其他

```bash
$ # 在多台机器之间同步更新　/etc/hosts
$ vagrant hostmanager
```


## Vagrantfile 配置

* 默认配置

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# 1 表示 1.0.x 版本的配置
# 2 表示 1.1+ 到 2.0.x 版本的配置
Vagrant.configure("2") do |config|
  # 来自 vagrant box list
  config.vm.box = "centos/7"
end
```

* vagrant 版本要求

```ruby
Vagrant.require_version ">= 1.3.5"

# OR

Vagrant.require_version ">= 1.3.5", "< 1.4.0"
```

* 指定　box　版本

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_version "v1706.02"
end
```

* 配置主机名

```ruby
config.vm.hostname = "centos01"
```

* 配置网络

```ruby
config.vm.network = "public_network"
```

OR

```ruby
ip = "10.0.2.#{i+100}"
config.vm.network :private_network "#{ip}"
```

OR

```ruby
servers = {
  :host1 => '192.168.33.20',
  :host2 => '192.168.33.21'
}

Vagrant.configure("2") do |config|
  servers.each do |server_name, server_ip|
    config.vm.define server_name do |server|
      server.vm.hostname = "#{server_name.to_s}"
      server.vm.network :private_network, ip: server_ip
      server.vm.provider "virtualbox" do |vb|
        vb.name = server_name.to_s
      end
    end
  end
end
```

* provider

```ruby
config.vm.provider :virtualbox do |vb|
  # 默认没有 GUI
  vb.gui = true

  # 虚拟机名称
  vb.name = "my_vm"

  # CPU
  vb.cpus = 1

  # 内存
  vb.memory = "2048"
end
```

* 同步目录

```ruby
config.vm.synced_folder "../data", "/vagrant_data"
```

* 端口转发

```ruby
config.vm.network "forwarded_port", guest: 80, host: 8080
```

* 集成预安装

如果是初次启动虚拟机，运行 `vagrant up` 即可自动运行下面的初始化命令。如果不是初次启动虚拟机，而是修改了命令，可以使用 `vagrant reload --provision` 命令来重新加载。

```ruby
config.vm.provision "shell", inline: <<-SHELL
  # ifconfig ...
  yum install -y net-tools
  # docker
  yum install -y docker-1.12.6
  systemctl restart docker.service
  systemctl enable docker.service
SHELL
```

```ruby
# 执行一个 shell 脚本
config.vm.provision "shell", path: "bootstrap.sh"
```

```ruby
# docker 操作
config.vm.provision "docker" do |d|
  # 下载镜像
  d.pull_images "nginx:1.11.9-alpine"

  # 运行容器
  d.pull_images "nginx:1.11.9-alpine" 
end
```

* 多机配置

可以使用循环为多台虚拟机设置不同的配置，`config.vm.define` 其后定义不同的角色。

```ruby
# 定义多台不同的虚拟机，启动的时候可以只启动一台：vagrant up web
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  # 定义一台 web 虚拟机
  config.vm.define "web" do |web|
    web.vm.box = "apache"
  end

  # 定义一台 db 虚拟机
  config.vm.define "db" do |db|
    db.vm.box = "mysql"
  end
end
```

```ruby
# 定义多台相同的虚拟机
(1..3).each do |i|
  node.vm.box = "centos/7"

  config.vm.define "centos-#{i}" do |node|
    node.vm.hostname = "centos-#{i}"

    ip = "172.17.8.#{i+100}"
    node.vm.network :private_network, ip: "${ip}"
  end
end
```


## 参考

* [Vagrant Documentation](https://www.vagrantup.com/docs/)
* [vagrant 学习笔记 - Vagrantfile](http://blog.csdn.net/54powerman/article/details/50676320)