# Java 数据类型（Data Type）

* 基本数据类型
* 引用数据类型

| 数据类型 | 内存大小（bit） | 值域                                       | 描述           |
| -------- | --------------- | ------------------------------------------ | -------------- |
| byte     | 8               | -128 ~ 127                                 |                |
| char     | 16              |                                            |                |
| short    | 16              | -32768 ~ 32767                             |                |
| int      | 32              | -2147483648 ~ 2147483647                   |                |
| long     | 64              | -9223372036854775808 ~ 9223372036854775807 |                |
| float    | 32              | 1.4E-45 ~ 3.4028235E38                     | 小数点后 7 位  |
| double   | 64              | 4.9E-324 ~ 1.7976931348623157E308          | 小数点后 15 位 |
| boolean  | -               | `true` 或 `false`                          |                |

## 拆箱和装箱

| -       | -         |
| ------- | --------- |
| byte    | Byte      |
| char    | Character |
| short   | Short     |
| int     | Integer   |
| long    | Long      |
| float   | Float     |
| double  | Double    |
| boolean | Boolean   |


## 类型默认值

| Data Type                  | Default Value (for fields) |
| -------------------------- | -------------------------- |
| byte                       | `0`                        |
| short                      | `0`                        |
| int                        | `0`                        |
| long                       | `0L`                       |
| float                      | `0.0f`                     |
| double                     | `0.0d`                     |
| char                       | `'\u0000'`                 |
| boolean                    | `false`                    |
| 引用数据类型（String ...） | `null`                     |

## 类型溢出

```java
long a = Integer.MAX_VALUE;           // 2147483647
long b = Integer.MAX_VALUE + 1;       // -2147483648 （类型溢出）
long c = Integer.MAX_VALUE + 1L;      // 2147483648  （自动类型转换）
long d = (long)Integer.MAX_VALUE + 1; // 2147483648  （强制类型转换）
```

## 数值默认类型

* 所有整数数值（如 `1024`）都是 _int_ 类型
* 所有小数数值（如 `1.23`）都是 _double_ 类型

```java
// error: integer number too large
long a = 12345678900;  // 错（12345678900 超出了 int 范围）
long a = 12345678900L; // 对
long a = 123;          // 对
```

```java
// error: incompatible types: possible lossy conversion from double to float
float f = 1.23  // 错（1.23 是 double 类型，存在精度损失）
float f = 1.23f // 对
```

## 参考

* [Primitive Data Types](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html)