# Shell

_Shell_ 意为 `壳`（Kernel 意为 `核`），是一种特殊用途的程序，用于读取用户输入的命令以执行相应的程序，所以有时也称为 _命令解释器_，同时也是编程语言。

## 分类

Unix/Unix-like 系统中主要有三类 Shell （各自还有子分类）：

| 分类                | 子分类                                                                            | 命令提示符 |
| ------------------- | --------------------------------------------------------------------------------- | ---------- |
| Bourne shell (`sh`) | * Korn shell (`ksh`) <br> * Bourne Again shell (`bash`) <br> * POSIX shell (`sh`) | `$`        |
| C shell (`csh`)     | * TENEX/TOPS C shell (`tcsh`) - BSD                                               | `%`        |
| Z shell (`zsh`)     | ~                                                                                 | `%`        |

Bourne shell 是第一个出现在 Unix 系统中的 shell，所以被称为标准的 shell 。

## 配置文件

* `~/.profile`
* `~/.bash_profile`
* `~/.bashrc`
* `~/.zshrc`

| shell  | 配置文件优先级                            |
| ------ | ----------------------------------------- |
| `sh`   | * `~/.profile`                            |
| `bash` | 1. `~/.bash_profile` <br> 2. `~/.profile` |

## Login Shell

_Login shell_ 是指用户刚登录系统时，由系统创建、用来运行 shell 命令（即执行相应程序）的进程。对 Unix/Unix-like 系统而言，shell 仅仅是一个用户进程。

```sh
# 查看系统可用的 Login Shell（macOS）
$ cat /etc/shells
/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```

## 执行方式

1. 启动子进程 sub-shell 执行命令或脚本；如：在脚本开头指定 `#!/bin/sh` 以及命令行运行的各种命令（包括 `exec` 等命令）
2. 在当前 shell 进程中执行脚本；如：`source x.sh`
3. 执行 `exec` 系统调用以新进程代替原进程，但进程 PID 保持不变，如：在脚本中指定 `exec $@`

## 工作环境

Login shell：先读取 `/etc/profile` 文件，然后读取 `~/.bash_profile` 文件
non-login shell：读取 `~/.bashrc`

## 参考

* [Guide to Unix/Explanations/Choice of Shell](https://en.wikibooks.org/wiki/Guide_to_Unix/Explanations/Choice_of_Shell)