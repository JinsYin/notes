# Flink 快速入门

## 流处理

```sh
# 监听一个 Socket 端口
$ nc -l -k 12345
```

```sh
$ ./bin/flink run examples/streaming/SocketWindowWordCount.jar --port 12345
```
