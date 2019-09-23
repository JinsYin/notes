# Python 类型

## 基本类型

* 字符串（str）
* 布尔型（bool）
* 数字类型
  * 整型（int）
  * 浮点型（float）
  * 复数型
* 字节型（bytes）

```python
string1 = "abc"
string2 = "123"
bool_t
int_num = 10
float_num = 1.1
```

```python
import pickle

dic = {"x": 1, "y": 2}
dic_bytes = pickle.dump(dic)

# b'\x80\x03}q\x00(X\x01\x00\x00\x00xq\x01K\x01X\x01\x00\x00\x00yq\x02K\x02u.' <class 'bytes'>
print(dic_bytes, type(dic_bytes))
```

## 类型转换

* str -> int/float

```python
int_string = "123"
float_string = "12.3"

int_num = int(int_string)
float_num = float(float_string)

print(type(int_num))
print(type(float_num))
```

* int/float -> str

```python
print(str(10))
print(str(1.1))
```

* str & bytes

> <http://blog.csdn.net/yatere/article/details/6606316>

## 字典

```python
dic1 = {'x': 1, 'y': 2}

dic2 = dict('x'=1, 'y'=2)
```
