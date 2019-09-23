# 内置常量

| 常量           | 描述 |
| -------------- | ---- |
| False          |      |
| True           |      |
| None           |      |
| NotImplemented |      |
| Ellipsis       |      |
| __debug__      |      |

## 由 site 模块添加的常量

site 模块（在启动期间自动导入，除非给出 -S 命令行选项）将几个常量添加到内置命名空间。 它们对交互式解释器 shell 很有用，并且不应在程序中使用。

| site 模块       | 描述 |
| --------------- | ---- |
| quit(code=None) |      |
| exit(code=None) |      |
| copyright       |      |
| credits         |      |
| license         |      |

## 参考

* [内置常量](https://docs.python.org/zh-cn/3/library/constants.html)
