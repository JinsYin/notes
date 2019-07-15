# 用户（组）/密码管理

## 用户切换

```bash
# 登录到 root 用户
$ sudo -i

# 登录到特定用户
$ su - <username>
```

## 用户管理

* 新增用户

```bash
# -m 创建用户 Home 目录（/home/<username>）
# -s 设置 Login shell
$ useradd -m <username> -s /bin/bash # 需要 root 权限
```

* 删除用户

```bash
# 需要 root 权限
$ userdel <username>

# 选择性删除用户 Home 目录
$ rm -rf /home/<username>
```

* 修改用户名

```bash
$ usermod -l <NewName> <OldName>
```

## 用户组管理

```bash
# 查询所有组
$ sudo groups
```

## 密码管理

* 设置/修改密码

```bash
# 修改当前用户的密码
$ passwd

# 修改特定用户的密码（需要 root 权限）
$ passwd <username>
```