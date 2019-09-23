# PyInstaller

PyInstaller 可以将 Python 程序及其依赖打包成一个可执行文件，用户运行程序时不需要安装 Python 解释器或模块。PyInstaller 可以在 Windows、Mac OS X 和 Linux 上运行，但不能跨平台运行：为了制作 Windows App 必须在 Windows 上运行 PyInstaller；为了制作 Linux App 必须在 Linux 上运行 PyInstaller。

## 参数

| 参数 | 含义                                                            |
| ---- | --------------------------------------------------------------- |
| -F   | -onefile 指定打包后只生成一个exe格式的文件                      |
| -D   | -onedir 创建一个目录，包含exe文件，但会依赖很多文件（默认选项） |
| -c   | –console, –nowindowed 使用控制台，无界面(默认)                  |
| -w   | –windowed, –noconsole 使用窗口，无控制台                        |
| -p   | 添加搜索路径，让其找到对应的库。                                |
| -i   | 改变生成程序的icon图标                                          |

## Windows

Windows XP 以上（含）

### 依赖模块

* PyWin32/pypiwin32 二选一；pip/easy_instsall 安装 PyInstaller 会自动安装 pypiwin32
* pefile 必需
* pip-Win 推荐，非必需

## Mac OS X

Mac OS X 10.7 以上（含）

## Linux

### 安装

```sh
% pip install -U pyinstaller
```

## 示例

```sh
# 如果使用 anaconda，需要指定动态链接库
$ echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/anaconda3/lib' >> ~/.bashrc
$ source ~/.bashrc


# 打包
$ pyinstaller -F wx_detection.py

$ trre
.
├── build
│   └── wx_detection
│       ├── Analysis-00.toc
│       ├── base_library.zip
│       ├── EXE-00.toc
│       ├── PKG-00.pkg
│       ├── PKG-00.toc
│       ├── PYZ-00.pyz
│       ├── PYZ-00.toc
│       ├── warn-wx_detection.txt
│       └── xref-wx_detection.html
├── dist
│   └── wx_detection
├── __pycache__
│   └── wx_detection.cpython-36.pyc
├── wx_detection.py
└── wx_detection.spec
```
