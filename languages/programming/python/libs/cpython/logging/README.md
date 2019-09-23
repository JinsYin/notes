# logging 模块

## 日志用途

* 程序调试
* 掌握程序运行情况
* 程序运行故障分析和问题定位

## 日志事件

一条日志对应一个事件的发生，一个事件通常包含以下几个内容：

* 事件发生时间
* 事件发生位置 -- 回溯 & 日志记录位置
* 事件严重程度 -- 日志级别
* 事件内容

## 日志级别（Level）

| Level ID / Level Value | Level Name | 描述                                                                                       |
| ---------------------- | ---------- | ------------------------------------------------------------------------------------------ |
| 10                     | DEBUG      | 最详细的日志信息，通常用于问题诊断                                                         |
| 20                     | INFO       | 详细程度次于 _DEBUG_，通常只记录关键信息，以确认是否按照预期在进行工作                     |
| 30                     | WARNING    | 当某些不期望的事情发生时记录的信息（如，磁盘可用空间较低），但是此时应用程序还是正常运行的 |
| 40                     | ERROR      | 由于一个更严重的问题导致某些功能不能正常运行时记录的信息                                   |
| 50                     | CRITICAL   | 当发生严重错误，导致应用程序不能继续运行时记录的信息                                       |

* 数值越大级别越高（即 `DEBUG < INFO < WARNING < ERROR < CRITICAL`），记录的日志信息越少
* 指定日志级别后，程序会记录所有 **大于或等于** 该日志级别的日志信息，而不是只记录当前级别的日志信息
* logging 模块提供的日志记录函数所使用的日志器默认设置的日志级别为 _WARNING_，所以默认情况下 _DEBUG_ 和 _INFO_ 都不会被记录
* 开发环境建议： DEBUG、 INFO
* 生产环境建议： WARNING、 ERROR、 CRITICAL

## 模块函数

| 日志配置函数                  | 描述                                                                               |
| ----------------------------- | ---------------------------------------------------------------------------------- |
| logging.basicConfig(**kwargs) | 对 rootLogger 进行一次性配置，常指定 “日志级别”、“日志格式”、“日志输出位置” 等信息 |

关键字参数:

* **filename** : 指定日志输出文件的文件名；设置后日志信息将不再输出到默认的 `sys.stderr`
* **filemode** : 指定日志输出文件的打开模式；默认是 `a`；指定 _filename_ 后才有效
* **format**   : 指定日志格式 -- 按格式字段排列组合形成的字符串
* **datefmt**  : 指定日期/时间格式；_format_ 选项包含 `%(asctime)s` 字段时才有效
* **level**    : 指定日志级别
* **stream**   : 指定日志输出目标流，如：`sys.stdout`、`sys.stderr` 或网络流；_stream_ 和 _filename_ 两个选项不能同时指定
* **style**    : Py3.2 新增。指定 _format_ 格式字符串的风格，可取值为 `%`、`{` 或 `$`，默认为 `%`
* **handlers** : Py3.3 新增。

| 日志记录函数                                           | 描述                                                           |
| ------------------------------------------------------ | -------------------------------------------------------------- |
| logging.debug(msg, *args, **kwargs)                    | 创建一条严重级别为 _DEBUG_ 的日志记录                          |
| logging.info(msg, *args, **kwargs)                     | 创建一条严重级别为 _INFO_ 的日志记录                           |
| logging.warning(msg, *args, **kwargs)                  | 创建一条严重级别为 _WARNING_ 的日志记录                        |
| logging.error(msg, *args, **kwargs)                    | 创建一条严重级别为 _ERROR_ 的日志记录                          |
| logging.exception(msg, *args, exc_info=True, **kwargs) | 创建一条严重级别为 _ERROR_ 的日志记录，并且打印异常堆栈信息    |
| logging.critical(msg, *args, **kwargs)                 | 创建一条严重级别为 _CRITICAL_ 的日志记录                       |
| logging.log(level, *args, **kwargs)                    | 创建一条严重级别为 level 的日志记录（有自定义 level 时更常用） |

关键字参数:

