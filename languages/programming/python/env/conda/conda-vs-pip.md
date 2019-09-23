# Conda 与 PIP

PIP 是依附于 Python 环境而存在的，每个 Python 环境都对应一个 PIP 工具，所以是先有 Python 而后有 PIP，因此 PIP 无法管理 Python 版本。

Conda 创建 Python 虚拟环境后（Python 自带 PIP），可以使用 `pip` 或 `conda` 两种方式来安装 Python 包：

* 如果使用 `pip`
  * _base_ 环境安装的包位于 `${ANACONDA_HOME}/lib/<python_version>/site-packages/` 目录
  * 其他虚拟环境安装的包位于 `${ANACONDA_HOME}/envs/<virtualenv_name>/lib/<python_version>/site-packages/` 目录
* 如果使用 `conda`
  * 所有安装的包均位于 `${ANACONDA_HOME}/pkgs/` 目录，每个包可能存在多个版本，每个虚拟环境引用相应版本的包。

当使用 `conda` 和 `pip` 安装同一包时，
