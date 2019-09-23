# if · else if · else

C 语言假定任何非零（non-zero）或非空（non-null）值为 **true**，如果是零（zero）或空（NULL）则假定为 **false** 值。

## 基本语句

* if
* if...else
* if...else if
* if...else if..else

通过上述基本语句可以相互嵌套组合成更加复杂的语句形式。

## if 语句

* 语法

```c
if (A)  // boolean expression
    B;  // single statement

C;      // expression
```

```c
if (A) { // boolean expression
    B;   // single or multiple statement(s)
}

C;       // expression
```

* 流程图

```graph
+---------+     +-----+  false   +-----+     +-------+
| (start) | --> |  A  | -------> |  C  | --> | (end) |
+---------+     +-----+          +-----+     +-------+
                  |                 ^
                  | true            |
                  v                 |
                +-----+             |
                |  B  | ------------+
                +-----+

```

## if...else 语句

* 语法

```c
if (A)  // boolean expression
    B;  // single statement
else
    C;  // single statement

D;
```

```c
if (A) { // boolean expression
    B;   // single or multiple statement(s)
} else {
    C;   // single or multiple statement(s)
}

D;
```

* 流程图

```graph
+---------+     +--------+  true   +-----+     +-----+     +-------+
| (start) | --> |   A    | ------> |  B  | --> |  D  | --> | (end) |
+---------+     +--------+         +-----+     +-----+     +-------+
                  |                               ^
                  | false                         |
                  v                               |
                +--------+                        |
                |   C    | -----------------------+
                +--------+
```

## if...else if 语句

* 语法

（包含一个或多个 `else if` 块）

```c
if (A)      // boolean expression
    B;      // single statement
else if (C) // boolean expression
    D;      // single statement

E;          // expression
```

```c
if (A) {        // boolean expression
    B;          // single or multiple statement(s)
} else if (C) { // boolean expression
    D;          // single or multiple statement(s)
}

E;              // expression
```

* 流程图

（混淆点：`A == true` 时执行完 B 后，是否还要执行 C？当然不需要，不然怎么叫 `else if` 呢）

```graph
+---------+     +-------+  true   +-----+        +-----+        +-------+
| (start) | --> |   A   | ------> |  B  | -----> |  E  | -----> | (end) |
+---------+     +-------+         +-----+        +-----+        +-------+
                  |                                 ^
                  | false                           |
                  v                                 |
                +-------+  true   +-----+           |
                |   C   | ------> |  D  | --------->+
                +-------+         +-----+           |
                  |                                 |
                  | false                           |
                  v                                 |
                  +-------------------------------->+

```

## if...else if...else 语句

* 语法

（包含一个或多个 `else if` 块）

```c
if (A)      // boolean expression
    B;      // single statement
else if (C) // boolean expression
    D;      // single statement
else
    E;      // single statement

F;          // expression
```

```c
if (A) {        // boolean expression
    B;          // single or multiple statement(s)
} else if (C) { // boolean expression
    D;          // single or multiple statement(s)
} else {
    E;          // single or multiple statement(s)
}

F;              // expression
```

* 流程图

```graph
+---------+     +-------+  true   +-----+        +-----+        +-------+
| (start) | --> |   A   | ------> |  B  | -----> |  F  | -----> | (end) |
+---------+     +-------+         +-----+        +-----+        +-------+
                  |                                 ^
                  | false                           |
                  v                                 |
                +-------+  true   +-----+           |
                |   C   | ------> |  D  | --------->+
                +-------+         +-----+           |
                  |                                 |
                  | false                           |
                  v                                 |
                +-------+                           |
                |   E   | ------------------------->+
                +-------+
```
