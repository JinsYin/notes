# C 代码风格（C coding style）

* [命名](#naming)
* [缩进](#缩进)
* [大括号和空格的放置](#大括号和空格的放置)
* [大括号和空格的放置](#大括号和空格的放置)
* [注释](#注释)
* [格式化](#格式化)
* [头文件](#头文件)
* [作用域](#作用域)
* [类](#类)

## 命名

## 缩进

* 制表符是 8 个字符，所以缩进也是 8 个字符。
  * 理由：缩进的全部意义就在于清楚的定义一个控制块起止于何处。
  * 8 个字符的缩进可以让代码更容易阅读，还有一个好处是当你的函数嵌套太 深的时候可以给你警告。留心这个警告。
* 不要把多个语句放在一行
* 不要在一行放多个赋值语言
* 除了注释、文档和 Kconfig 之外，不要使用空格来缩进
* 选用一个好的编辑器，不要在行尾留空格
* 在 switch 语句中消除多级缩进的首选的方式是让 switch 和从属于它的 case 标签对齐于同一列，而不要 两次缩进 case 标签

```c
switch (suffix) {
case 'G':
case 'g':
        mem <<= 30;
        break;
case 'M':
case 'm':
        mem <<= 20;
        break;
case 'K':
case 'k':
        mem <<= 10;
        /* fall through */
default:
        break;
}
```

## 把长的行和字符串打散

* 每一行的长度限制在 **80 列**
* 长于 80 列的语句要打散成有意义的片段。除非超过 80 列能显著增加可读性，并且不 会隐藏信息。子片段要明显短于母片段，并明显靠右。这同样适用于有着很长参数列表 的函数头。然而，绝对不要打散对用户可见的字符串，例如 printk 信息，因为这样就很难对它们 grep。

## 大括号和空格的放置

* 首选的方式，就像 Kernighan 和 Ritchie 展示 给我们的，是把起始大括号放在行尾，而把结束大括号放在行首，所以：

```c
if (x is true) {
        we do y
}
```

* 有一个例外，那就是函数：函数的起始大括号放置于下一行的开头，所以：

```c
int function(int x)
{
        body of function
}
```

* 注意结束大括号独自占据一行，除非它后面跟着同一个语句的剩余部分，也就是 do 语 句中的 “while” 或者 if 语句中的 “else”

```c
do {
        body of do-loop
} while (condition);
```

```c
if (x == y) {
        ..
} else if (x > y) {
        ...
} else {
        ....
}
```

* 当只有一个单独的语句的时候，不用加不必要的大括号

```c
if (condition)
        action();
```

```c
if (condition)
        do_this();
else
        do_that();
```

* 这并不适用于只有一个条件分支是单语句的情况；这时所有分支都要使用大括号：

```c
if (condition) {
        do_this();
        do_that();
} else {
        otherwise();
}
```

## 参考

* [Linux 内核代码风格](https://www.kernel.org/doc/html/latest/translations/zh_CN/coding-style.html#linux)
* [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
* [Making The Best Use of C](https://www.gnu.org/prep/standards/html_node/Writing-C.html)
* [C++ 风格指南 - 内容目录](https://zh-google-styleguide.readthedocs.io/en/latest/google-cpp-styleguide/contents/)
* [谷歌编程风格指南_C语言版](https://github.com/twowinter/CodeStyleForC/blob/master/%E8%B0%B7%E6%AD%8C%E7%BC%96%E7%A8%8B%E9%A3%8E%E6%A0%BC%E6%8C%87%E5%8D%97_C%E8%AF%AD%E8%A8%80%E7%89%88.md)
