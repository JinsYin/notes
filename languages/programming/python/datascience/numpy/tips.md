# 技巧

```plaintext
问题：A = np.array(1, 1, 2) 是行向量还是列向量？
答案：都可能是。
原因：用程序表示一维矩阵时没有办法像书写一样清楚直接。
```

```python
"""一维矩阵"""
In [1]: A = np.array(1, 1, 2)

"""矩阵 A 及其转置是相同的"""
In [2]: A
Out[2]: array([1, 1, 1])

In [3]: A.T
Out[3]: array([1, 1, 1])

"""矩阵 A 的形状及其转置的形状是相同的"""
In [4]: A.shape
Out[4]: (3,)

In [5]: A.T.shape
Out[5]: (3,)

"""将矩阵 A 转换成行向量"""
In [6]: A[np.newaxis, :]
Out[6]: array([[1, 1, 1]])

In [7]: A[np.newaxis, :].shape
Out[7]: (1, 3)

"""将矩阵 A 转换成列向量"""
In [8]: A[:,np.newaxis]
Out[9]: array(
       [[1],
        [1],
        [1]])

In [10]: A[:,np.newaxis].shape
Out[10]: (3, 1)
```

```python
A = np.array([1, 1, 1])
B = np.array([2, 2, 2])

"""纵向合并（vertical stack）"""
C = np.vstack((A, B))
array([[1, 1, 1],
       [2, 2, 2]])

""""横向合并（horizontal stack）"""
D = np.hstack((A, B))
array([1, 1, 1, 2, 2, 2])
```

```python
"""分割"""
A = np.arange(12).reshape((3, 4))
B = np.split(A, 3, axis=0) # 横向分割列，分成 3 行
C = np.split(A, 2, axis=1) # 纵向分割行，分成 2 列

D = np.vsplit(A, 3) # 纵向分割成 3 行
E = np.hsplit(A, 2) # 横向分割成 2 列

"""不等量的分割"""
F = np.array_split(A, 3, axis=1)
[array([[0, 1],
        [4, 5],
        [8, 9]]),
 array([[ 2],
        [ 6],
        [10]]),
 array([[ 3],
        [ 7],
        [11]])]

```

```python
"""引用复制"""
In [0]: A = np.arange(3)
   ...: B = A
   ...: C = A

In [1]: A is B is C
Out[1]: True

"""改变 A/B/C 后，其余的都会改变"""
In [2]: A[0] = 11
In [3]: B[1] = 22
In [4]: C[2] = 33

In [5]: A is B is C
Out[5]: True
```

```python
"""值复制"""
A = np.arange(3)
B = A.copy()
```