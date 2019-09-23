# mknod

创建块设备文件或字符设备文件。

## 帮助

```sh
$ man mknod
```

## 语法

```sh
$ mknod [OPTION]... NAME TYPE [MAJOR MINOR]
```

## 选项

## 参数

| 参数  | 描述                                   |
| ----- | -------------------------------------- |
| NAME  | 设备名称                               |
| TYPE  | 设备类型（`b`：块设备，`c`：字符设备） |
| MAJOR | 主设备号                               |
| MINOR | 副设备号                               |

## 示例

```sh
$ sudo mknod /tmp/swap b 1 100
```

## 参考

* [mknod 用法以及主次设备号](https://www.cnblogs.com/hnrainll/archive/2011/06/10/2077583.html)
