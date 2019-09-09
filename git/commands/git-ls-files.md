# GitLsFiles

显示暂存区和工作区中文件的信息

## 用法

```sh
git ls-files [-z] [-t] [-v] [-f]
                    (--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
                    (-[c|d|o|i|s|u|k|m])*
                    [--eol]
                    [-x <pattern>|--exclude=<pattern>]
                    [-X <file>|--exclude-from=<file>]
                    [--exclude-per-directory=<file>]
                    [--exclude-standard]
                    [--error-unmatch] [--with-tree=<tree-ish>]
                    [--full-name] [--recurse-submodules]
                    [--abbrev] [--] [<file>...]
```

## 选项

| 选项               | 描述                   |
| ------------------ | ---------------------- |
| `-c`、`--cached`   | 显示暂存的文件（默认） |
| `-d`、`--deleted`  | 显示删除的文件         |
| `-m`、`--modified` | 显示修改的文件         |
| `-o`、`--others`   | 显示未追踪的文件       |
| `-s`、`--stage`    |                        |
| `--unmerged`       |                        |