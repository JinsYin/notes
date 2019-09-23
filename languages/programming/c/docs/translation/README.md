# 翻译

程序有存储在文件中的一个或多个翻译单元（translation unit）组成。

## 程序的翻译阶段

1. 完成低级的词法转换，执行以字符 `#` 开头的行当中的指令，并进行宏定义（macro defination）和宏扩展（macro expansion）。
2. 预处理完成后，程序被规约成一个记号（token）序列。
