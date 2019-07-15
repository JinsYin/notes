# Ansible 内置模块之 YUM

## 简介

* 安装（`yum install`）、升级（`yum upgrade`）、降级（`yum downgrade`）、移除（`yum remove`）和列出（`yum list`）软件包
* 该模块仅适用于 Python 2 ，如果需要 Python 3 支持，参考 `dnf` 模块

## 参数

| 参数名 | 必需 | 默认值 | 可选值                                                               | 描述                                                                |
| ------ | ---- | ------ | -------------------------------------------------------------------- | ------------------------------------------------------------------- |
| name   | yes  |        |                                                                      | 软件包包名                                                          |
| state  | no   | preset | * preset <br> * installed <br> * latest <br> * absent <br> * removed | 安装（present、installed、latest）或 卸载（absent、 removed）软件包 |

## 用法

```bash
# 移除安装的 ceph 软件包
$ ansible all -m yum -a 'name=*ceph* state=removed'
```
