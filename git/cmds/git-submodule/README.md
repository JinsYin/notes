# GIT-SUBMODULE

## 用法

```sh
git submodule [--quiet] [--cached]
git submodule [--quiet] add [<options>] [--] <repository> [<path>]
git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
git submodule [--quiet] init [--] [<path>...]
git submodule [--quiet] deinit [-f|--force] (--all|[--] <path>...)
git submodule [--quiet] update [<options>] [--] [<path>...]
git submodule [--quiet] set-branch [<options>] [--] <path>
git submodule [--quiet] summary [<options>] [--] [<path>...]
git submodule [--quiet] foreach [--recursive] <command>
git submodule [--quiet] sync [--recursive] [--] [<path>...]
git submodule [--quiet] absorbgitdirs [--] [<path>...]
```

## 文件目录

* `.gitmodules`
* `.git/config`
* `.git/modules/`

## .gitmodules

添加子模块后，会在项目目录下生成一个 `.gitmodules` 文件（`.git/config` 文件也会被修改），形如：

```ini
[submodule "themes/beautifulhugo"]
    path = themes/beautifulhugo
    url = https://github.com/halogenica/beautifulhugo.git
```

## 示例

| 示例                                      | 描述             |
| ----------------------------------------- | ---------------- |
| `git submodule`                           | 列出所有的子模块 |
| `git submodule update`                    | 更新所有的子模块 |
| `git submodule update --init --recursive` |                  |
