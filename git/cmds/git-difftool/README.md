# GIT-DIFFTOOL

启动外部工具展示两棵树之间的差异。

## 设置 DIFF 工具

```sh
$ git config --global diff.tool vimdiff
```

## 示例

```sh
$ git diff -y --tool=vimdiff x.md
```
