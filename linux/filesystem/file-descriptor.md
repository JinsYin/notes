# 文件描述符

文件描述符（File Descriptor，简称 `FD`）。

## 命令

```bash
# stdin 从 /dev/pts/19 读取数据，写入到了 C00003491.png
$ ls /proc/772894/fd
total 0
dr-x------ 2 yin yin  0 10月 22 21:06 ./
dr-xr-xr-x 9 yin yin  0 10月 22 21:06 ../
lrwx------ 1 yin yin 64 10月 22 21:09 0 -> /dev/pts/19
lrwx------ 1 yin yin 64 10月 22 21:09 1 -> /dev/pts/19
lrwx------ 1 yin yin 64 10月 22 21:09 2 -> /dev/pts/19
lr-x------ 1 yin yin 64 10月 22 21:09 3 -> /media/yin/Elements/1-ChartMap_v2_en/L12/R00001b92/C00003491.png
```