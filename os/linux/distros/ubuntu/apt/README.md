# APT

## AptGet

```bash
# 安装软件包
$ apt-get install <package>

# 升级某个已安装的软件包
$ apt-get install --only-upgrade <package>

# 升级所有已安装的软件包（谨慎使用）
$ apt-get upgrade

# 卸载软件包，但保留相关配置文件
$ apt-get remove <package>

# 卸载软件包，并删除相关配置文件
$ apt-get purge <package>
```

## AptCache

```bash
# 查看软件包的版本
$ apt-cache policy dnsutils
$ apt-cache madison dnsutils

# 查看软件包依赖
$ apt-cache showpkg dnsutils
```

* [AptGet/Howto](https://help.ubuntu.com/community/AptGet/Howto)

## 切记！

对于 Ubuntu 桌面版最好不要执行以下操作：

```bash
# 这会升级 kernel 等所有软件包，可能导致软件不兼容，最终导致系统奔溃
$ apt-get upgrade

# 这可能会卸载某些必要的软件，导致系统崩溃
$ apt-get autoremove
```

## 编译安装、卸载

具体的方法名取决于 Makefile 文件中的定义。下面以安装、卸载 Python3.5 源码为例：

* 编译安装

```bash
$ ./configure
$ make
$ make install
```

* 卸载

```bash
# 删除所有中间或输出文件
$ make clean

# 如果可行就运行
$ make uninstall

# 最后手动卸载
$ make -n install

# 删除安装的包或软链接
$ rm /usr/local/bin/python3*
```

或

```bash
$ make clean && make distclean

# 删除安装的包或软链接
$ rm /usr/local/bin/python3*
```