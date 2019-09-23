# Pandas

Pandas 是一种列存数据结构分析 API。

## 安装

```sh
# Conda
$ conda install pandas

# PyPI
$ python3 -m pip install --upgrade pandas
```

## 基本概念

### 主要数据结构

* **DataFrame** - 相当于一个关系型数据表格，包含多个行和已命名的列
* **Series** - 指单一列。DataFrame 中包含一个或多个 Series，每个 Series 均有一个名称

```python
import pandas as pd

# 创建 Series
city_names = pd.Series(['San Francisco', 'San Jose', 'Sacramento'])
population = pd.Series([852469, 1015785, 485199])

# 创建 DataFrame（若长度不一致，系统会用特殊的 NA/NAN 值填充缺失的值）
pd.DataFrame({'City Name': city_names, 'Population': population})

# 从 csv 文件中创建 DataFrame
california_housing_dataframe = pd.read_csv("https://storage.googleapis.com/mledu-datasets/california_housing_train.csv", sep=",")
california_housing_dataframe.describe() # 显示关于 DataFrame 的统计信息
california_housing_dataframe.head() # 前 5 个记录
california_housing_dataframe.hist('housing_median_age') # 绘制图标：了解值的分布
```

### 访问数据

```python
# Pandas 自动创建一个从 0 开始的索引列
cities = pd.DataFrame({'City name': city_names, 'Population': population})

# 选择一列作为索引列（要求被索引列是数字列）

# RangeIndex(start=0, stop=3, step=1)
print(cities.index)
for i in cities.index:
    print(i)

# <class 'pandas.core.series.Series'>
print(type(cities['City name']))
print(type(cities.loc[0]))

# <class 'pandas.core.frame.DataFrame'>
print(type(cities[['City name']]))
print(type(cities.loc[[0]]))

"""
0    San Francisco
1         San Jose
2       Sacramento
Name: City name, dtype: object
"""
cities['City name']

cities['City name'][1] # San Jose

# <class 'pandas.core.frame.DataFrame'>
type(cities[0:2])

"""
       City name  Population
0  San Francisco      852469
1       San Jose     1015785
"""
print(cities[0:2])
```

```python
# 第 0（这里的 0 表示索引值） 行
print(citie.loc[0])

# 第一行
print(cities.iloc[])
```

### 操控数据

```python
import numpy as np

print(np.log(population))

"""
0    False
1     True
2    False
dtype: bool
"""
population.apply(lambda val: val > 1000000) # Series.apply
```

```python
# 添加两个 Series
cities['Area square miles'] = pd.Series([46.87, 176.53, 97.92])
cities['Population density'] = cities['Population'] / cities['Area square miles']
cities
```

## 参考

* [Pandas 简介](https://colab.research.google.com/notebooks/mlcc/intro_to_pandas.ipynb)