* **exc_info**   : 是否增加异常堆栈信息（仅出现异常时才有信息）；取值为布尔值，除 `logging_exception()` 函数外默认值均为 `False`
* **stack_info** : 是否增加堆栈信息（不论是否异常始终存在信息）；取值为布尔值，默认值均为 `False`
* **extra**      : 用于设置 `logging.basicConfig(...)` 中 _format_ 参数自定义字段的值；取值为字典，如：`extra={'ip': '12.34.56.78'}`

```python
import logging

logging.basicConfig(level=logging.DEBUG)

def log():
    try:
        1 / 0
    except BaseException as e:
        print(e)
        print('-----')
        logging.debug(e)
        print('-----')
        logging.info(e)
        print('-----')
        logging.info(e, stack_info=True)
        print('-----')
        logging.warning(e)
        print('-----')
        logging.error(e)
        print('-----')
        logging.exception(e)
        print('-----')
        logging.error(e, exc_info=True)
        print('-----')
        logging.critical(e)
```

> 注：引入的外部模块通常会指定 DEBUG 级别的日志记录，比如 urllib3

## 四大组件

| 组件   | 类名      | 功能 |
| ------ | --------- | ---- |
| 日志器 | Logger    |      |
| 处理器 | Handler   |      |
| 过滤器 | Filter    |      |
| 格式器 | Formatter |      |

## 日志格式

| 字段      | 格式            | 描述                                                 |
| --------- | --------------- | ---------------------------------------------------- |
| asctime   | `%(asctime)s`   | 日志事件发生的事件，形如：`2019-01-01 12:20:30,456`  |
| levelname | `%(levelname)s` | 日志级别，如：DEBUG、INFO、ERROR...                  |
| name      | `%(name)s`      | 日志器名称，默认是 `root`（因为使用的是 rootLogger） |
| message   | `%(message)s`   | 日志内容                                             |
| pathname  | `%(pathname)s`  | 调用的日志函数所在源文件的绝对路径                   |
| filename  | `%(filename)s`  | _pathname_ 的文件名部分，包含文件后缀                |
| module    | `%(module)s`    | _filename_ 的名称部分，不含文件后缀                  |
| lineno    | `%(lineno)d`    | 调用日志函数的源代码所在的行号                       |
| funcName  | `%(funcName)s`  | 调用日志函数的函数名                                 |

* 默认日志输出位置：`sys.stderr`
* 默认日志格式：`logging.BASIC_FORMAT = "%(levelname)s:%(name)s:%(message)s"`
* 如需修改日志格式，可以向 `logging.basicConfig(**kwargs)` 函数传递 `format` 参数

除此之外，还可以自定义字段（自定义后调用模块函数就必须为其赋值，否则会报 `KeyError: '...'`）：

```python
LOG_FORMAT = "%(asctime)s - %(levelname)s - %(user)s[%(ip)s] - %(message)s"
DATE_FORMAT = "%m/%d/%Y %H:%M:%S %p"

logging.basicConfig(format=LOG_FORMAT, datefmt=DATE_FORMAT)
logging.warning("Some one delete the log file.", exc_info=True, stack_info=True, extra={'user': 'Tom', 'ip':'47.98.53.222'})
```

## 范例

```python
import time
import logging

lg_level = logging.INFO
lg_filename = 'main.log.%s' % time.strftime("%Y%m%d")
lg_datefmt = '%Y-%m-%d %H:%M:%S'
lg_fmt = '%(asctime)s.%(msecs)03d - [%(levelname)s] - %(filename)s:%(lineno)d - %(message)s'

logging.basicConfig(level=lg_level,
                        filename=lg_filename,
                        format=lg_fmt,
                        datefmt=lg_datefmt)
```

## 参考

* [Python 之日志处理（logging 模块）](https://www.cnblogs.com/yyds/p/6901864.html)
* [python 之配置日志的几种方式](http://www.cnblogs.com/yyds/p/6885182.html)
* [Exceptional logging of exceptions in Python](https://www.loggly.com/blog/exceptional-logging-of-exceptions-in-python/)
