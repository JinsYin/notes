# Vagrantfile 配置

## 默认配置

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


## vagrant 版本要求

```ruby
Vagrant.require_version ">= 1.3.5"
```

OR

```ruby
Vagrant.require_version ">= 1.3.5", "< 1.4.0"
```


## 指定 box 版本

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_version "v1706.02"
end
```


## 配置主机名

```ruby
Vagrant.configure("2") do |config|
  config.vm.hostname = "centos01"
end
```


## 配置网络

Vagrant 支持三种网络配置：

* 端口映射（Forwarded port）

顾名思义，就是把宿主机的端口映射到虚拟机的某个端口上，访问宿主机端口时，请求会被转发到虚拟机上指定的端口，类似 Docker 的 bridge 网络。不足之处在于，如果映射的端口较多会比较麻烦，另外不支持在宿主机上使用小于 1024 的端口进行转发。

```ruby
config.vm.network :forwarded_port, guest: 80, host: 8080
```

* 私有网络（Private network）

只有宿主机可以访问虚拟机，如果多个虚拟机设定在同一个网段也可以互相访问，当然虚拟机是可以访问外部网络的。优点：安全，仅自己可以访问；缺点：不利于团队协作。

```ruby
# 静态 IP（会自动创建一个 172.28.128.1 的虚拟网卡）
config.vm.network :private_network, ip: "172.28.128.2"

# DHCP
config.vm.network :private_network, type: "dhcp"
```

* 公有网络（Public network）

与宿主机具有相同的网络配置，可以和局域网中的其他机器通信。优点：团队协作；缺点：需要联网。

```ruby
# DHCP
config.vm.network = "public_network"

# DHCP，并指定网卡
config.vm.network :public_network, bridge: "eth0"

# DHCP，并指定多个网卡
config.vm.network :public_network, bridge: [
  "en1",
  "eth0"
]

# 静态 IP
config.vm.network :public_network, ip: "192.168.1.100"

# 静态 IP，并指定网卡
config.vm.network :public_network, ip: "192.168.1.100", bridge: "eth0"
```

---

事例 1：

```ruby
Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.default "centos-#{i}" do |node|
      node.vm.hostname = "centos-#{i}"
      ip = "10.0.2.#{100+i}"
      node.vm.network :private_network, ip: "#{ip}"
      node.vm.provider :virtualbox do |vb|
        vb.name = "centos-#{i}"
        vb.cpus = 1
        vb.memory = "1024"
      end
    end
  end
end
```

---

事例 2：

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

## sdfsdfsdfsdfsdf

OR

```ruby
# 静态 IP
ip = "10.0.2.#{i+100}"
config.vm.network :private_network "#{ip}"
```

OR

```ruby
# 动态 IP
config.vm.network :private_network, type: "dhcp”
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