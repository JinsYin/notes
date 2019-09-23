# ML Pipeline

## 概念

* DataFrame

spark.ml 采用 DataFrame，目的是支持各种各样的数据类型，如向量、文本、图像和结构化数据。

* Transformer

`Transformer` 是一个算法，可以转换一个 DataFrame 为另一个 DataFrame。

* Estimator

`Estimator` 是一个算法，适合在 DataFrame 上生产 Transformer。

* Pipeline

`Pipeline` 链接多个 Transformer 和 Estimator 一起指定一个 ML workfow。

* Parameter

通过指定参数，所有的 Tranformer 和 Estimator 可以共享通用的 API。
