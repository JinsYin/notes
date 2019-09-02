# 文件扩展属性（Extended file attributes）

文件扩展属性（缩写 XATTR）是以 name/value 对形式将任意元数据与文件 inode 关联起来的技术。

EA 可用于实现 _访问控制列表_（ACL） 和 _文件能力_。

## 命名空间

## 安装

`attr`、`getfattr`、`setattr` 命令来自 `attr` 包。

```sh
# CentOS
$ yum install -y attr
```

## 内核代码

```c
/*
 * <fs/xattr.c>
 *
 *
 */
```

## 参考

* [Extended file attributes](https://en.wikipedia.org/wiki/Extended_file_attributes)