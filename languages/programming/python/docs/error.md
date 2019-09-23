# Error

## finally 始终被执行

```python
# 始终返回 3
try:
    return 1
except:
    return 2
finally:
    return 3
```

## 捕获所有异常

```python
try:
    do_something()
except:
    print("Caught all exceptions")
```

```python
try:
    f = open('myfile.txt')
    s = f.readline()
    i = int(s.strip())
except IOError as (errno, strerror):
    print "I/O error({0}): {1}".format(errno, strerror)
except ValueError:
    print "Could not convert data to an integer."
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise
```

没有捕获到的异常自动被抛出

## 解释器可以捕获的异常

* NameError

```python
>>> str(x)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'f' is not defined
```
