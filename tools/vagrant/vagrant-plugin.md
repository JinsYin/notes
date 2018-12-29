# Vagrant 插件

## 插件命令

* 查看

```bash
$ vagrant plugin list
```

* 安装

```bash
$ vagrant plugin install <plugin-name>
```

* 卸载

```bash
$ vagrant plugin uninstall <plugin-name>
```


## 常用插件

* [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager)

vagrant-hostmanager 插件可以将虚拟机的 ip 和 hostname 自动添加到宿主机和虚拟机的 `/etc/hosts` 中，使宿主机与虚拟机之间、虚拟机与虚拟机之间可以通过 hostname 来访问（ping、ssh）。

```bash
$ # 安装插件
$ vagrant plugin install vagrant-hostmanager
```

```bash
$ # 常用配置
config.hostmanager.enabled = true      # 启用 hostmanager 插件
config.hostmanager.manage_guest = true # 更新虚拟机的 hosts 文件
config.hostmanager.manage_host = true  # 更新宿主机的 hosts 文件
```

```bash
$ # 更新 hosts 文件（在 Vagrantfile 目录下运行）
$ vagrant hostmanager
```

* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)

某些 virtualbox 类型的 box 没法设置共享目录，这是因为 box 里面没有安装 VirtualBox Guest Additions 。vagrant-vbguest 插件可以帮助我们在虚拟机上安装或者更新 VirtualBox Guest Additions 。

```bash
$ # 安装插件
$ vagrant plugin install vagrant-vbguest
$
$ # 查看运行中的虚拟机是否安装 VirtualBox Guest Additions （Vagrantfile 目录下）
$ vagrant vbguest --status
$
$ # 运行中的虚拟机中安装 VirtualBox Guest Additions （Vagrantfile 目录下）
$ vagrant vbguest --do install node1
```

```bash
$ # 常用配置
config.vbguest.auto_update = false # 关闭自动更新，因为每次重启虚拟机都会检查 GuestAdditions 的版本并自动更新
config.vbguest.no_remote = true    # 不从远程下载 GuestAdditions ios 文件
config.vbguest.iso_path = <path>   # GuestAdditions iso 文件路径
```

> 默认情况，所有的 virtualbox 类型的 box 都会自动下载更新 GuestAdditions，如果没用到共享目录可以移除这个插件，因为可以会报下载错误。

* [vagrant-bindfs](https://github.com/gael-ian/vagrant-bindfs)

vagrant-bindfs 插件用于设置 nfs 类型的共享目录。

```bash
$ # 安装
$ vagrant plugin install vagrant-bindfs
```

* [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)

vagrant-libvirt 通过 libvirt 连接 kvm 等 provider。

```bash
$ # 安装插件
$ vagrant plugin install vagrant-libvirt
```

* vagrant-cachier

```bash
$ # 安装插件
$ vagrant plugin install vagrant-cachier
```

