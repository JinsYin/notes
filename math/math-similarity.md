# 相似度计算方法

假设两个点的坐标分别是:

(图)

a向量 = (a1, a2, a3, ... , an)
b向量 = (b1, b2, b3, ... , bn)

## 欧氏距离

欧式距离，也叫欧几里得距离（Euclidean Distance）。

![欧式距离](math-similarity-euclidean-distance.png)

## 平方欧氏距离

这种距离测度的值是欧氏距离的平方。

![平方欧式距离](math-similarity-euclidean-distance-square.png)

## 曼哈顿距离

两个点之间的距离是它们坐标差的绝对值。

![曼哈顿距离](math-similarity-manhattan-distance.png)

## 余弦距离

将点看作是原点指向它们的向量，向量之间形成一个夹角，当夹角较小时，这些向量都会指向大致相同方向，因此这些点非常接近，当夹角非常小时，这个夹角的余弦接近于1，而随着角度变大，余弦值递减。

![曼哈顿距离](math-similarity-cosine-distance.png)

> https://github.com/apache/spark/blob/master/examples/src/main/scala/org/apache/spark/examples/mllib/CosineSimilarity.scala
> https://www.zhihu.com/question/26055275

## 谷本距离

余弦距离测度忽略向量的长度，这适用于某些数据集，但是在其它情况下可能会导致糟糕的聚类结果，谷本距离表现点与点之间的夹角和相对距离信息。

![曼哈顿距离](math-similarity-valley-distance.png)

## 加权距离

允许对不同的维度加权从而提高或减小某些维度对距离测度值的影响。

## 参考

> https://my.oschina.net/dreamerliujack/blog/809387