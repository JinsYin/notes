# 调试（Debug）

## 概述

| Name            | 栈（Stack） | 描述                                                           | VS Code                                        | Jetbrains              | Vim |
| --------------- | ----------- | -------------------------------------------------------------- | ---------------------------------------------- | ---------------------- | --- |
| continue        |             | 继续运行程序到下一个断点，直到程序结束                         | <kbd>F5</kbd>                                  |                        |     |
| step into       | 入栈        | 逐步调试代码；当调试到 `调用的函数` 时，进入（迈入）函数调用链 | <kbd>F11</kbd>                                 | <kbd>F11</kbd>         |     |
| Smart step into | 入栈        |                                                                | <kbd>Shift + F7</kbd>                          | <kbd>Shift + F7</kbd>  |     |
| step out        | 出栈        | 不想调试进入的函数时，跳出（迈出）该函数调用链                 | ~                                              | <kbd>Shift + F11</kbd> |     |
| step over       |             | 对某个 `调用的函数` 不感兴趣时，跳过（跨越）它                 | <kbd>F10</kbd>                                 |                        |     |
| breakpoint      |             | 设置断点                                                       | <kbd>F9</kbd>                                  |                        |     |
| start           |             | 启动调试器                                                     | <kbd>F5</kbd>                                  |                        |     |
| restart         |             | 重启调试器                                                     | <kbd>Ctrl + Shift + F5</kbd>                   |                        |     |
| stop            |             | 停止调试器                                                     | <kbd>Shift + F5</kbd> (Debug > Stop debugging) |                        |     |

* 断点（breakpoint） - 红色圆点
* 执行指针（execution pointer） - 黄色箭头
