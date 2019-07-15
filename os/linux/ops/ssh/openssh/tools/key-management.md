# 密钥管理工具

* ssh-add
* ssh-keysign
* ssh-keyscan
* ssh-keygen

## 基本用法

```bash
# 生成认证密码（公私钥）
$ ssh-keygen -t rsa -P ''

# 复制（追加）本机公钥到目标节点的 authorized_keys，实现免密钥访问
$ ssh-copy-id root@192.168.1.100 # 需要输入 root 用户的密码

# 免密钥访问本机
$ ssh-copy-id root@localhost
```