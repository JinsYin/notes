# Oracle 客户端

## Ubuntu Linux

下载地址：<https://www.oracle.com/database/technologies/instant-client/linux-x86-32-downloads.html>

* instantclient-basic-linux-12.2.0.1.0.zip
* instantclient-jdbc-linux-12.2.0.1.0.zip
* instantclient-sqlplus-linux-12.2.0.1.0.zip
* instantclient-sdk-linux-12.2.0.1.0.zip

> 具体的版本根据服务器端的版本来确定

解压：

```sh
$ mkdir -p $HOME/opt/oracle && cd $HOME/opt/oracle

$ cp instantclient-basic-linux-12.2.0.1.0.zip ./
$ cp instantclient-sdk-linux-12.2.0.1.0.zip ./

$ unzip instantclient-basic-linux-12.2.0.1.0.zip
$ unzip instantclient-sdk-linux-12.2.0.1.0.zip
```

最终目录：`$HOME/opt/oracle/instantclient_12_2`

配置：

```sh
$ vi ~/.zshrc # or: ~/.bashrc
# Oracle
export ORACLE_HOME=/home/jins/opt/oracle/instantclient_12_2
export TNS_ADMIN=$ORACLE_HOME/NETWORK/ADMIN  
export LD_LIBRARY_PATH=$ORACLE_HOME  
export SQLPATH=$ORACLE_HOME  
export NLS_LANG=AMERICAN_CHINA.ZHS16GBK  
export PATH=$PATH:$ORACLE_HOME  
```

依赖：

```sh
$ sudo apt install libaio-dev
```