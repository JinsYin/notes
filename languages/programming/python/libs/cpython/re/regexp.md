# 正则

## 正则方法

| 方法                                  | 描述                                                                                                                                                                       |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| re.match(pattern, string[, flags])    | 从首字母开始匹配，如果 string 包含 pattern 子串则返回 `Match` 对象，否则返回 `None`；若要完全匹配，pattern 要以 `$` 结尾                                                   |
| re.search(pattern, string[, flags])   | 若 string 中包含 pattern 子串，则返回 `Match` 对象，否则返回 `None`；如果 string 中存在多个 pattern 子串，只返回第一个                                                     |
| re.findall(pattern, string[, flags])  | 若 pattern 中没有 group，则以字符串数组形式返回 string 中与 pattern 相匹配的所有子串；若有 group，则返回所有 group 组成的元组（相当于 Match 对象的 `groups()` 方法）的数组 |
| re.finditer(pattern, string[, flags]) | 若 pattern 中没有 group，则以 `Match` 对象的迭代器形式返回 string 中与 pattern 相匹配的所有子串                                                                            |

## Match 对象相关的属性和方法

| 方法             | 描述                                                                                                                                                       |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| group()/group(0) | 返回 pattern 从母串中匹配到的子串（其实并未涉及 group）                                                                                                    |
| group(i)         | 从 pattern 匹配到的子串中，返回 pattern 中 `第 i 个 group`（即第 i 个括号） 匹配成功的子串（条件：先是 pattern 匹配成功，然后是 pattern 中必须存在 group） |
| groups()         | 返回 `所有 group`（即所有括号） 组成的元组（不包括第 0 个 group；满足的条件同上）                                                                          |
| string           | 返回母串                                                                                                                                                   |

```python
$ python
>>> import re
>>>
>>> p1 = r'(\d*)([a-zA-Z]*)'
>>> p2 = r'(\d+)'
>>> s = '123abc456def'
>>>
>>> m1 = re.match(p1, s)
>>> m1.string   # '123abc456def'
>>> m1.group() == m.group(0) # True
>>> m1.group()  # '123abc'
>>> m1.group(0) # '123abc'
>>> m1.group(1) # '123'
>>> m1.group(2) # 'abc'
>>> m1.groups() # ('123', 'abc')
>>>
>>> m2 = re.findall(p1, s)
>>> m2 # [('123', 'abc'), ('456', 'def'), ('', '')] --> 存在第三个的原因是用的 * 而不是 +
>>>
>>> m3 = re.findall(p2, s)
>>> m3 # ['123', 'abc']
```

## 参考

* [Python 中 re 的 match、search、findall、finditer 区别](https://blog.csdn.net/djskl/article/details/44357389)