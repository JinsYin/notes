# 模块

Python 3 的入口模块是 `builtins`，Python 2 对应的是 `__builtin__` 模块。它包含常见的 `print()`、`abs()` 方法，`+`、`-` 等等操作符

## 内置模块

查看当前解释器默认导入了哪些模块：

```python
>>> impoort sys
>>> sys.modules.keys()
dict_keys(['builtins', 'sys', '_frozen_importlib', '_imp', '_warnings', '_thread', '_weakref', '_frozen_importlib_external', '_io', 'marshal', 'posix', 'zipimport', 'encodings', 'codecs', '_codecs', 'encodings.aliases', 'encodings.utf_8', '_signal', '__main__', 'encodings.latin_1', 'io', 'abc', '_weakrefset', 'site', 'os', 'errno', 'stat', '_stat', 'posixpath', 'genericpath', 'os.path', '_collections_abc', '_sitebuiltins', 'sysconfig', '_sysconfigdata_m_linux_x86_64-linux-gnu', '_bootlocale', '_locale', 'types', 'functools', '_functools', 'collections', 'operator', '_operator', 'keyword', 'heapq', '_heapq', 'itertools', 'reprlib', '_collections', 'weakref', 'collections.abc', 'importlib', 'importlib._bootstrap', 'importlib._bootstrap_external', 'warnings', 'importlib.util', 'importlib.abc', 'importlib.machinery', 'contextlib', 'mpl_toolkits', 'google', 'sphinxcontrib', 'readline', 'atexit', 'rlcompleter', 're', 'enum', 'sre_compile', '_sre', 'sre_parse', 'sre_constants', 'copyreg'])
```

```python
>>> import builtins
>>> builtins.print('123')
```