# Series

Series 表示一个带有 `索引` 和 `类型` 的序列，可以是 DataFrame 中的某一行或某一列，具体是行序列还是列序列取决于序列的索引是 `行索引` 还是 `列索引`。

```python
"""Series"""
In [0]: pd.Series([1, 11, 111])
Out[0]:
0      1
1     11
2    111
dtype: int64
```