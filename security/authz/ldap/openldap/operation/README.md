# OpenLDAP 操作

## 安装工具包

操作命令均来自 `ldap-utils` 软件包，其中，以 `ldap` 开头的命令为客户端工具，以 `slap` 开头的命令以服务器端工具。

```bash
# Ubuntu
$ sudo apt-get install -y ldap-utils
```

## 命令行工具

* 客户端工具

| 命令       | 描述 |
| ---------- | ---- |
| ldapsearch | 查询 |
| ldapupdate | 更新 |

* 服务器端工具

| 命令      | 描述 |
| --------- | ---- |
| slapcat   | ～   |
| slaptest  | ～   |
| slapindex | ～   |