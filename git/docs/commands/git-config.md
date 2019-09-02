# GIT-CONFIG

## 配置作用域

| 编号 | 作用域                              | 描述                     | 配置文件路径                             |
| ---- | ----------------------------------- | ------------------------ | ---------------------------------------- |
| ①    | `git config` / `git config --local` | 针对当前使用的仓库       | `./.git/config`                          |
| ②    | `git config --global`               | 针对当前用户的所有仓库   | `~/.gitconfig` 或 `~/.config/git/config` |
| ③    | `git config --system`               | 针对操作系统的每一个用户 | `/etc/gitconfig`                         |

优先级：① > ② > ③

## 查看配置

```sh
# 所有配置
$ git config --list

# 不同作用域的配置
$ git config --list [--local | --global | --system]

# 查看某个配置
$ git config user.name
$ git config alias.lg
```

## 最小配置 · 用户信息

配置用户信息：

```sh
$ git config --global user.name "jinsyin"
$ git config --global user.email "jinsyin@gmail.com"
```

配置的目的：

* 标记做出代码变更的用户是谁
* 评审人员 Code Review 并指出开发者的问题时，代码托管平台可以自动发送邮件通知开发者

## 关闭文件模式

当文件的模式发送改变（比如从 `644` 变成了 `777`）时，Git 默认会把这当做是一次变更，可以使用以下方式关闭：

```sh
$ git config --global core.fileMode false
```

## 配置代理

* HTTP

```sh
$ git config --global http.proxy http://127.0.0.1:1070

# 取消
$ git config --global --unset http.proxy
```

* SOCKS

```sh
# socks5h 代替 socks5
$ git config --global http.proxy socks5h://127.0.0.1:1080
```

```sh
# 使用环境变量
$ ALL_PROXY=socks5://127.0.0.1:1080 git clone https://github.com/x/y.git
```

## 文本编辑器

```sh
$ git config --global core.editor vim
```

## 清除配置

```sh
$ git config --unset [--local | --global | --system] user.name
```

## 参考

* [Git 设置和取消代理](https://gist.github.com/laispace/666dd7b27e9116faece6)