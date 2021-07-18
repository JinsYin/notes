# 字符常量（Character Constant）

字符常量是用单引号 `'` 括起来的一个或多个字符构成的序列，例如 `'x'`。

单字符常量的值是执行时机器字符集中此字符对应的数值。多字符常量的值有具体实现定义。

单引号中的字符表示一个整型值，该值等于此字符在机器字符集中对应的数值，我们称为字符常量。C 语言使用 ASCII 将字符值编码为数字。

```sh
$ man ascii
```

单引号 `''` 括起来的字符是 `char` 类型，双引号 `""` 括起来的字符是 `char *` 类型。

## 种类

| 种类                            | 示例      |
| ------------------------------- | --------- |
| 普通字符（plain character）     | 'x'       |
| 转义序列（escape sequence）     | '\t'      |
| 通用字符（universal character） | '\u020C0' |

## 转义序列（Escape sequences）

普通字符常量不包括换行、回车、`\`、 `'`、`?` 和 `"` 等特殊字符，需要使用转义序列来表示它们：

| 特殊序列名称                 | 特殊字符缩写 | 转义序列代码 |
| ---------------------------- | ------------ | ------------ |
| 换行符（newline）            | NL（LF）     | `\n`         |
| 横向制表符（horizontal tab） | HT           | `\t`         |
| 纵向制表符（vertical tab）   | VT           | `\v`         |
| 回退符（backspace）          | BS           | `\b`         |
| 回车符（carriage return）    | CR           | `\r`         |
| 换页符（formfeed）           | FF           | `\f`         |
| 响铃符（audible alert）      | BEL          | `\a`         |
| 反斜杠（backslash）          | \            | `\\`         |
| 问号（question mark）        | ?            | `\?`         |
| 单引号（single quote）       | '            | `'`          |
| 双引号（double quote）       | "            | `"`          |
| 八进制（octal number）       | ooo          | `\ooo`       |
| 十六进制（hex number）       | hh           | `\xhh`       |
