# 调试（Debug）

## 概述

| Name            | 栈（Stack） | 描述                                                           | VS Code                             | Jetbrains   | Vim |
| --------------- | ----------- | -------------------------------------------------------------- | ----------------------------------- | ----------- | --- |
| continue        |             | 继续运行程序到下一个断点，直到程序结束                         | F5                                  |             |     |
| step into       | 入栈        | 逐步调试代码；当调试到 `调用的函数` 时，进入（迈入）函数调用链 | F11                                 | F11         |     |
| Smart step into | 入栈        |                                                                | Shift + F7                          | Shift+F7    |     |
| step out        | 出栈        | 不想调试进入的函数时，跳出（迈出）该函数调用链                 | ~                                   | Shift + F11 |     |
| step over       |             | 对某个 `调用的函数` 不感兴趣时，跳过（跨越）它                 | F10                                 |             |     |
| breakpoint      |             | 设置断点                                                       | F9                                  |             |     |
| start           |             | 启动调试器                                                     | F5                                  |             |     |
| restart         |             | 重启调试器                                                     | Ctrl + Shift + F5                   |             |     |
| stop            |             | 停止调试器                                                     | Shift + F5 (Debug > Stop debugging) |             |     |

* 断点（breakpoint） - 红色圆点
* 执行指针（execution pointer） - 黄色箭头