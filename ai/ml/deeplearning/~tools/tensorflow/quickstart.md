# TensorFlow 1.2.0

## 安装 TensorFlow



## 数据流图

* 两个基础组件

  * 节点（node）：通常用圆圈或椭圆表示，代表数据所做的运算或操作，即 `Operation`，简记为 `Op`；
  * 边（edge）：通常用箭头表示，代表 Operation 的输入输出值（n 维矩阵），即 `Tensor` 对象，译为张量；

* 依赖关系

  * 有向无环图；
  * 使用栈来存储节点之间的依赖关系；

* 定义数据流图

```python
import tensorflow as tf

# 定义两个输入节点（两个 Op），并自动将标量转换为了 Tensor 对象
a = tf.constant(5, name="input_a")
b = tf.constant(3, name="input_b")

# 1.0 之前是 tf.mul
c = tf.multiply(a, b, name="mul_a")
d = tf.add(a, b, name="add_d")

e = tf.add(c, d, name="add_e")
```

* 运行数据流图

```python
sess = tf.Session()
sess.run(e)
```

* 保存数据流图

```python
# 保存到 tf_graph 目录中
writer = tf.summary.FileWriter('./tf_graph', sess.graph)
```

* GC

```python
sess.close()
writer.close()
```


## TensorBoard

加载上面产生的数据流图：

```sh
$ tensorboard --logdir=./tf_graph
```

查看数据流图：`http://localhost:6006/#graphs`。


## Tensor 对象（张量）

张量，即 n 维矩阵的抽象，作为节点之间传递的数据。另外，TensorFlow Op 可以将标准的 Python 数据类型（数值、字符串、布尔值、列表等）自动转换为张量。

### Python 原生类型

* 0 阶张量（标量）

```python
# 0 阶张量（标量）
t_0 = 50

# 1 阶张量（向量）
t_1 = [b"apple", b"peach", b"grape"]

# 2 阶张量（矩阵）
t_2 = [
       [True, False, False],
       [False, True, False],
       [False, False, True]
      ]

# 3 阶张量
t_3 = [
       [[0, 0], [0, 1], [0, 2]],
       [[1, 0], [1, 1], [1, 2]],
       [[2, 0], [2, 1], [2, 2]]
      ]
```

示例：

```python
import tensorflow as tf

a = tf.constant([5, 3], name="input_a")
b = tf.reduce_prod(a, name="prod_b")
c = tf.sum(a, name="sum_c")
d = tf.add(b, c, name="add_d")
```

### Numpy 数组（推荐）

TensorFlow 的数据类型是基于 Numpy 的数据类型的。

TensorFlow 数据类型：

| 数据类型 （dtype） | 描述                                    |
| ------------------ | --------------------------------------- |
| tf.float32         | 32 位浮点数                             |
| tf.float64         | 64 位浮点数                             |
| tf.int8            | 8 位有符号整数                          |
| tf.int16           | 16 位有符号整数                         |
| tf.int32           | 32 位有符号整数                         |
| tf.int64           | 64 位有符号整数                         |
| tf.uint8           | 8 位无符号整数                          |
| tf.string          | 字符串（作为非 Unicode 编码的字符数组） |
| tf.bool            | 布尔型                                  |
| tf.complex64       | 复数，实部和虚部分别为 32 为浮点型      |
| tf.qint8           | 8 位有符号整数（用于量化 Op）           |
| tf.qint32          | 32 位有符号整数（用于量化 Op）          |
| tf.quint8          | 8 位无符号整数（用于量化 Op）           |


示例：

```python
import numpy as np

# 0 阶张量
t_0 = np.array(50, dtype=np.int32)

# 1 阶张量（不要显示指定 dtype 属性）
t_1 = np.array([b"apple", b"peach", b"grape"])

# 2 阶张量
t_2 = np.array([
       [True, False, False],
       [False, True, False],
       [False, False, True]
      ], dtype=np.bool)

# 3 阶张量
t_3 = np.array([
       [[0, 0], [0, 1], [0, 2]],
       [[1, 0], [1, 1], [1, 2]],
       [[2, 0], [2, 1], [2, 2]]
      ], dtype=np.int64)
```


## 学习教程

* 《面向机器智能的 TensorFlow 实践》
* [从机器学习到深度学习](https://classroom.udacity.com/courses/ud730)

* [](https://bitbucket.org/hrojas/learn-tensorflow)

* [](https://www.youtube.com/watch?v=KOic-GozMTo&list=PLjSwXXbVlK6IHzhLOMpwHHLjYmINRstrk&index=2)