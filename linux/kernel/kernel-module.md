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


## 加载卸载

```bash
# 加载内核模块
$ modprobe ip_vs

# 卸载内核模块
$ modprobe -r ip_vs
$ rmmod ip_vs
```


## 参考

* [Kernel modules](https://wiki.archlinux.org/index.php/Kernel_modules_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))