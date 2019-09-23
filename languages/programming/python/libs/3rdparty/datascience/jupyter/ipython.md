# IPython

## 补全

IPython 提供了 `Tab` 补全功能：

* 补全命名空间所存在的对象（变量、函数、关键字、文件路径等）
* 补全任何对象、模块的属性和方法

```python
$ ipython
In [1]: an_apple = 100

In [2]: an_orange = 200

In [3]: an<Tab>
           an_apple   anaconda3/
           an_orange  and
           any()
```

```python
$ ipython
In [1]: b = [1, 2,3]

In [2]: b.<Tab>
            append()  count()   insert()  reverse()
            clear()   extend()  pop()     sort()
            copy()    index()   remove()
```

```python
$ ipython
In [1]: import datetime

In [2]: datetime.<Tab>
                  date()        MAXYEAR       timedelta
                  datetime      MINYEAR       timezone
                  datetime_CAPI time()        tzinfo()
```

> IPython 默认会隐藏下划线开头的属性和方法，除非手动键入了一个下划线

## 自省

* 变量前后使用问号 `?`，可以显示对象的信息
* 变量前后使用两个问号 `??`，可以显示函数的源码

```python
$ ipython
In [1]: b = [1, 2, 3]

In [2]: def sum(x, y):
    ...:     "求和"
    ...:     return x + y

In [3]: b?
Type:        list
String form: [1, 2, 3]
Length:      3
Docstring:
list() -> new empty list
list(iterable) -> new list initialized from iterable's items

In [4]: sum?
Signature: sum(x, y)
Docstring: 求和
File:      ~/<ipython-input-21-de909ca1a346>
Type:      function

In [5]: sum??
Signature: sum(x, y)
Source:
def sum(x, y):
    "求和"
    return x + y
File:      ~/<ipython-input-21-de909ca1a346>
Type:      function
```
