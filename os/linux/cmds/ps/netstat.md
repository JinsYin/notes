# netstat

## 示例

```sh
# 查看进程监听的 TCP 端口
$ netstat -tpln # ss -tpla # lsof -iTCP -sTCP:LISTEN -P -n

# 查看进程监听的 UDP 端口
$ netstat -upln # ss -upla
```
