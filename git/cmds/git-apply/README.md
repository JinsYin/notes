# GIT-APPLY

对文件和/或暂存区应用一个补丁。

## 用法

```sh
git apply [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
                 [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
                 [--allow-binary-replacement | --binary] [--reject] [-z]
                 [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
                 [--ignore-space-change | --ignore-whitespace]
                 [--whitespace=(nowarn|warn|fix|error|error-all)]
                 [--exclude=<path>] [--include=<path>] [--directory=<root>]
                 [--verbose] [--unsafe-paths] [<patch>...]
```

## 选项

| 选项              | 描述         |
| ----------------- | ------------ |
| `-R`、`--reverse` | 反向应用补丁 |
