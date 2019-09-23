# e4defrag

联机针对 ext4 文件系统进行碎片整理。

## 安装

```sh
$ sudo apt-get install e2fsprogs
```

## 语法

```sh
$ e4defrag [ -c ] [ -v ] target ...
```

## 参数

| 参数   | 描述                                        |
| ------ | ------------------------------------------- |
| target | ext4 文件系统挂载的普通文件、目录或设备文件 |

## 示例

```sh
$ sudo e4defrag -v /dev/sdb1 # 分区 /dev/sdb1 创建了 ext4 文件系统
......
Success:			[ 1429450/1878288 ]
Failure:			[ 448838/1878288 ]
Total extents:			1534770->1461346
Fragmented percentage:		  1%->0%
```

```sh
$ sudo e4defrag /
```
