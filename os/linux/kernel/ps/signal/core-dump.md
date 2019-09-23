# 核心转储（core dump）

在 Unix 系统中，常把 _主存（main memory）_ 称为 _核心（core）_，因为在使用半导体作为内存材料之前，便是使用核心（core）。而 _核心镜像（core image）_ 就是指进程运行时的内存内容。当进程发送错误或收到某个信号而终止运行时，系统会将核心镜像写入一个文件，以作为后期调试时使用，该文件称为 _核心转储（core dump）_，也叫 _核心文件（core file）_ 或 _核心转储文件（core dump file）_。

```sh
$ man 5 core
```

## 背景

## 用途

* 调试

## 示例

```sh
# 默认关闭了核心文件产生
$ ulimit -a | grep 'core file'
core file size          (blocks, -c) 0
```

```sh
$ ulimit -c unlimited

$ sleep 30
^\Quit (core dumped)  # 键入 Ctrl+\

$ ls -l core
-rw------- 1 yin yin 393216  7月 30 13:50 core

# GDB 调试核心转储文件
$ gdb coredump core
```

## 参考

* [核心转储](https://zh.wikipedia.org/wiki/核心转储)
