# SBT

SBT 同样也是使用的 Maven 的[中心仓库](https://search.maven.org/)，默认的本地存储路径是 `~/.ivy2`。

## 安装

* ubuntu

```sh
$ echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
$ sudo apt-get update
$ sudo apt-cache policy sbt
$ sudo apt-get install sbt=0.13.8
$ sbt # 运行 sbt 命令，安装所需依赖
```

## 项目目录结构

> <http://www.scala-sbt.org/0.13/docs/Directories.html>

```sh
$ find .
.
./project
./project/build.properties
./project/plugins
./build.sbt
./src
./src/main
./src/main/scala
./src/main/scala/SimpleApp.scala
```

## 定义依赖

```sbt
libraryDependencies += groupID % artifactID % revision
```

OR

```sbt
libraryDependencies ++= Seq(
    groupID % artifactID % revision,
    groupID % otherID % otherRevision
)
```

## 打包

* 命令行

```sh
$ sbt package
```

* IDEA IDE

## 参考

> http://www.scala-sbt.org/0.13/docs/zh-cn/index.html
