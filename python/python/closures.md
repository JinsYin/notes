# 闭包

## 嵌套函数

```python
def print_msg(number):
    def printer():
        "Here we are using the nonlocal keyword"
        nonlocal number
        number=3
        print(number)
    printer()
    print(number)

"""
有 nonlocal:
    3
    3
无 nonlocal:
    3
    9
"""
print_msg(9)
```