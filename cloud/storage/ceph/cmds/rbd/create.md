# rbd create

创建块设备镜像（Block Device Image）。

## 用法

```sh
rbd create --size {MB} {pool-name}/{image-name} # 默认的 {pool-name} 为 rbd
```

## 示例

```sh
# 要求先创建 rbdpool 存储池
$ rbd create --size 2048 rbdpool/nbd # 2GB

# 查询
$ rbd ls -p rbdpool
nbd
```
