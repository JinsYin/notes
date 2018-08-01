# Spark MLlib 入门

## 测试 MovieLensALS

ALS 是交替最小二乘 （alternating least squares）的简称。RMSE 是均方根误差（root-mean-square error），亦称标准误差。

```bash
$ bin/run-example mllib.MovieLensALS --rank 5 --numIterations 20 --lambda 1.0 --kryo data/mllib/sample_movielens_data.txt
Test RMSE = 1.4781785777316028
```