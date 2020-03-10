# 枚举（Enumeration）

* 枚举成员的默认值从 0 开始，依次递增 1；从有枚举值的成员开始递增
* 枚举成员可以像全局变量一样直接使用，通常作为枚举变量的值

## 定义

```c
// 枚举类型
enum WEEKDAY
{
    MON, TUE, WED, THU, FRI, SAT, SUN // 枚举值依次是 0 1 2 3 4 5 6
};
// 定义枚举变量并显式初始化
enum WEEKDAY day = SUN;

/*----- or -----*/

typedef enum
{
    MON=1, TUE, WED, THU, FRI, SAT, SUN // 枚举值依次是 1 2 3 4 5 6 7
} WEEKDAY;
WEEKDAY day = SUN;
```

```c
// 枚举类型
typedef enum
{
    MON=1, TUE, WED, THU, FRI, SAT, SUN // 枚举值依次是 1 2 3 4 5 6 7
} WEEKDAY;

// 定义枚举变量并初始化
WEEKDAY day = MON;
```

```c
// 定义枚举类型 + 定义枚举变量
enum WEEKDAY {
    MON, TUE, WED, THU=4, FRI, SAT, SUN // 枚举值依次是 0 1 2 4 5 6 7
} day;
```

```c
// 定义枚举变量
enum {
    MON, TUE, WED, THU=4, FRI, SAT, SUN // 枚举值依次是 0 1 2 4 5 6 7
} day;
```

## 示例

```c
// 用枚举定义顺序
typedef enum {
    ASC = 1, // 递增
    DESC = 0 // 递减
} ORDER;
```
