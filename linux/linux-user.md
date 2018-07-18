# Linux 用户管理

## 登录 root 用户

```bash
$ sudo -i
```

## 修改密码

```bash
$ passwd # 修改当前用户的密码
$ passwd other_user # 修改指定用户的密码
```

## 添加新用户

```bash
$ useradd -m new_user -s /bing/bash # -m: 创建目录 /home/new_user，-s: shell
$ passwd new_user # 修改密码
```

## 删除用户

```bash
$ userdel new_user
$ rm -r /home/an_user
```

## 修改用户名

```bash
$ usermod -l new_user old_user
```

## 切换用户

```bash
$ su - other_user
```

## 组

```bash
$ sudo groups # 查询所有组
```
