# CPU 使用率（CPU Utilization）

## 定义

## 含义

```sh
# 查看 -u 参数
$ man mpstat
```

| Name    | 描述 |
| ------- | ---- |
| idle    | 空闲 |
| iowait  |      |
| irq     |      |
| nice    |      |
| softirq |      |
| steal   |      |
| system  |      |
| usr     |      |

## 实验

* 安装

```sh
# CentOS
$ yum install -y perf

# Ubuntu
$ apt-get install -y linux-tools-common
```
