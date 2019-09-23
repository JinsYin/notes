# Generator

## 生成器

```python
# 生成器表达式（generator expression）
(i for i in items)
```

```python
# 生成器函数
def generator():
    yield 1
    yield "a"
    yield [1, 3, 5]
    print("------")
    yield {"name": "John", "age": 18}

"""
1
a
[1, 3, 5]
------
{'name': 'John', 'age': 18}
"""
for x in generator():
    print(x)
```
