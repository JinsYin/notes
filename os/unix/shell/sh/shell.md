# Linux Shell

## Shell 类型

* Bash
* Zsh

## 命名规范

脚本命名：

```PlainText
start-namenode.sh
```

函数命名：

```PlainText
首字母大写， CreateFile()
```

## 关键字 `$`

```sh
# 假设运行以下脚本
$ ./run-script.sh user 123456
```

`$$`: 返回执行当前脚本时的 PID，cat /var/run/run-script.sh.pid
`$*`: 返回脚本后传递的参数，如："user 123456"
`$@`: 返回脚本后传递的参数, 如："user" "123456"
    * `${@: 2}`：从第 2 个开始的全部参数
    * `${@: 3:2}`：从第 3 个参数开始，共计 2 个参数
    * `${@: -1:1}`：最后一个参数
`$#`: 返回参数个数，如：2
`$0`: 既然`$1`返回第一个参数，$0 自然就返回脚本的文件名, 如："run-script.sh"
`$?`: 获取上一个命令的返回（ `return`） 值/退出（ `exit` ）状态（`0` 表示 success，非零表示 failure）

```sh
$ cat run-script.sh
#!/bin/sh

# 定义函数
Hello () {
 echo "Hello World $1 $2"
 echo $*
 echo $@
 return 10
}

# 调用该函数
Hello Zara Ali

# 获取上一个命令的返回值
ret=$? # 10

echo "Return value is $ret"
```

## exit、return

`exit` 会退出当前脚本，`return` 只是结束了当前函数。相同的是，无论是返回值还是退出状态都是数字。

```sh
#!/bin/bash

retfunc()
{
    echo "this is retfunc()"
    return 1
}

exitfunc()
{
    echo "this is exitfunc()"
    exit 1
}

retfunc
echo "We are still here"
exitfunc
echo "We will never see this"
```

## set

| 命令                     | 含义                                               |
| ------------------------ | -------------------------------------------------- |
| set -e 或 set -o errexit | 如果 `return` 或 `exit` 传递的只是非零，则退出脚本 |
|                          |                                                    |

## 退出状态码（exit code）

> http://tldp.org/LDP/abs/html/exitcodes.html
> http://tldp.org/LDP/abs/html/exit-status.html

## 关键字 `if`

> 注意参数对应的是 `文件`（目录也是文件）、`数字` 还是 `字符串`，以及 [] 之间的`空格`。

处理文件:

```sh
if [ -f FILE ] fi; # 若文件存在， 则返回 true（支持正则）
if [ -e FILE ] fi; # 若文件存在， 则返回 true（不支持正则）
if [ -r FILE ] fi; # 若文件可读（readable），则返回 true
if [ -w FILE ] fi; # 若文件可读（writable），则返回 true
if [ -x FILE ] fi; # 若文件可执行（executable），则返回 true
if [ -s FILE ] fi; # 若文件大小大于 0（sized）, 即文件不为空，则返回 true
if [ ! -s FILE ] fi; # 若文件为空，则返回 true。这里很容易与 -z 混淆
```

处理整数:

```sh
# NUM1 和 NUM2 都是整数，不可以是小数
if [ NUM1 OP NUM2 ] fi;  # OP 可以是 -eq、-ne、-lt、-le、-gt、-eg
```

处理字符串:

```sh
# STRING1 和 STRING2 都是字符串
if [ STRING1 == STRING2 ] fi; # 若两个字符串相等，则返回 true
if [ STRING1 !=  STRING2 ] fi; # 若两个字符串不相等，则返回 true
if [ STRING1 > STRING2 ] fi； # 若字符串STRING1大于STRING，则返回 true
if [ STRING1 < STRING2 ] fi; # 若字符串STRING1大于STRING，则返回 true
if [ -n STRING ] fi; # 若字符串长度不等于 0（non-zero）, 则返回 true
if [ -z STRING ] fi; # 若字符串长度为 0（zero），则返回 true
```

处理表达式:

```sh
$ if [ ! EXPR ] fi; # 若表达式为 false, 则返回 true
$ if [ ( EXPR ) ]; fi; # 若表达式的值为 false, 则返回 true
$ if [ \( EXPR1 \) -a \( EXPR2 \) ] fi; # 若表达式 EXPR1 和表达式 EXPR2 皆为 true, 则返回 true
$ if [ ( EXPR1 ) ] && [ ( EXPR2 ) ]; fi # 同上
$ if [ \( EXPR1 \) -o \( EXPR2 \) ] fi; # 若表达式 EXPR1 或表达式 EXPR 为 true, 则返回 true
$ if [ ( EXPR1 ) ] || [ ( EXPR2 ) ]; fi # 同上
```

## 默认值

* **:=**

`: ${VARIABLE:=DEFAULT_VALUE}` 表示如果 VARIABLE 变量不存在的话，将 DEFAULT_VALUE 的值赋值个 VARIABLE 变量。

```sh
$ DEFAULT_VALUE="123"

$ echo "x=$x"
x=

# 冒号表示这是一个设置默认值的命令
$ : ${x:=$DEFAULT_VALUE}

$ echo "x=$x"
x=123

$ : ${x:="456"}

$ echo "x=$x"
x=123
```

常见的示例：

```sh
# 把 666 赋值给 VARIABLE，再把 VARIABLE 赋值给 FOO
$ FOO=${VARIABLE:="666"}
```

* **:-**

`VARIABLE3=${VARIABLE2:-$VARIABLE1}` 表示如果 VARIABLE2 不存在的话，将 VARIABLE1 的值赋值给 VARIABLE3，否则将 VARIABLE2 的只赋值给 VARIABLE3，另外，VARIABLE1 不会赋值给 VARIABLE2。

```sh
$ vi defvalue.sh
#!/bin/bash
variable1=$1
variable2=${2:-$variable1}

echo $variable1
echo $variable2

$ ./defvalue.sh first-value second-value
first-value
second-value

$ ./defvalue.sh first-value
first-value
first-value
```

## eval

`eval` 可调用脚本中的函数。

```sh
$ cat x.sh
#!/bin/bash

fx() {
    echo "Hello, world"
}

eval $@
```

脚本外执行 fx 函数。

```sh
% x.sh fx
```

## 工具

* [ShellCheck](https://github.com/koalaman/shellcheck)

## 参考

* [Bash 指南 - 条件语句](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)
* [shell 编程规范](https://wenku.baidu.com/view/cf3b683067ec102de2bd8969.html)
* [Assigning default values to shell variables with a single command in bash](https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash)
