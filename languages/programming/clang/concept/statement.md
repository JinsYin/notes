# 语句（statement）

计算机程序由一系列语句组成。

## 分类

* 标签语句（Labeled Statements）
* 复合语句（Compound Statements）
* 表达式语句（Expression Statements）
* 选择语句（Selection Statements）
* 迭代语句（Iteration Statements）
* 跳转语句（Jump Statements）
* 空语句（）

## 分号

每条语句必须以分号（semicolon）结束，即分号是语句终止符(statement terminator）。

建议每行只写一条语句，并在运算符两边各加上一个空格字符，使运算的关系更清晰明了。

```c
printf("Hello, World! \n");
```

```c
// work
printf
(
"Hello, World! \n"
)
;
```

## 语句块

* 函数语句块
* 非函数语句块（if、switch、for、while、do）

## 空语句

C 语言使用一个单独的分号 `;` 表示 **空语句**。

```c
void empty()
{
    ;
}
```

## 可执行语句

## 参考

* [C Programming/Statements](https://en.wikibooks.org/wiki/C_Programming/Statements)
