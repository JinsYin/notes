# GIT-GREP

输出匹配某个模式的文本行

## 用法

```sh
git grep [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
                  [-v | --invert-match] [-h|-H] [--full-name]
                  [-E | --extended-regexp] [-G | --basic-regexp]
                  [-P | --perl-regexp]
                  [-F | --fixed-strings] [-n | --line-number] [--column]
                  [-l | --files-with-matches] [-L | --files-without-match]
                  [(-O | --open-files-in-pager) [<pager>]]
                  [-z | --null]
                  [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
                  [--max-depth <depth>] [--[no-]recursive]
                  [--color[=<when>] | --no-color]
                  [--break] [--heading] [-p | --show-function]
                  [-A <post-context>] [-B <pre-context>] [-C <context>]
                  [-W | --function-context]
                  [--threads <num>]
                  [-f <file>] [-e] <pattern>
                  [--and|--or|--not|(|)|-e <pattern>...]
                  [--recurse-submodules] [--parent-basename <basename>]
                  [-W | --function-context]
                  [--threads <num>]
                  [-f <file>] [-e] <pattern>
                  [--and|--or|--not|(|)|-e <pattern>...]
                  [--recurse-submodules] [--parent-basename <basename>]
                  [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
                  [--] [<pathspec>...]
```

## 用例

| 用例                         | 描述                                  |
| ---------------------------- | ------------------------------------- |
| `git grep "xxx"`             | 在工作区的 tracked 文件中查找指定模式 |
| `git grep -Ii --line-number` | 忽略大小写、显示匹配行的行号          |
| `git grep --cached "xxx"`    | 在暂存区中搜索指定模式                |
