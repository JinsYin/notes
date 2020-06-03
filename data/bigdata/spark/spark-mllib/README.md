# Spark MLlib

As of Spark 2.0, the RDD-based APIs in the `spark.mllib` package have entered maintenance mode. The primary Machine Learning API for Spark is now the DataFrame-based API in the `spark.ml` package.

Why is MLlib switching to the DataFrame-based API?

DataFrames provide a more user-friendly API than RDDs. The many benefits of DataFrames include Spark Datasources, SQL/DataFrame queries, Tungsten and Catalyst optimizations, and uniform APIs across languages.
The DataFrame-based API for MLlib provides a uniform API across ML algorithms and across multiple languages.
DataFrames facilitate practical ML Pipelines, particularly feature transformations. See the Pipelines guide for details.

## Maven 依赖

```xml
<dependency>
  <groupId>org.apache.spark</groupId>
  <artifactId>spark-mllib_2.11</artifactId>
  <version>2.0.2</version>
</dependency>
```

> http://blog.csdn.net/bob601450868/article/category/6241965/3

## 参考

* [基于 Spark 自动扩展 scikit-learn (spark-sklearn)](http://blog.csdn.net/sunbow0/article/details/50848719)
* [Sparkit-learn](https://github.com/lensacom/sparkit-learn)
* [Scikit-learn integration package for Apache Spark](https://github.com/databricks/spark-sklearn)
