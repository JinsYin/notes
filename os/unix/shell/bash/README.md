# bash

## 快捷键

| 快捷键          | 描述                                                                                                                                                          |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Tab`           | 自动补全命令                                                                                                                                                  |
| `ctrl-r`        | 搜索命令行历史 <br> * 重复按下 `ctrl-r` 将 **向后查找** 匹配项 <br> * 按下 `Enter` 键将执行当前匹配的命令 <br> * 按下右键会将匹配项放入当前命令行中，以作修改 |
| `ctrl-u`        | 删除当前光标到行首之间的内容                                                                                                                                  |
| `ctrl-k`        | 删除当前光标到行尾之间的内容                                                                                                                                  |
| `ctrl-a`        | 将光标移至行首                                                                                                                                                |
| `ctrl-e`        | 将光标移至行尾                                                                                                                                                |
| `ctrl-l`        | 清屏但保留当前命令行的内容                                                                                                                                    |
| `ctrl-w`        | 删除键入的最后一个单词                                                                                                                                        |
| `ctrl-x ctrl-e` | 打开默认编辑器（`export EDITOR=vim`）编辑当前输入的命令，常用于编辑长命令                                                                                     |

## Control-C（^C）

^C 使终端发出一个 **SIGINT** 信号（即中断 “interupt” 信号）给当前前台进程，默认将转换为终止应用程序。

## Control-D（^D）

^D 使终端发出一个文件结束符 EOF 信号给当前前台进程的标准输入（stdin）。默认只在一行的开头起作用，如果希望在行中或行末起作用，需要按两下。

更多快捷键：`man readline`（Linux）

## 参考

* [Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html)
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html)
* [命令行的艺术](https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md)