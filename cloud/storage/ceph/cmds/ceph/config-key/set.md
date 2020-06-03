# ceph config-key set / ceph config-key put

## 用法

```sh
ceph config-key set <key> {<val>}
config-key put <key> {<val>}
```

## 示例

```sh
$ ceph config-key set "mykey" "myvalue"

$ ceph config-key get "mykey"
obtained 'mykey'
myvalue
```
