# 编译器/解释器

| PL     | 编译器/解释器 |
| ------ | ------------- |
| c      | gcc           |
| scala  | scalac        |
| java   | javac         |
| python | cpython       |

## 自举（Self-Hosting）/自编译

高级语言自举过程：

1. 先用 `机器语言` 编写 `汇编器`，然后可以使用 `汇编语言` 编程，再用 `汇编语言` 编写 `汇编器`
2. 先用 `汇编语言` 编写 `C 编译器`，然后可以使用 `C 语言` 编程，再用 `C 语言` 编写 `C 编译器`
3. 有了 `C 语言` 和 `C 编译器`，就可以在此基础上编写高级语言的编译器、解释器或虚拟机

## Yacc

* [Yacc](https://en.wikipedia.org/wiki/Yacc)

## 参考

* [操作系统是 C 语言写的，那么问题来了](https://segmentfault.com/q/1010000004105427)
* [第一个 C 语言编译器是怎样编写的](http://blog.jobbole.com/94311/)
* [Self-hosting](https://en.wikipedia.org/wiki/Self-hosting)
* [编译器的自举原理是什么？](https://www.zhihu.com/question/28513473)
