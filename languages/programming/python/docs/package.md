# 包和模块

## isort - import 排序

### 安装

```sh
pip install isort
```

### 示例

* example.py

```python
from my_lib import Object

print("Hey")

import os

from my_lib import Object3

from my_lib import Object2

import sys

from third_party import lib15, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9, lib10, lib11, lib12, lib13, lib14

import sys

from __future__ import absolute_import

from third_party import lib3

print("yo")
```

```sh
# 排序并修改文件
$ isort example.py

# 打印排序前后的区别，但不修改文件
$ isort --diff example.py

# 递归当前目录下的所有文件
$ isort -rc .
```

## 参考

* [Modules and Packages](https://www.learnpython.org/en/Modules_and_Packages)
