# 聚类

## K-means

K-means 算也是一个迭代式的算法，其主要步骤如下:
  * 第一步，选择 K 个点作为初始聚类中心。
  * 第二步，计算其余所有点到聚类中心的距离，并把每个点划分到离它最近的聚类中心所在的聚类中去。在这里，衡量距离一般有多个函数可以选择，最常用的是欧几里得距离 (Euclidean Distance), 也叫欧式距离。公式如下：

聚好的类也称为 `簇` （cu）,聚类中心也称为 `质心`。

* 优点：

  * 时间复杂度近于线性，而且适合挖掘大规模数据集。K-Means 聚类算法的时间复杂度是 `O(nkt)`，其中 n 代表数据集中对象的数量，t 代表着算法迭代的次数，k 代表着簇的数目。


## K-means++




## Latent Dirichlet allocation (LDA) 


## Bisecting k-means（二分k均值算法） 


## Gaussian Mixture Model (GMM)

p(x)=∑Ki=1wi⋅p(x|μi,Σi)p(x)=∑i=1Kwi⋅p(x|μi,Σi)



## 参考

* [使用 Spark MLlib 做 K-means 聚类分析](https://www.ibm.com/developerworks/cn/opensource/os-cn-spark-practice4/)
