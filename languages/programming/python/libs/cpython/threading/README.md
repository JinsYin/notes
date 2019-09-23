# threading 模块 - 基于线程的并发

## 模块函数、常量

## Thread 类

```python
class threading.Thread(group=None, target=None, name=None, args=(), kwargs={}, *, daemon=None)
```

必需的关键字参数：

* **group** -
* **target** -
* **name** -
* **args** -
* **kwargs** -

方法：

| 类属性和方法       | 描述 |
| ------------------ | ---- |
| start()            |      |
| run()              |      |
| join(timeout=None) |      |
| name               |      |
| getName()          |      |
| setName()          |      |
| ident              |      |
| is_alive()         |      |
| daemon             |      |
| isDaemon()         |      |
| setDaemon()        |      |

## Lock 类

```python
class threading.Lock
```

* **acquire(blocking=True, timeout=-1)**
* **release()**

## 递归锁对象

## 条件对象

## 信号量对象
