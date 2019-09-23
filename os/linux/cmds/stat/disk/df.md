# df

报告文件系统的磁盘空间使用情况。

## 语法

```sh
$ df [OPTION]... [FILE]...
```

## 示例

```sh
#
$ df -h

# 增加类型
$ df -hT

#
$ df -ahT

$ df -h /dev/sdb1
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb1       110G  103G  1.6G  99% /
```
