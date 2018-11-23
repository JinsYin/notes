# 内核模块（Kernel Module）

内核模块（Kernel Module）是可以按需加载或卸载的内核代码，不需要重启系统就可以扩充内核的功能。

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

* [Kernel modules](https://wiki.archlinux.org/index.php/Kernel_modules_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* [Linux 启动自动加载模块](https://www.jianshu.com/p/69e0430a7d20)