# Java for Linux

## CentOS

centos 7
```sh
$ yum list java* --showduplicate
$ yum install -y java-1.8.0-openjdk
```

配置环境变量（centos 千万不能修改 /etc/environment 文件）
```sh
$ sudo cat ~/.bashrc
export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk"
export JRE_HOME="/usr/lib/jvm/jre-1.8.0"
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
```

```sh
$ source ~/.bashrc
$ java -version
$ echo $JAVA_HOME
```

## Ubuntu

ubuntu 14.04
```sh
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
```

ubuntu 16.04
```sh
$ apt-get install -y openjdk-8-jre
$ apt-get install -y openjdk-8-jdk
```

管理多个 java 版本（可选）
```sh
$ sudo update-alternatives --config java (指定候选项)
# 或者: sudo update-java-alternatives --config /usr/lib/jvm/java-8-openjdk-amd64
```

设置环境变量
```sh
$ sudo cat /etc/environment
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
```

```sh
$ source /etc/environment
$ java -version
$ echo $JAVA_HOME
```
