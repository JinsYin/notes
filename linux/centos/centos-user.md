# 创建具有 root 权限的用户

## 登录 root 用户
```bash
$ sudo -i
```

## 创建 developer 用户
```bash
$ useradd -d /home/developer -m developer
```

## 修改密码
```bash
$ passwd developer
```

## 设置 root 一样的权限
```bash
$ echo "developer ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/developer
$ sudo chmod 0440 /etc/sudoers.d/developer
```

## 登录
```bash
$ su - developer
```

## 注意
与 root 用户不同的是，root 用户每次不用添加 sudo 命令，而新增的 developer 用户需要使用 sudo
