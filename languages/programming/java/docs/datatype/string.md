# String

* 两个字符串之间可以使用 `+` 进行连接
* 字符串使用 `" ... "` 括起来
* 任何数据类型遇到 String 类型的变量或常量都将转换成 String 类型

## String、StringBuffer、StringBuilder

| 类            | 可变？ | 线程安全？ | 描述                           |
| ------------- | ------ | ---------- | ------------------------------ |
| String        | No     | Yes        |                                |
| StringBuffer  | Yes    | Yes        | 内部使用 `synchronized` 来同步 |
| StringBuilder | Yes    | No         |                                |

## String Pool
