# 搭建 Jenkins on Mesos
### 一.版本更新信息
2017年2月6日星期一
沈建实

### 二.关键点
封装带有 Mesos 环境的 Jenkins 镜像
Jenkins 向 Mesos 请求资源用于执行任务

### 三.正文
1.原理介绍  

   Jenkins 为我们提供了便利，当然 Jenkins 本身也有它自己的问题，比如传统的 Jenkins 是单点的，任务大多是需要排队的，如果每个任务都自己建一套 Jenkins的话，资源会非常浪费。为了解决这些问题，我们引入了 Jenkins on Mesos。  

   Jenkins 分为 Master 节点和 Slave 节点，Master 进行调度，Slave 节点负责执行Job任务。 
 
首先我们把 Jenkins 的 Master 通过 Marathon 发布，Marathon 去调用 Mesos Master，之后 Mesos Master 再去 Slave 节点起 Jenkins 的 Master。这个机制保证了 Jenkins Master 的高可用，Marathon 会监控 Jenkins Master 的健康状态，当 Jenkins Master 出现崩溃挂掉，Marathon 会自动再启动一个 Jenkins Master 的任务。Jenkins Master 使用 Mesos 整个大的资源池， Mesos 的资源池是一个资源共享的状态，资源利用率也会更高一些。  

   Jenkins Master 做的是调度，Jenkins Slave 则是真正执行构建任务的地方。Jenkins Master 会在 Mesos Master 上注册一个它自己的 Framework，如果有任务需要构建的话，Jenkins Master 会通知 Jenkins Framework 调用 Mesos Master构建一个任务。之后 Mesos Master 再调用 Mesos Slave 去起一个 Jenkins Slave 的节点去构建任务，它是实时的，用户资源可能被分配到各个机器上，在不同的机器上并行存在。此外，Jenkins 还具备动态调度功能，也就是说，当任务运行完后一定时间，资源会再返还给 Mesos，实现合理地利用整个集群的资源，提高集群的资源利用率。  

2.封装镜像  

  实现 Jenkins on Mesos 需要在 Jenkins 中安装一个名为 Mesos Plugin 的插件，此插件在配置过程中需要指定一个 Mesos 库文件的位置，这就需要 Jenkins所处的容器中安装有 Mesos 环境，然而 Jenkins官方提供的镜像本身不带有 Mesos 环境，所以第一步是自行封装一个带有 Mesos 环境的 Jenkins 镜像。 

  本文使用的是 Jenkins官方镜像作为基础镜像，在其中安装Mesos环境，最后打包为一个新的镜像。Dockerfile内容如下：  
```bash
FROM jenkins:2.32.1
MAINTAINER Shen Jianshi

# Mesos plugin needs mesos binary to be present
USER root
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    sh -c "echo deb http://repos.mesosphere.io/debian jessie main > /etc/apt/sources.list.d/mesosphere.list" && \
    apt-get update && \
    apt-get install -y mesos && \
    rm -rf /var/lib/apt/lists/*

USER jenkins

# Install mesos plugins and its dependencies
gRUN /usr/local/bin/install-plugins.sh mesos metrics credentials jackson2-api

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
```
   以上是 Dockerfile 的内容，在每一台 Mesos Slave 服务器中利用此文件封装镜像。  

![png1](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png16.png)

3.使用 Marathon 运行镜像   
 
   接下来需要在 Marathon 中运行该镜像，在 Marathon 界面中点击 create application，切换至 JSON Mode，输入如下内容：
```bash
{
  "id": "/jenkinsonmesos",
  "cmd": null,
  "cpus": 0.2,
  "mem": 512,
  "disk": 0,
   "instances": 0,
  "container": {
    "type": "DOCKER",
    "volumes": [
      {
        "containerPath": "/var/jenkins_home",
        "hostPath": "/root/data/jenkins3",
        "mode": "RW"
      }
    ],

    "docker": {
      "image": "jenkinsonmesos",
      "network": "HOST",
2      "portMappings": null,
      "privileged": false,
3      "parameters": [],
      "forcePullImage": false
    }
  },
  "portDefinitions": [
     {
      "port": 10001,
      "protocol": "tcp",
      "labels": {}
    }
  ]
}
```
以上内容中的 cpus 数值与 mem 数值可以按需指定，hostPath 为容器中的 Jenkins 配置文件在宿主机中挂载的位置，指定挂载目录的目的是确保每次启动容器后Jenkins 都可以加载之前的配置文件，以免每次重新设置。另外需确保外界拥有足够的权限访问宿主机中挂载的目录，例如执行 chmod 777 命令。  

   另外需要确保整个集群所有机器可以互相连通，即 /etc/hosts 中的 IP 地址与 hostname 互相匹配。可以以下图为参考：  
  
![png17](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png17.png)  

4.启动并配置 Jenkins  

   在浏览器中输入运行 Jenkins的主机地址与端口号，本文的地址是 192.168.42.135:8080。第一步是解锁 Jenkins：

![png18](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png18.png)

   该密码需要进入容器中寻找。首先执行命令：docker ps，查看当前运行的容器ID：  

![png19](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png19.png)

执行命令 docker exec –it –u root 579fb0c0999f /bin/bash ，注意命令中的容器 ID 需根据实际情况输入。进入容器后输入 		more/var/jenkins_home/secrets/initialAdminPassword，之后将密码复制进网页中。

![png20](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png20.png)

   接下来根据实际需要安装相应的插件，并创建管理员账户信息。  

   现在点击左侧系统管理，并进入系统设置，在页面底部点击新建新增一个云->Mesos Cloud。

![png21](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png21.png)

   然后按如下配置（ Mesos Master 根据实际情况填写）：  

![png22](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png22.png)

   进入“高级”，设置工作目录（该目录可任意设置，但必须存在）：

![png23](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png23.png)

   在以下选项点选 no：

![png24](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png24.png)


   完成后点击 apply 并保存。若配置正确则会在 mesos 管理界面中的 Framework 发现名为 Jenkins Scheduler 的 framework：

![png25](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png25.png)  

   配置完毕。  

5.执行测试项目    


现在进行一个简单测试，测试前请确保服务器已安装过 oracle-jdk （详见常见问题总结3）。  

新建一个名称任意的自由风格的软件项目，如下图勾选并填写该选项：

![png26](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png26.png)

   在构建一栏中新建构建步骤，填写任意一条 Linux 命令：  

![png27](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png27.png)  

   点击 apply 并保存，然后点击立即构建。 Jenkins 会显示其正在请求 Mesos 分配资源：

![png28](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png28.png)

   Mesos 管理界面中可看到该 framework 所得到的资源分配情况：

![png29](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png29.png)

    查看该项目的控制台输出：

![png30](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png30.png)

   回到主页中可发现 Mesos 为 Jenkins 分配的 slave 节点：

![png28](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png28.png)

   运行完成

















### 四.常见问题总结  

1.启动镜像时，网络模式应指定为 HOST 模式  

   若采用 BRIDGE 或其它模式，会导致 Mesos Plugin 无法在 Mesos 中注册 framework 。

2.为宿主机中配置文件挂载目录赋予足够权限  

   缺乏足够权限会导致 Marathon 无法启动容器。

3.sh 1 java not found  

   出现该错误的原因是 slave 节点未通过 apt 方式安装 oracle-jdk，安装方法如下：  

首先添加 ppa

$ sudo add-apt-repository ppa:webupd8team/Java

然后更新系统

$ sudo apt-get update

最后开始安装

$ sudo apt-get install Oracle-java8-installer

### 作者  
本文档由沈建实创建，由王若凡整理
