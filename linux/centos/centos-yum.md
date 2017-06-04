# CentOS yum 命令

## yum update 与 yum upgrade
```bash
$ yum update  # 更新包，且更新内核（谨慎使用）
$ yum upgrade # 更新包，不更新内核
```

## 查询已安装的包
```bash
$ rpm -qa | grep docker
```

## 查看软件包信息
```bash
$ yum info docker
```

## 列出所有软件版本
```bash
$ yum list docker --showduplicate
```
