# Aria2

aria2 是一个轻量级的 **多源**、**多协议** 命令行下载程序，支持 `HTTP(S)`、`FTP`、`SFTP`、`BitTorrent` 和 `Metalink` 协议，并且可以通过内置的 `JSON-RPC` 和 `XML-RPC` 接口控制 aria2 进程。

## 安装

```sh
# Debian/Ubuntu
$ sudo apt-get install -y aria2

# RHEL/CentOS
$ sudo yum install -y aria2

# macOS
$ brew install aria2
```

## 命令行下载

```sh
# HTTP
$ aria2c http://example.org/mylinux.iso

# 两个源、两种协议
$ aria2c http://a/f.iso ftp://b/f.iso

# 两个连接
$ aria2c -x2 http://a/f.iso

# BitTorrent
$ aria2c http://example.org/mylinux.torrent

# BitTorrent Magnet URI
$ aria2c 'magnet:?xt=urn:btih:248D0A1CD08284299DE78D5C1ED359BB46717D8C'

# Metalink
$ aria2c http://example.org/mylinux.metalink

# URI 文本
$ aria2c -i uris.txt
```

## 参考

* [github.com/aria2/aria2](https://github.com/aria2/aria2)
* [aria2.github.io](https://aria2.github.io)
* [如何加快下载百度网盘的文件](http://www.ixirong.com/2016/12/18/how-to-speed-up-baidu-disk-download/)