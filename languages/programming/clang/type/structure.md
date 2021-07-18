# 结构体（Structure）

## 定义

```c
// 定义名为 person 的结构体
struct person {
    char* name; // 结构体成员
    int age;
};

// 定义结构体变量
struct person p1 p2;
```

```c
struct {
    char* name;
    int age;
} p1 p2;
```

```c
typedef struct {
    char* name;
    int age;
} person;

// 定义结构体变量
person p1 p2;

// 定义指向结构体变量的指针
person* p;
```

## 运算符

| 运算符 | 用途                           | 示例                                     |
| ------ | ------------------------------ | ---------------------------------------- |
| `.`    | 结构体变量访问其成员           | `structure.member`                       |
| `->`   | 指向结构体变量的指针访问其成员 | `pointer->member` == `(*pointer).member` |
