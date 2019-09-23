# Python 快速入门

## 命令行交互

```sh
root@node:~$ python
Python 3.5.3 (default, Aug 22 2017, 20:36:50)
[GCC 4.8.4] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
>>> 100 + 200
300
>>>
>>> exit() # CTRL + D
```

## Hello Wold

### 编写 hello_world.py

```python
#!/usr/bin/env python3
import sys

print("Hello, World")
print("Python Version: %s" % sys.version_info[0])
```

> 设置运行时环境时，通常不直接指定 python 的执行路径，因为各个系统的路径可能不同

### 执行 Python 代码

```sh
# 方式一：运行时环境由当前解释器决定，即 python2
$ python2 hello_world.py
Hello, World
Python Version: 2
```

```sh
# 方式二：运行时环境由 "#!/usr/bin/env python3" 决定
$ chmod +x hello_world.py && ./hello_world.py
Hello, World
Python Version: 3
```

### Encoding

Python 3 源码文件默认使用 `UTF-8` 编码，但有些编辑器可能默认不是 `UTF-8` 编码。有三种方式可以修改编码：

```python
# coding: utf-8
```

```python
# coding=utf-8
```

```python
# -*- coding: utf-8 -*-
```
