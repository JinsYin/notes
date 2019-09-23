# blockdev

从命令行调用块设备 ioctl

## 语法

```sh
blockdev [-q] [-v] command [command...]  device [device...]
blockdev --report [device...]
```

## 选项

| 选项     | 描述                                                          |
| -------- | ------------------------------------------------------------- |
| --getbsz | 打印块大小，即逻辑扇区大小（Logical sector size）；单位：字节 |
| --getss  | 打印物理扇区大小（Physical sector size）；单位：字节          |
