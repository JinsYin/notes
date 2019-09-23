# Pythonic

## The Zen of Python

```python
$ python3 -c "import this"
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

## str `in`

`in` 除了可以判断元素是否在列表中以外，还可以判断字符串之间是否存在包含关系。

```python
# Non-Pythonic
def contain(x, y):
    import re
    return True if re.search(x, y) else False

# Pythonic
def contain(x, y):
    return x in y
```

## 直接赋值、浅拷贝和深拷贝

| Name     | 示例                 | 描述                                                                            |
| -------- | -------------------- | ------------------------------------------------------------------------------- |
| 赋值引用 | b = a                | 即对象的引用；a 和 b 指向同一个对象                                             |
| 浅拷贝   | b = a.copy()         | 只拷贝父对象不拷贝子对象；a 和 b 是两个相对独立的对象，他们的子对象指向同一对象 |
| 深拷贝   | b = copy.deepcopy(a) | 完全拷贝父对象及其子对象；a 和 b 是两个完全独立的对象                           |

* 赋值引用

![赋值引用](.images/pythonic/reference.png)

* 浅拷贝

![浅拷贝](.images/pythonic/copy.png)

* 深拷贝

![深拷贝](.images/pythonic/deepcopy.png)

## 获取列表、元组、字符串中的最后一个元素

```python
a_list = [1, 2, 3, 4]
a_tuple = ("a", 1, "b", 2)
a_string = "abc"
```

```python
# Non-Pythonic
a_list[len(a_list) - 1]     # 4
a_tuple[len(a_tuple) - 1]   # 2
a_string[len(a_string) - 1] # 'c'
```

```python
# Pythonic
a_list[-1]   # 4
a_tuple[-1]  # 2
a_string[-1] # 'c'
```

## 交换两个变量的值（Swap）

```python
# Non-Pythonic
temp = a
a  = b
b = temp
```

```python
# Pythonic
a, b = b, a
```

## Packing/Unpacking

### packing

```python
def func(*args):
    print(type(args), len(args))

func(1)         # <class 'tuple'> 1
func(1, 2)      # <class 'tuple'> 2
func(1, 2, 3)   # <class 'tuple'> 3
```

```python
def func(**kwargs):
    for key in kwargs:
        print("key: %s, value: %s" % (key, kwargs[key]))

func(x=1, y=2)
```

### Unpacking

```python
def func(a, b, c, d):
    pass

lst = [1, 2, 3, 4]

# TypeError: fun() takes exactly 4 arguments (1 given)
func(lst)

# Unpacking list into four arguments
func(*lst)
```

```python
def func(a=None, b=None, c=None, d=None)
    pass

dic = {"a": 1, "b": 2, "c": 3, "d": 4}

# TypeError: fun() takes exactly 4 arguments (1 given)
func(dic)

func(**dic)
```

## 列表推导式（List Comprehensions）

```markdown
new_list = [expression(i) for i in old_list if conditional(i)]
```

```python
# Non-Pythonic
new_list = []
for x in range(1, 101):
    if x % 2 == 0:
        new_list.append(x)
```

```python
# Pythonic
new_list = [x for x in range(1, 101) if x % 2 == 0]

import random
new_dict = {i: random.randint(0, 10) for i in range(10, -1, -1)}
```

## 三元符

```python
# Non-Pythonic
x = 0

if x != 0:
    b = True
else:
    b = False

print(b) # False
```

```python
# Pythonic
x = 1
b = True if x != 0 else False
print(b) # True
```

## 链式比较

```python
# Non-Pythonic
a = 10
b = 20
print(a >= 1 and a <= b and b <= 100) # True
```

```python
# Pythonic
a, b = 10, 20
print(1 <= a <= b <= 100) # True
```

## 真值判断

```python
a = 123
b = ["rbd", "radosgw", "cephfs"]
c = {"name": "John", age: 18}

# Non-Pythonic
if a != 0 and len(b) != 0 and c != {}:
    print("All True")
```

```python
# Pythonic
if a and b and c:
    print("All True")
```

> <https://docs.python.org/release/2.5.2/lib/truth.html>

## Create a length-N string/list/tuple of the same thing

```python
# Pythonic
string = string * 10
lst = [None] * 10
tuple = (None) * 10
```

## 字符串索引/截取

```python
string = "Hello"

# Non-Pythonic
string_arr = list(string) # ['H', 'e', 'l', 'l', 'o']
print(string_arr[0], string_arr[4]) # H o
```

```python
# Pythonic
print(string[0], string[4]) # H o
print(string[0:3]) # Hel
```

## 连接字符串列表

```python
str_list = ["a", "b", "c"]

# Non-Pythonic
result = "-"
for i, s in enumerate(str_list):
    if i != len(str_list) - 1:
        result = s + result
```

```python
# Pythonic
result1 = "-".join(str_list) # a-b-c
result2 = " ".join(str_list) # a b c
result3 = "".join(str_list)  # abc
```

## 字符串反转

```python
string = "This is a tree."

# Option 1: Non-Pythonic
def reverse_str(s):
    """
    string = ""
    s_len = len(s)
    for i in range(s_len):
        string += s[s_len - 1 - i]
    return string
    """
    string = ""
    for i in range(len(s) - 1, -1, -1):
        string += s[i]
    return string

# Option 2: Non-Pythonic
def reverse_str(s):
    return "".join([s[i] for i in range(len(s) - 1, -1, -1)])

# Option 3: Non-Pythonic
def reverse_str(s):
    string = ""
    for x in list(s):
        string = x + string
    return string
```

```python
# Pythonic
def reverse_str(s):
    return s[::-1]
```

## 参考

* [让你的 Python 代码更加 pythonic](http://wuzhiwei.net/be_pythonic/)
* [Python Code Style](http://docs.python-guide.org/en/latest/writing/style/)
