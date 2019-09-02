# Ansible 认证

Ansible 的通信默认基于 SSH，因此在使用 ansible 之前需要先对目标主机进行认证。Ansible 支持两种认证方式：

* 密码认证
* 公私钥认证

## 公私钥认证（同 SSH）

```sh
# 本机生成公私钥
$ ssh-keygen -t rsa -N ''

# 添加公钥到目标主机（的 authorized_keys），实现无密码登录
$ ssh-copy-id root@192.168.1.100 # 需要输入 root 用户的密码
```

## 密码认证（明文不安全）
