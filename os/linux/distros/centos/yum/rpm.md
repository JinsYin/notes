# RPM

## 常用命令

```sh
# 查询相关的包
$ rpm -qa ansible

# 获取包的相关文件及目录
$ rpm -ql ansible
```

## 安装

```sh
# 本地安装
$ yum localinstall -y /tmp/docker-1.12.6.rpm
```