# 编译 Mesos

## 环境

```sh
$ uname -r
4.2.0-27-generic
```

```sh
$ python --version
Python 2.7.6
```

```sh
$ java -version
java version "1.8.0_121"
Java(TM) SE Runtime Environment (build 1.8.0_121-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.121-b13, mixed mode)
```

```sh
% sudo update-alternatives --config java
```

## 下载

## 编译

```sh
# 进入 mesos 目录
$ mkdir build && cd build
$ ../configure
$ make
$ make check
$ make install
```

编译好之后除了在 `build` 目录下生成 mesos 相关文件外，还有如下文件：

```sh
/usr/local/etc/mesos # mesos相关配置文件
/usr/local/bin/mesos # mesos相关执行文件
/usr/local/include/mesos
/usr/local/lib/python2.7/site-packages/mesos
/usr/local/lib/mesos # mesos相关依赖包
/usr/local/libexec/mesos
/usr/local/share/mesos # mesos webui代码
/run/mesos
/root/.python-eggs/mesos.scheduler-1.0.0-py2.7-linux-x86_64.egg-tmp/mesos
/root/.python-eggs/mesos.executor-1.0.0-py2.7-linux-x86_64.egg-tmp/mesos
/sys/fs/cgroup/net_cls/mesos
/sys/fs/cgroup/freezer/mesos
/sys/fs/cgroup/memory/mesos
/sys/fs/cgroup/cpuacct/mesos
/sys/fs/cgroup/cpu/mesos
/var/empty/mesos
/tmp/mesos
```

## 校验

确保一下命令可用

* 命令一

```sh
% mesos
% mesos-ps
```

如果提示 "from mesos import http" python 没有的 mesos 包。执行：

```sh
% cp -r /usr/local/lib/python2.7/site-packages/mesos* /usr/local/lib/python2.7/dist-packages/
```

* 命令二

```sh
% mesos-resolve
```

如果提示没有 libmesos.so 文件，执行

```sh
% sudo echo /usr/lib /etc/ld.so.conf
% sudo echo /usr/local/lib /etc/ld.so.conf
% sudo ldconfig -v
```

```sh
% mesos-master
% mesos-slave
% mesos-agent
```
