# Conda

Conda 是一个开源的 `包管理` 系统和 `环境管理` 系统。

Conda 的设计理念是把几乎所有的工具、第三方包都当作 package 对待，甚至包括 python 和 conda 自身。因此，conda 打破了包管理与环境管理的约束，能够方便地安装多个版本的 python 以及各种第三方包，并在它们之间轻松切换。

Conda 使用了一个新的包格式，所以不能和 pip 交替使用。因为 pip 不能安装和解析 conda 的包格式。


## Conda? Miniconda? Anaconda?

`Conda` is a part of the `Anaconda` distribution. You can also download a minimal installation that only includes conda and its dependencies, called `Miniconda`.


## 安装 Anaconda

Anaconda 是一个用于科学计算的 Python 发行版，包含了众多流行的科学计算、数据分析的 Python 包。


## 安装 miniconda

Miniconda 是一个 Anaconda 的轻量级替代，默认只包含了 python 和 conda，但是可以通过 pip 和 conda 来安装所需要的包。


## Conda 环境管理


## Conda 包管理

```bash
# 安装
$ conda install xxx

# 卸载
$ conda uninstall xxx

# 升级
$ conda update xxx # pip install --upgrade xxx
```


## 参考

* [conda/conda](https://github.com/conda/conda)
* [Anaconda 镜像使用帮助](https://mirror.tuna.tsinghua.edu.cn/help/anaconda/)
* [](https://zhuanlan.zhihu.com/p/22678445)