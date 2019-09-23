# 序列化

* `json` 模块：序列化为 json 字符串
* `pickle` 模块：序列化为二进制数据
* `shelve` 模块：

## json 模块

### 序列化为字符串

```python
import json

dic = {"x": 1, "y": 2}

dic_str = json.dumps(dic)        # 序列化
dic_origin = json.loads(dic_str) # 反序列化

print(dic_str, type(dic_str))       # {"x": 1, "y": 2} <class 'str'>
print(dic_origin, type(dic_origin)) # {'x': 1, 'y': 2} <class 'dict'>
```

### 存储为 json 文件

```python
import json

dic = {"x": 1, "y": 2}

# 序列化
with open('dic.json', 'w', encoding='utf-8') as f:
    json.dump(dic, f)

# 反序列化
with open('dic.json', 'r', encoding='utf-8') as f:
    dic = json.load(f)
    print(dic, type(dic)) # {'x': 1, 'y': 2} <class 'dict'>
```

### 存储到自定义对象

```python
import json

me
```

## pickle 模块

### 序列化到变量

```python
import pickle

dic = {"x": 1, "y": 2}

dic_bytes = pickle.dumps(dic)        # 序列化
dic_origin = pickle.loads(dic_bytes) # 反序列化

print(dic_bytes, type(dic_bytes))   # b'\x80\x03}q\x00(X\x01\x00\x00\x00xq\x01K\x01X\x01\x00\x00\x00yq\x02K\x02u.' <class 'bytes'>
print(dic_origin, type(dic_origin)) # {'x': 1, 'y': 2} <class 'dict'>
```

### 序列化到文件

```python
import pickle

# 序列化
with open('dic.pk', 'wb') as f:
    dic = {"x": 1, "y": 2}
    pickle.dump(dic, f)
    f.close()

# 反序列化
with open('dic.pk', 'rb') as f:
    dic = pickle.load(f)
    print(dic, type(dic))
    f.close()
```
