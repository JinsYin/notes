---
---
# exec

Shell 的内置命令 `exec` 以新程序替换当前的 shell 程序（进程），但不会创建新的进程（即 PID 不变），运行完毕之后不会回到原先的程序中去。

## 示例

```sh
# 终端 1（Bash shell）

# 获取当前 Bash 进程的 PID
$ echo $$
379649

$ exec ping baidu.com
```

```sh
# 终端 2（Bash shell）

$ pstree -asp 379649
init,1
  └─lightdm,1544
      └─lightdm,1989 --session-child 12 19
          └─init,7579 --user
              └─gnome-terminal,65053
                  └─ping,657363 baidu.com # 进程已改变，PID 未改变
```
