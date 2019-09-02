# Zookeeper 集群搭建
### 1.解压 zookeeper 压缩包
```sh
tar -zxvf zookeeper-3.4.5.tar.gz
```
2.配置 zoo.cfg 文件
进入 zookeeper/conf 目录，执行以下命令
```sh
cp zoo_sample.cfg zoo.cfg
```
修改zoo.cfg中的配置如下：

![png1](https://github.com/wangruofanWRF/notes/blob/master/zookeeper/png/png1.png)
![png2](https://github.com/wangruofanWRF/notes/blob/master/zookeeper/png/png2.png)

### 3.创建 dataDir 目录
这里指的是 “~Cloud/zookeeper-3.4.8/zookeeper_data”，且在该目录下创建名为 myid 的文件
```sh
mkdir ~Cloud/zookeeper-3.4.8/zookeeper_data
cd ~Cloud/zookeeper-3.4.8/zookeeper_data
```
### 4.编辑 “myid” 文件，并在对应的 IP 的机器上输入对应的编号
在192.168.1.121上，“myid” 文件内容就是 1 ，在 192.168.1.122 上，内容就是 2 ，在 192.168.1.124 上，内容就是 3 。与上面的 zoo.cfg 配置对应。

### 5、将配置好的 zookeeper 通过 scp 备份到对应的服务器上
```sh
scp -r ./zookeeper-3.4.8 root@192.168.1.122:~/Cloud
scp -r ./zookeeper-3.4.8 root@192.168.1.124:~/Cloud
```
依照 zoo.cfg 修改 zookeeper_data 目录中 myid 的值

### 6.启动 zookeeper
单独启动的 zookeeper 需要分别在每台服务器上执行以下命令
```sh
~Cloud/zookeeper-3.4.8/bin/zkServer.sh start
```
### 7.验证 zookeeper 安装
①使用jps检查服务是否启动

![png3](https://github.com/wangruofanWRF/notes/blob/master/zookeeper/png/png3.png)

可以看到 jps 会多出这样一个进程 QuorumPeerMain
②通过输入 “sh ./zkServer.sh status” 检查是否启动

![png4](https://github.com/wangruofanWRF/notes/blob/master/zookeeper/png/png4.png)

注意：
Zookeeper 的节点数必须是奇数
因为 zookeeper 有这样一个特性：集群中只要有过半的机器是正常工作的，那么整个集群对外就是可用的。也就是说如果有 2 个 zookeeper，那么只要有 1 个死了 zookeeper 就不能用了，因为 1 没有过半，所以 2 个 zookeeper 的死亡容忍度为 0；同理，要是有 3 个 zookeeper，一个死了，还剩下 2 个正常的，过半了，所以 3 个zookeeper 的容忍度为 1；同理你多列举几个：2->0;3->1;4->1;5->2;6->2 会发现一个规律，2n 和 2n-1 的容忍度是一样的，都是n-1，所以为了更加高效，何必增加那一个不必要的 zookeeper 呢。

### 作者
本文档由尹仁强创建，由王若凡整理
