# DataFrame

```python
"""通过 Numpy 矩阵来创建（index 表示行索引，columns 表示列索引；默认都是 0,1,2...）"""
df = pd.DataFrame(np.random.randn(3, 4), index=["first", "second", "third"], columns=["A", "B", "C", "D"])
               A         B         C         D
first   0.145080  2.327880  2.438661 -0.711243
second  0.571412  2.128671 -0.408173 -0.590900
third  -0.244856  0.439020 -0.615668 -0.716571

In [1]: df.index
Out[1]: Index(['first', 'second', 'third'], dtype='object')

In [1]: df.columns
Out[1]: Index(['A', 'B', 'C', 'D'], dtype='object')

In [1]: df.values
Out[1]: array([[ 0.64668682, -0.14841632, -1.34530025,  0.08527738],
       [-0.21310112,  0.39656944,  2.24461051, -1.38311954],
       [ 1.0796878 , -1.56491769,  1.10024435,  0.10764682]])

In []: df.describe()
Out[]:               A         B         C         D
count  3.000000  3.000000  3.000000  3.000000
mean   0.504425 -0.438922  0.666518 -0.396732
std    0.658031  1.012498  1.833836  0.854310
min   -0.213101 -1.564918 -1.345300 -1.383120
25%    0.216793 -0.856667 -0.122528 -0.648921
50%    0.646687 -0.148416  1.100244  0.085277
75%    0.863187  0.124077  1.672427  0.096462
max    1.079688  0.396569  2.244611  0.107647

In []: df.T # transpose
Out[]:
      first    second     third
A  0.646687 -0.213101  1.079688
B -0.148416  0.396569 -1.564918
C -1.345300  2.244611  1.100244
D  0.085277 -1.383120  0.107647
```

```python
"""通过 Python 字典来创建"""
In [1]: pd.DataFrame({"A": [1, 11, 111], "B": [2, 22, 222], "C": [3, 33, 333]})
Out[1]:
     A    B    C
0    1    2    3
1   11   22   33
2  111  222  333
```

* 选择数据

```python
dates = pd.date_range('20120101', periods=6)
df = pd.DataFrame(np.arange(24).reshape(6, 4), index=dates, columns=["A", "B", "C", "D"])

"""
             A   B   C   D
2012-01-01   0   1   2   3
2012-01-02   4   5   6   7
2012-01-03   8   9  10  11
2012-01-04  12  13  14  15
2012-01-05  16  17  18  19
2012-01-06  20  21  22  23
"""
print(df)

"""选取某一列（结果是 Series）"""
print(df["A"])
2012-01-01     0
2012-01-02     4
2012-01-03     8
2012-01-04    12
2012-01-05    16
2012-01-06    20
Freq: D, Name: A, dtype: int64

"""选取某一列并重新组成 DataFrame（结果是 DataFrame"""
print(df[["A"]])

In []: type(df.A)
Out[]: pandas.core.series.Series

In []: type(df[["A"]])
Out[]: pandas.core.frame.DataFrame

"""选择行（结果是 DataFrame）"""
df[0:2] # 选择 [0, 2) 行
df['20120101', '20120103']
```