# Numpy 快速入门

## 练习

* 导入模块并查看其版本

```python
import numpy as np

print(np.__version__)
#> 1.14.1
```

* 创建一个一维数组

```python
np.arange(10)
#> array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

* 创建一个 3 × 3 的所有值为 True 的 numpy 数组

```python
np.full((3, 3), True)
```
