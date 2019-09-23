# mkfs.xfs

## 示例

```sh
# -s 指定的是 “逻辑扇区” 的大小
$ mkfs.xfs -f -s size=4096 /dev/sda1

# -b 指定的是 “文件系统块” 的大小
$ mkfs.ext4 -F -b 4096 /dev/sda1
```
