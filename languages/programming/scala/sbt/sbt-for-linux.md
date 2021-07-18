# Ubuntu scala

和 java 一样不太一样，没有必要在主机中安装 scala，直接再 IDEA 中安装插件就可以了。

scala 版本 2.11.8， 本地 jdk 版本 1.8。

## 安装病使用 scala

1. IDEA中 安装 scala 和 sbt 插件，然后重启

2. 创建 scala 项目：

  选择 scala 并指定本地 scala sdk（本地版本2.11.8）

3. 创建 sbt 项目：

	选择 sbt 版本0.13.8， scala 版本2.11.8


# 安装 sbt

和 maven 一样，使用 IDEA 的话没有必要再本地安装 sbt，直接再 IDEA 中安装插件就可以了。

1. 下载zip文件

> http://www.scala-sbt.org/download.html

2. 解压并 mv

```sh
$ mv sbt/ /usr/local/share
```

3. 修改环境变量

```sh
$ sudo vi /etc/environment
SBT_HOME=/usr/local/share/sbt
PATH=$PATH:$SBT_HOME/bin
```

4. 更新环境变量

```sh
$ source /etc/environment
```

5. 命令行执行：`sbt`，等待下载相关 jar
