# typedef

对已有数据类型指定别名。

## 语法

```c
typedef <existing_name> <alias_name>;
```

## 示例

```c
typedef unsigned int uint;
```

```c
struct node {
    int data;
    struct node* next;
};
typedef struct node Node;

/*----- 等同于 -----*/

typedef struct node {
    int data;
    struct node* next;
} Node;
```
