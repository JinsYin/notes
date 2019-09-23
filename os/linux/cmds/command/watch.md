# watch

周期性地运行一个程序，并全屏显示执行结果。

语法：

```sh
watch [options] command
```

选项：

```sh
-n # 间隔时间；默认每 2 秒运行一次
-d # 高亮显示变化
-t # 关闭 watch 命令在顶部输出的时间间隔和当前时间
```

## 示例

```sh
$ watch -d -t uptime
14:31:37 up 43 days,  5:22, 18 users,  load average: 1.18, 1.57, 1.48
```
