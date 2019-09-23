# Loop 设备

在类 Unix 系统中，**/dev/loop**（或称为 **vnd**、**lofi**） 是一种伪设备（pseudo-devices），它能使我们可以像访问块设备一样访问一个文件。

使用前，Loop 设备必须和当前文件系统上的文件相关联。

## 循环挂载（Loop mount）

在目录上挂载包含文件系统的文件（如 `example.img`）需要两步：

```sh
# 第一步：用一个 Loop 设备节点连接文件
$ losetup /dev/loop0 example.img

# 第二步：在目录上挂载该 Loop 设备
$ mount /dev/loop0 /home/you/dir
```

```sh
# 二合一
$ mount -o loop example.img /home/you/dir
```

* 卸载

```sh
$ umount /home/you/dir
# 或
$ umount /dev/loop<N>
```
