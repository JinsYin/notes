# signal

| 编号 | 名称    | 描述 |
| ---- | ------- | ---- |
| 1    | SIGHUP  |      |
| 2    | SIGINT  |      |
| 3    | SIGQUIT |      |
| 9    | SIGKILL |      |
| 14   | SIGALRM |      |
| 15   | SIGTERM |      |

```sh
# 参考 Linux 手册页
$ man 7 signal

$ kill -l
```

> signal.signal() 不能捕捉 SIGKILL 信号，否则会报 "[Errno 22] Invalid argument"

## 示例

```python
"""
尝试按下 CTRL + C（即发送 Interrupt 信号），看看会发生什么

* KeyboardInterrupt 并未被捕获到
* signal 的优先级应该是最高的，当接收到中断信号是（`sig == 2`），导致执行 `sys.exit(0)`，程序捕获到 SystemExit 异常
"""
import sys, time, signal

def test(g):
    print("start")

    for i in range(1, 30):
        g = g + i
        print(g)
        time.sleep(3)

    print("end")

def handle_signal(sig, frame):
    print("signal: {}, g: {}".format(sig, g))
    if sig == 2:
        sys.exit(0)

if __name__ == '__main__':

    g = 100

    signal.signal(1, handle_signal)
    signal.signal(2, handle_signal)

    try:
        test(g)
    except KeyboardInterrupt:
        print("键盘中断")
    except Exception as e:
        print("Exception 异常: {}".format(e))
    except SystemExit as exitno:
        print("SystemExit 异常: {}".format(exitno))

    # 这个位置几乎不可能接收得到信号
    #signal.signal(1, handle_signal)
    #signal.signal(2, handle_signal)
```

```python
"""x.py
* 尝试按下 CTRL + C（即发送 Interrupt 信号），看看会发生什么
* Linux 发送信号: kill -15 $(ps -ef | grep "python x.py" | head -n 1 | awk '{print $2}')
"""
import sys, time, signal

def test(g):
    print("start")

    for i in range(1, 20):
        g = g + i
        print(g)
        time.sleep(3)
        signal.signal(1, handle_signal)
        signal.signal(2, handle_signal)
        signal.signal(3, handle_signal)
        signal.signal(15, handle_signal)

    print("end")


def handle_signal(sig, frame):
    print("signal: {}, frame.f_globals: {}, frame.f_locals: {}，g: {}"\
        .format(sig, frame.f_globals, frame.f_locals, frame.f_locals['g']))
    if sig == 15:
        sys.exit(0)

if __name__ == '__main__':

    g = 100

    try:
        test(g)
    except KeyboardInterrupt:
        print("键盘中断")
    except Exception as e:
        print("Exception: {}".format(e))
    except SystemExit as exitno:
        print("SystemExit: {}".format(exitno))

    # 这个位置几乎不可能接收得到信号
    # signal.signal(1, handle_signal)
    # signal.signal(2, handle_signal)
```

```python
import code, traceback, signal

def debug(sig, frame):
    """Interrupt running process, and provide a python prompt for
    interactive debugging."""
    d={'_frame':frame}         # Allow access to frame object.
    d.update(frame.f_globals)  # Unless shadowed by global
    d.update(frame.f_locals)

    i = code.InteractiveConsole(d)
    message  = "Signal received : entering python shell.\nTraceback:\n"
    message += ''.join(traceback.format_stack(frame))
    i.interact(message)

def listen():
    signal.signal(signal.SIGUSR1, debug)  # Register handler
```
