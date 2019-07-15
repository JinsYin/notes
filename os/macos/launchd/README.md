# Launchd

Launchd 是 macOS 的服务管理框架，负责启动、停止和管理守护进程、应用程序、进程和脚本。

## 两大任务

* 引导系统
* 管理服务

## 属性列表（Property list，缩写：plist）

```sh
$ ls /System/Library/LaunchDaemons
```

## launchctl

## 示例

```sh
$ ps -ef | awk '$2==1'
----------------------
0     1     0   0 12 619  ??        52:20.06 /sbin/launchd
```

```sh
$ pstree -p 1
....
```

## 参考

* [launchd](https://en.wikipedia.org/wiki/Launchd)