# GIT-LFS

Git Larget File Storage （LFS）

GitHub 默认不能上传超过 `50MB` 的文件, 所以需要使用 Git LFS, 它支持存储将大文件存储在远程服务器.

> 前提：Git 版本大于等于 v1.8.5

## 安装

Git 默认是没有 `git lfs` 命令支持的，需要安装 Git LFS.

* Debian/Ubuntu

```sh
# sudo
$ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash # 添加 repo
$ apt-get update
$ apt-cache policy git-lfs
$ apt-get install git-lfs # 最新版
```

> https://packagecloud.io/github/git-lfs/install

安装好之后,需要手动初始化

```sh
$ git lfs install
```

通过 Git LFS 添加所有 zip 文件,匹配的文件将被放在 `.gitattributes` 中

```sh
$ git lfs track "*.zip"
```

提交到本地仓库

```sh
$ git add .gitattributes
$ git add my.zip
$ git commit -m "add zip"
```

查看,确认
```sh
$ git lfs ls-files
```

提交到远程仓库
```sh
$ git push origin master
```

## 参考文章

- https://git-lfs.github.com/
- https://github.com/git-lfs/git-lfs
