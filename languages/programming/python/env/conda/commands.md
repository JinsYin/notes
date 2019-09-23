# Conda 常用命令

```sh
# 查看安装了哪些软件包及其版本
$ conda list

# 查看某个虚拟环境已安装的软件包
$ conda list -n python2.7

# 查看已安装的软件包的版本信息，或者检查软件包是否被安装
$ conda list pip
Name    Version    Build    Channel
pip     9.0.1      py36h6c6f9ce_4

# 查询所有可安装的软件包，以及可安装的版本
$ conda search

# 查询某个软件包可用的版本
$ conda search python
$ conda search "^python$"

# 安装最新版本的软件包
$ conda install numpydoc

# 安装指定版本的软件包
$ conda install numpydoc=0.6.0

# 更新某个软件包
$ conda update python

# 更新所有软件包
$ conda update

# 删除软件包
$ conda remove <package>
```

## 注意事项

切勿使用 pip 升级或卸载 conda 安装的软件包；pip 的升级和卸载操作仅限于 pip install 命令安装的软件包。
