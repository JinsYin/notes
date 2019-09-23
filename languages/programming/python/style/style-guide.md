# Python 规范

## 命名规范

```txt
module_name, package_name, ClassName, method_name, ExceptionName, function_name, GLOBAL_CONSTANT_NAME, global_var_name, instance_var_name, function_parameter_name, local_var_name
```

## YAPF formatter

### 安装

```sh
# 用 Python3 安装的 yapf，仅限格式化 Python3 的代码
$ pip install yapf
```

命令行参数：

* `-p`/`--parallel`: 格式化多个文件时使用多线程
* `-d`/`--diff`: 打印不同点
* `-i`/`--in-place`: 直接对原文件进行修改
* `-r`/`--recursive`: 对目录下的所有文件进行递归格式化
* `--style`: 指定格式化样式

### 格式化样式

搜索顺序：

1. 命令行（`--style='{based_on_style: chromium, indent_width: 4}'`）
2. 当前目录或父目录之一的 `.style.yapf` 的 `[style]` 部分
3. 当前目录或父目录之一的 `setup.cfg` 的 `[yapf]` 部分（导出配置：`yapf --style-help > style.cfg`）
4. Home 目录的 `~/.config/yapf/style` 文件

内置样式：

* pep8
* google
* chromium

### 示例

* example.py

```python
x = {  'a':37,'b':42,

'c':927}

y = 'hello ''world'
z = 'hello '+'world'
a = 'hello {}'.format('world')
class foo  (     object  ):
  def f    (self   ):
    return       37*-+2
  def g(self, x,y=42):
      return y
def f  (   a ) :
  return      37+-+a[42-x :  y**3]
```

* .style.yapf

```ini
[style]
based_on_style = google
spaces_before_comment = 4
split_before_logical_operator = true
```

* 格式化

```sh
# 格式化并打印，但不修改文件
$ yapf example.py

# 打印格式化前后区别
$ yapf --diff example.py

# 格式化并修改文件
$ yapf -i example.py

# 使用多线程对当前目录下的所有文件进行格式化并修改
$ yapf -p -i -r ./

# 通过命令行指定格式化样式
$ yapf --style='{based_on_style: chromium, indent_width: 4}' -p -i -r ./
```

## 参考

* [Google Python Style Guide](https://github.com/google/styleguide/blob/gh-pages/pyguide.md)
* [github.com/google/yapf](https://github.com/google/yapf/)
* [Python 命名规范](http://www.cnblogs.com/zhanglianbo/p/5664997.html)
* [Python 格式化工具 yapf 使用说明](https://www.jianshu.com/p/22d7a97720b7)
