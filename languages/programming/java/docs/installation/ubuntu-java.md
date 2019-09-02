# Ubuntu 安装 java 8

ubuntu 支持安装多个java版本

## ubuntu 16.04
安装 openjdk 8
```sh
$ sudo apt-get install openjdk-8-jre && sudo apt-get install openjdk-8-jdk
```

## ubuntu 14.04
安装 oracle java 8
```sh
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
```

## 管理多个 java 版本（可选）
```sh
$ sudo update-alternatives --config java (指定候选项)
# 或者: sudo update-java-alternatives --config /usr/lib/jvm/java-8-openjdk-amd64
```

# 设置 JAVA_HOME 环境变量
```sh
$ sudo cat /etc/environment
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
```

```sh
$ source /etc/environment
```
