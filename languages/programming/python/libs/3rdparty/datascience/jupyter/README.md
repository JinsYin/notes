# Jupyter

## 组件

## Jupyter Notebook

Jupyter Notebook 原名 IPython Notebook，它是一个交互式计算环境，可以在其中组合代码执行，如富文本，数学，图表。

## Jupyter 与 IPython

* 相同点

使用同一个 kernel

* 不同点

## 快速入门

```sh
% jupyter notebook
```

## Jupyter 的 Python 版本问题

Jupyter Notebook 中使用的 Python 版本和它启动时所处环境的 Python 版本一致。

* 验证 Python 版本

```sh
# 查看当前环境所使用的 Python 版本
$ python --version
Python 3.6.4 :: Anaconda custom (64-bit)

# 在 Jupyter Notebook 中执行代码验证 Python 版本
$ jupyter notebook
import sys
print(sys.version)
```

* 改变 Python 版本

如果希望改变 Jupyter Notebook 中 Python 的版本，可以使用 conda 切换虚拟环境并重启 Jupyter Notebook。

```sh
# 切换虚拟环境（假设之前已经创建好）
$ source activate python3.5

# 需要重启
$ jupyter notebook
```

## 参考

* <https://zhidao.baidu.com/question/1242805645188455019.html>
