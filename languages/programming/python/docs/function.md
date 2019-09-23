# 函数

## 函数参数

### 位置参数（Positional Arguments）

```python
def func(x, y):
    """参数必须、无默认值"""
    pass

func(1, 2)
func(x=1, y=2)
func(y=2, x=1)
```

### 关键字参数（Keyword Arguments）

```python
def func(name, age=None, score=60):
    """参数可选且有默认值"""
    if age is not None:
        print(name)
        print(age)
        print(score)

func("John")
func("John", 18)
func("John", 18, 100)
func("John", score=18)
func("John", score=100, age=18)
```

### 可变参数列表（Arbitrary Argument List）

```python
def func(first, *args):
    """任意参数列表（arbitrary argument list）"""
    pass

func("first")
func("first", 1)
func("first", 1, ["x", "y"])
```

### 可变关键字参数字典（Arbitrary Keyword Argument Dictionary）

```python
def func(first, **kwargs):
    if kwargs["name"]:
        pass

func("first")
func("first", name="John")
func("first", name="John", age=18)
```

## 参考

* [Function arguments](http://docs.python-guide.org/en/latest/writing/style/#function-arguments)
