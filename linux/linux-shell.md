# Linux Shell (bash)

## 命名规范

脚本命名
```
start-namenode.sh
```

函数命名
```
首字母大写， CreateFile()
```

## 关键字`$`

```bash
# 假设运行以下脚本
$ ./run-script.sh user 123456
```

`$$`: 返回执行当前脚本时的 PID，cat /var/run/run-script.sh.pid 
`$*`: 返回脚本后传递的参数，如："user 123456"
`$@`: 返回脚本后传递的参数, 如："user" "123456"
`$#`: 返回参数个数，如：2
`$0`: 既然`$1`返回第一个参数，$0 自然就返回脚本的文件名, 如："run-script.sh"
`$?`: 获取上一个命令的返回值

```bash
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

## 关键字`if`

>注意参数对应的是`文件`（目录也是文件）、`数字`还是`字符串`，以及 [] 之间的`空格`。

处理文件
```bash
if [ -f FILE ] fi; # 若文件存在， 则返回 true（支持正则）
if [ -e FILE ] fi; # 若文件存在， 则返回 true（不支持正则）
if [ -r FILE ] fi; # 若文件可读（readable），则返回 true
if [ -w FILE ] fi; # 若文件可读（writable），则返回 true
if [ -x FILE ] fi; # 若文件可执行（executable），则返回 true
if [ -s FILE ] fi; # 若文件大小大于 0（sized）, 即文件不为空，则返回 true
if [ ! -s FILE ] fi; # 若文件为空，则返回 true。这里很容易与 -z 混淆
```

处理整数
```bash
# NUM1 和 NUM2 都是整数，不可以是小数
if [ NUM1 OP NUM2 ] fi;  # OP 可以是 -eq、-ne、-lt、-le、-gt、-eg
```

处理字符串
```bash
# # STRING1 和 STRING2 都是字符串
if [ STRING1 == STRING2 ] fi; # 若两个字符串相等，则返回 true
if [ STRING1 !=  STRING2 ] fi; # 若两个字符串不相等，则返回 true
if [ STRING1 > STRING2 ] fi； # 若字符串STRING1大于STRING，则返回 true
if [ STRING1 < STRING2 ] fi; # 若字符串STRING1大于STRING，则返回 true
if [ -n STRING ] fi; # 若字符串长度不等于 0（non-zero）, 则返回 true
if [ -z STRING ] fi; # 若字符串长度为 0（zero），则返回 true
```

处理表达式
```bash
$ if [ ! EXPR ] fi; # 若表达式为 false, 则返回 true
$ if [ ( EXPR ) ]; fi; # 若表达式的值为 false, 则返回 true
$ if [ \( EXPR1 \) -a \( EXPR2 \) ] fi; # 若表达式 EXPR1 和表达式 EXPR2 皆为 true, 则返回 true
$ if [ ( EXPR1 ) ] && [ ( EXPR2 ) ]; fi # 同上
$ if [ \( EXPR1 \) -o \( EXPR2 \) ] fi; # 若表达式 EXPR1 或表达式 EXPR 为 true, 则返回 true
$ if [ ( EXPR1 ) ] || [ ( EXPR2 ) ]; fi # 同上
```

>http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
