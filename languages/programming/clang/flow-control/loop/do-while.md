# do...while 语句

## 语法

```c
do {
    A;       // single or multiple statement(s)
} while (B); // condition statement

C;           // expression
```

* A 会在条件测试之前执行一次
* while() 后面必须有一个分号，因为是一个语句

## 流程图

```graph
                      true
                  +-------------+
                  v             |
+---------+     +---+         +---+  false   +---+     +-------+
| (start) | --> | A | ------> | B | -------> | C | --> | (end) |
+---------+     +---+         +---+          +---+     +-------+
```

## 示例
