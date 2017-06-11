# Java 安装

## CentOS

centos 7
```bash
$ yum list java* --showduplicate
$ yum install -y java-1.8.0-openjdk
```

配置环境变量（centos 千万不能修改 /etc/environment 文件）
```bash
$ sudo cat ~/.bashrc
export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk"
export JRE_HOME="/usr/lib/jvm/jre-1.8.0"
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
```

```bash
$ source ~/.bashrc
$ java -version
$ echo $JAVA_HOME
```

## ubuntu

ubuntu 14.04
```bash
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
```

ubuntu 16.04
```bash
$ apt-get install -y openjdk-8-jre
$ apt-get install -y openjdk-8-jdk
```

管理多个 java 版本（可选）
```bash
$ sudo update-alternatives --config java (指定候选项)
# 或者: sudo update-java-alternatives --config /usr/lib/jvm/java-8-openjdk-amd64
```

设置环境变量
```bash
$ sudo cat /etc/environment
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
```

```bash
$ source /etc/environment
$ java -version
$ echo $JAVA_HOME
```
