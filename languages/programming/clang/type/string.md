# 字符串（Character string）

## 定义

```go
// 字符数组
char strOne[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
char strTwo[] = {'H', 'e', 'l', 'l', 'o', '\0'};

char strThree[6] = "Hello";
char strFour[] = "Hello";

char* string = "Hello"
```

## 示例

```c
int main () {
  char string[] = {'H', 'e', 'l', 'l', 'o', '\0'};
  printf("%s\n", string); // Hello
  return 0;
}
```
