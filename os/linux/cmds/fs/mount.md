# ls

## 语法

```sh
mount [-lhV]

mount -a [-fFnrsvw] [-t vfstype] [-O optlist]

mount [-fnrsvw] [-o option[,option]...]  device|dir

mount [-fnrsvw] [-t vfstype] [-o options] device dir
```

## 选项

| 选项 | 描述     |
| ---- | -------- |
| `-o` | 附加选项 |

## 示例

| 示例                         | 描述                                                                                                                                                             |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `mount --bind olddir newdir` | 绑定挂载；将某个目录额外挂载到另一个目录，特点是两个目录的 inode 编号相同且文件类型都是 `目录`，类似于对目录进行硬链接（Linux 不支持对目录进行硬链接）但有所不同 |

## mount --bind

`mount --bind` 不同于硬链接：

1. `mount --bind` 绑定的两个目录的 inode 并不相同，只是目标目录的 inode block 被隐藏，inode 被重定向到源目录的 inode（目标目录的 inode 和 block 实际没有发生变化）
2. 两个目录的对应关系存在于内存中，机器重启或 umount 卸载将使目标目录恢复原样

## 参考

* [mount --bind 和硬链接的区别](https://blog.csdn.net/shengxia1999/article/details/52060354)
