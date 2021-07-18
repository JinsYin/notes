# SUMMARY

- [简介](README.md)
- [入门](quickstart.md)
- [数据类型](type/README.md)
  - [数组](type/array.md)
  - [字符](type/char.md)
  - [枚举](type/enum.md)
  - [指针](type/pointer.md)
  - [字符串](type/string.md)
  - [结构体](type/structure.md)
  - [Union](type/union.md)
- [函数](function/README.md)
  - [匿名函数](function/anonymous.md)
  - [函数调用](function/call.md)
  - [函数声明](function/declaration.md)
  - [函数定义](function/definition.md)
  - [内联函数](function/inline.md)
- [流程控制](flow-control/README.md)
  - [选择结构]()
    - [if 语句](flow-control/decision/if.md)
    - [switch 语句](flow-control/decision/switch.md)
  - [循环结构](flow-control/loop/README.md)
    - [do...while 语句](flow-control/loop/do-while.md)
    - [for 循环](flow-control/loop/for.md)
    - [while 循环](flow-control/loop/while.md)
- [表达式](expression/README.md)
  - [运算符](expression/operator/README.md)
    - [算术运算符](expression/operator/arithmetic-opr.md)
    - [赋值运算符](expression/operator/assignment-opr.md)
    - [按位运算符](expression/operator/bitwise-opr.md)
    - [自增/自减](expression/operator/increament&decrement-opr.md)
    - [逻辑运算符](expression/operator/logical-opr.md)
    - [关系运算符](expression/operator/relational-opr.md)
    - [其他运算符](expression/operator/other.md)

## 词法规则

- [词法规则](lexical/README.md)
- [记号](lexical/token/README.md)
  - [常量](lexical/token/constant/README.md)
    - [字符常量](lexical/token/constant/character-const.md)
    - [枚举常量](lexical/token/constant/enumeration-const.md)
    - [浮点常量](lexical/token/constant/floating-const.md)
    - [整型常量](lexical/token/constant/integer-const.md)
  - [标识符](lexical/token/indetifier.md)
  - [关键字](lexical/token/keyword.md)
  - [字符串常量](lexical/token/string-literal.md)
- [空白符](lexical/whitespace/README.md)
  - [注释（Comments）](lexical/whitespace/comments.md)

---

- [概念](concept/README.md)
- [宏](concept/macro.md)
- [进程控制](concept/process-control/README.md)
- [作用域](concept/scope.md)
- [语句](concept/statement.md)
- [存储类](concept/storageclass/README.md)
- [遍历](concept/variable/README.md)
- [类](concept/class.md)

---

- [指令](derective/README.md)
  - [ifdef-else-endif](derective/ifdef-else-endif.md)
  - [ifndef-end-endif](derective/ifndef-else-endif.md)
- [垃圾回收](gc.md)

- [翻译](translation/README.md)
  - [预处理器](translation/preprocessor/README.md)
  - [编译](translation/compilation.md)
  - [编译器](translation/compiler/README.md)
  - [汇编代码](translation/asm-code.md)

---

## 关键字

- [auto](keyword/auto.md)
- [#define](keyword/define.md)
- [#ifdef...#endif](keyword/ifdef-endif.md)
- [#ifndef ... #endif](keyword/ifndef-endif.md)
- [include](keyword/include.md)
- [inline](keyword/inline.md)
- [register](keyword/register.md)
- [static](keyword/static.md)
- [typedef](keyword/typedef.md)

## 标准库

- [libc](libc/README.md)

- [标准库](libc/stdlib/README.md)
  - [assert.h](libc/stdlib/assert-h/README.md)
  - [ctype.h](libc/stdlib/ctype-h/README.md)
  - [errno.h](libc/stdlib/errno-h/README.md)
  - [float.h](libc/stdlib/float-h/README.md)
  - [limits.h](libc/stdlib/limits-h/README.md)
  - [locale.h](libc/stdlib/locale-h/README.md)
  - [math.h](libc/stdlib/math-h/README.md)
  - [setjmp.h](libc/stdlib/setjmp-h/README.md)
  - [signal.h](libc/stdlib/signal-h/README.md)
  - [stdarg.h](libc/stdlib/stdarg-h/README.md)
  - [stddef.h](libc/stdlib/stddef-h/README.md)
  - [stdio.h](libc/stdlib/stdio-h/README.md)
    - [getchar/putchar](libc/stdlib/stdio-h/getchar-and-putchar.md)
    - [printf](libc/stdlib/stdio-h/printf.md)
  - [stdlib.h](libc/stdlib/stdlib-h/README.md)
  - [string.h](libc/stdlib/string-h/README.md)
  - [time.h](libc/stdlib/time-h/README.md)

- [glibc](libc/glibc/README.md)
  - [__attribute__](libc/glibc/__attribute__.md)
- [POSIX C](libc/C-POSIX.md)
- [bionic](libc/bionic/README.md)
- [msvc](libc/msvc/README.md)

## 附录

- [代码规范](/appendix/style-guide.md)
