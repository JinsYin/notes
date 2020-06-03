# ceph config-key dump / ceph config-key ls

打印所有配置的键值对。

## 用法

```sh
# 打印所有配置的键值对
$ ceph config-key dump {<key>}

# 打印所有配置的键
$ ceph config-key ls
```

## 示例

```sh
$ ceph config-key dump
{
    "config-history/1/": "<<< binary blob of length 12 >>>",
    "initial_mon_keyring": "AQCh5w5eAAAAABAAvKiYkVI1YumUv8pdM86teQ=="
}
```

```sh
$ ceph config-key dump "initial_mon_keyring"
{
    "initial_mon_keyring": "AQCh5w5eAAAAABAAvKiYkVI1YumUv8pdM86teQ=="
}
```

```sh
$ ceph config-key ls
[
    "config-history/1/",
    "initial_mon_keyring"
]
```
