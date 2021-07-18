# C 语言入门

## 环境设置

* 文本编辑器

```c
$ vim --version
```

* 编译器

```sh
$ gcc --version
```

## 编写 Hello World 程序

* C89（hello-c89.c）

```c
#include <stdio.h> /** 导入标准输入输出库 **/

/** 主函数，不接受参数或接受 void 参数 **/
void main()
{
    /** 调用库函数 printf **/
    printf("Hello, world\n");
}
```

* C99（hello-c99.c）

```c
#include <stdio.h> // 导入标准输入输出库

// 主函数，不接受参数或接受 void 参数
int main()
{
    // 调用库函数 printf
    printf("Hello, world\n");

    // 终止 main() 函数并返回整数 0
    return 0;
}
```

## 编译运行

默认情况下，gcc 不符合任何 ANSI C / ISO C 标准。当前默认值等效于 `-std=gnu90`

gcc 4.7
gcc 5.1.0 --> 2015-04-22 --> `-std=gnu11`

```sh
# 使用 C89 标准编译
$ gcc -std=c89 hello-c89.c

# 生成了 a.out 可执行文件
$ ls
a.out hello-c89.c

# 运行
$ ./a.out
Hello, world
```
