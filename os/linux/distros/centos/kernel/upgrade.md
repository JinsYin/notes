# CentOS 升级内核

## 当前环境

```sh
# 系统版本
$ cat /etc/redhat-release
CentOS Linux release 7.4.1708 (Core)

# 内核版本
$ uname -r
3.10.0-514.el7.x86_64
```

## 包管理器升级

如果官方镜像仓库中有你想升级的 kernel 版本，可以直接通过包管理器来升级。

* 升级 kernel

```sh
# 查看官方镜像仓库提供的新版本的 kernel
$ yum list kernel --showduplicates
kernel.x86_64    3.10.0-693.el7         base
kernel.x86_64    3.10.0-693.1.1.el7     updates
kernel.x86_64    3.10.0-693.2.1.el7     updates
kernel.x86_64    3.10.0-693.2.2.el7     updates
kernel.x86_64    3.10.0-693.5.2.el7     updates
kernel.x86_64    3.10.0-693.11.1.el7    updates

# 安装新版 kernel
$ yum install -y kernel-3.10.0-693.11.1.el7*

# 查看安装的 kernel 版本
$ yum list kernel --showduplicates
```

* 升级 kernel 相关的包

```sh
# 查询与 kernel 相关的包
$ rpm -qa | grep kernel

# 卸载所有与 kernel 不同版本的包
$ yum remove -y kernel-headers-3.10.0-693.5.1.el7
$ yum remove -y kernel-devel-3.10.0-693.5.1.el7

# 安装与 kernel 相同版本的包
$ yum install -y kernel-headers-3.10.0-693.11.1.el7*
$ yum install -y kernel-devel-3.10.0-693.11.1.el7*
```

## 手动升级

如果官方镜像仓库没有想要升级的 kernel 版本，只能通过 rpm 包来手动安装，下载地址：http://vault.centos.org/7.3.1611/updates/x86_64/Packages/ 。需要注意的是，必须是末尾带小数点的版本（因为下载不到），例如 `3.10.0-514.26.2`，但不能是 `3.10.0-514`。

* 升级 kernel

```sh
$ wget http://vault.centos.org/7.3.1611/updates/x86_64/Packages/kernel-3.10.0-514.26.2.el7.x86_64.rpm

# 安装指定版本的 kernel
$ yum install -y kernel-3.10.0-514.26.2.el7.x86_64.rpm

# 查看安装的 kernel 版本
$ yum list kernel --showduplicates
```

* 升级 kernel 相关的包

```sh
# 查询与 kernel 相关的包
$ rpm -qa | grep kernel

# 卸载所有与 kernel 不同版本的包
$ yum remove kernel-headers-3.10.0-693.11.1.el7
$ yum remove kernel-devel-3.10.0-693.11.1.el7

# 手动安装与 kernel 版本相同的包
$ wget http://vault.centos.org/7.3.1611/updates/x86_64/Packages/kernel-headers-3.10.0-514.26.2.el7.x86_64.rpm
$ wget http://vault.centos.org/7.3.1611/updates/x86_64/Packages/kernel-devel-3.10.0-514.26.2.el7.x86_64.rpm
$ yum install -y kernel-headers-3.10.0-514.26.2.el7.x86_64.rpm
$ yum install -y kernel-devel-3.10.0-514.26.2.el7.x86_64.rpm
```

### 在 GRUB 中设置默认的 kernel 版本

```sh
# 查看可用的 kernel 版本
$ sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
0 : CentOS Linux (3.10.0-514.26.2.el7.x86_64) 7 (Core)
1 : CentOS Linux (3.10.0-514.el7.x86_64) 7 (Core)
2 : CentOS Linux (0-rescue-4b867cfcdd7c49bb8f3668ff906aac67) 7 (Core)

# 根据上面的编号在 GRUB 中设置默认的 kernel
$ vi /etc/default/grub
GRUB_DEFAULT=0

# 同上，或者
$ grub2-set-default 0

# 重新创建 kernel 配置
$ grub2-mkconfig -o /boot/grub2/grub.cfg
```

### 设置默认 kernel 后重启

```sh
# 重启
$ reboot

# 检查 kernel 版本
$ uname -r
$ 3.10.0-514.26.2.el7.x86_64
```

### 移除旧版本的 kernel

```sh
$ yum install yum-utils

# 方法一
$ package-cleanup --oldkernels

# 方法二
$ yum remove kernel-3.10.0-514.el7.x86_64
```

## 参考

* [How to Upgrade Kernel on CentOS 7](https://www.howtoforge.com/tutorial/how-to-upgrade-kernel-in-centos-7-server/)
* [Manually Upgrading the Kernel](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/ch-kernel.html)