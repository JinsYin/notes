# Git 大文件管理

GitHub 默认不支持上传超过 50MB 的文档, 所以需要使用 Git Large File Storage (Git LFS), 它支持存储将大文件存储在远程服务器.

> Git LFS 要求 Git 版本大于等于 v1.8.5

## 安装
Git 默认是没有 git lfs 命令支持的,需要安装 Git LFS.

ubuntu 安装
```bash
$ sudo -i
$ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash # 添加 repo
$ apt-get update
$ apt-cache policy git-lfs
$ apt-get install git-lfs # 最新版
```
> https://packagecloud.io/github/git-lfs/install

安装好之后,需要手动初始化
```bash
$ git lfs install
```

通过 Git LFS 添加所有 zip 文件,匹配的文件将被放在 `.gitattributes` 中
```bash
$ git lfs track "*.zip"
```

提交到本地仓库
```bash
$ git add .gitattributes
$ git add my.zip
$ git commit -m "add zip"
```

查看,确认
```bash
$ git lfs ls-files
```

提交到远程仓库
```bash
$ git push origin master
```

## 参考文章

- https://git-lfs.github.com/
- https://github.com/git-lfs/git-lfs