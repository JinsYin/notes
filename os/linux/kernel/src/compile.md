# 编译 Linux 内核

## 系统环境

* Ubuntu 14.04
* Kernel 4.4.0
* GCC 4.8.4

## 安装依赖

```sh
$ sudo apt-get install git flex bison libelf-dev
```

## 获取源码

```sh
$ KVERSION=5.2.8 && git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
```

## 配置内核

Linux 内核提供了大量的特定功能和驱动程序，考虑到实际不大可能全部使用，所以编译内核之前需要根据实际需求进行配置。

在 Linux 源码中，配置项是以 CONFIG_FEATURE 形式来定义的，其前缀是 CONFIG，但在执行编译时省略了前缀。配置项要么二选一（`yes` 或 `no`），要么三选一（`yes`、`no` 或 `module`）。在三选一的情况下，`module` 选项表示该配置项被选定了，但编译时此功能的实现代码是以模块的形式生成，而 `yes` 选项表示把代码编译进内核映像中，而不是作为一个模块。驱动程序通常采用三选一的配置项。

配置命令：

| 命令行            | 描述                                                                |
| ----------------- | ------------------------------------------------------------------- |
| `make config`     | 采用字符界面逐一遍历所有配置项，并要求用户选择 yes、no（或 module） |
| `make menuconfig` | 采用基于 ncurse 库编制的图形界面配置内核                            |
| `make gconfig`    | 采用基于 gtk+ 的图形工具配置内核                                    |
| `make defconfig`  | 基于当前的处理器体系结构（如 x86_64）生成默认的配置项               |

最终生成的配置项会存放到内核代码树目录下的 `.config` 文件中，还可以再加以修改。在修改过配置文件后，或者在已有的配置文件配置新的代码树时，使用 `make oldconfig` 命令验证和更新配置。

配置内核最简单的方法是，除了使用 `make defconfig` 默认配置外，还可以拷贝当前所在 Linux 发行版的内核配置文件到待编译的内核目录，然后使用 `make menuconfig` 命令进行配置。

```sh
$ cd linux-x.y.z/ && cp /boot/config-$(uname -r) .config
$ make menuconfig
```

## 编译内核

```sh
$ make
```

make 程序能把编译过程拆分成多个并行的作业，有助于加快编译速度。默认情况下，make 只衍生一个作业，因为 Makefile 常常会出现不正确的依赖信息，导致多个作业相互冲突，最终编译出错。不过，内核的 Makefile 不存在这样的编码错误，所以衍生出的多个作业编译不会出现失败。

```sh
# 以 n 个作业编译内核，n 通常是处理器核数或者核数的两倍
$ make -j <n>
```

编译时会在内核代码树目录下创建一个 `System.map` 文件，这是一份符号对照表，用以将内核符号与其起始位置对应起来。调试时可用于将内存地址翻译成容易理解的函数名以及变量名。在 Linux 发行版中可以通过以下命令获取 System map：

```sh
$ cat /boot/System.map-$(uname -r)
$ cat /proc/kallsyms
```

## 升级内核（可选）

内核编译完成后，可以考虑将该内核作为系统新的引导，代替旧内核。

模块的安装是自动的，也是独立于体系结构的。下面的命令可以将所有已编译但系统没有的内核模块（文件后缀：`.ko`）安装到 `/lib/modules` 目录下：

```sh
$ sudo make modules_install
```

## 引导

```sh
$ sudo update-initramfs -c -k $KVERSION
```

更新 GRUB：

```sh
$ sudo update-grub
```

重启系统：

```sh
$ sudo reboot
```

## 参考

* [System.map 解析](https://blog.csdn.net/Tommy_wxie/article/details/8039695)
