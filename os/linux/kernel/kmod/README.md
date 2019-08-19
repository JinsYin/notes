# Linux 内核模块（Linux Kernel Module）

_内核模块（Kernel Module）_ 是可以按需加载或卸载的内核代码，运行在内核空间而不是用户空间，可以在运行时动态地向内核添加或移除功能，而无需重启系统。诸如文件系统、设备驱动程序、网络协议等内核子系统几乎都可以模块化。

模块必须提供某些代码段（init.text 和 exit.text）在模块初始化或终止时执行，以便向内核注册或卸载模块。

## 特点

* 热插拔 - 某些总线（如 USB 和 FirewWire）允许在系统运行时连接设备，当系统检测到新设备时，通过加载对应的模块，可以将必要的驱动程序添加到内核中

## 获取信息

```bash
# 查看加载的内核模块
$ lsmod

# 查看内核模块信息
$ modinfo ip_vs

# 查看模块的依赖关系
$ modprobe -D ip_vs
```

## 手动加载卸载

```bash
# 加载内核模块
$ modprobe ip_vs

# 卸载内核模块
$ rmmod ip_vs # modprobe -r ip_vs
```

## 开机自动加载

加载的内核模块无法做到开机自动加载，如需自动加载，可以编辑相应的文件并添加模块名。

### CentOS

```bash
$ cd /etc/sysconfig/modules/

# 名称根据模块名来命名
$ vi bonding.modules
#！/bin/sh
/sbin/modinfo -F filename bonding > /dev/null 2>&1
if [ $? -eq 0 ]; then
    /sbin/modprobe bonding
fi

# 改变权限，之后重启
$ chmod +x bonding.modules
```

其他情况：

```bash
$ /etc/modules-load.d/kvm.conf
kvm
kvm_intel
```

### Ubuntu

```bash
# 一行一个，参数可以在模块名之后指定；最后重启
$ vi /etc/modules
kvm
bonding
```

## 常用内核模块

* kvm
* ceph
* bonding

## 白名单

## 黑名单

## 参考

* [Loadable kernel module](https://en.wikipedia.org/wiki/Loadable_kernel_module)
* [Kernel modules](https://wiki.archlinux.org/index.php/Kernel_modules_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* [Linux 启动自动加载模块](https://www.jianshu.com/p/69e0430a7d20)