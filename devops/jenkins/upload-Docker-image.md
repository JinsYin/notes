
# 使用Jenkins构建并上传Docker镜像
### 一、环境准备

本文使用两台装有 ubuntu 16.04 系统的虚拟机，它们的 IP 地址分别为：  
虚拟机 A ：192.168.42.128 （开发端）  
虚拟机 B ：192.168.42.129 （仓库端）  
   两台虚拟机都搭建了 Docker 环境，其中，虚拟机 B 作为仓库端运行 Registry 镜像；虚拟机 A 还搭建了 Gitlab 与 Jenkins 。  
本文欲实现的目标是：使用虚拟机 A 中的 Jenkins 将 Gitlab 中预先上传的 Dockerfile 提取下来，之后 Jenkins 利用此 Dockerfile 和虚拟机 A 中已搭建完成的 Docker 环境构建一个 Docker 镜像，构建完成后再将此镜像传送到虚拟机 B 中的私有仓库。

### 二、操作过程

   首先在网上寻找一个 Dockerfile ，本文使用的 Dockerfile 出自该网址： https://github.com/kstaken/dockerfile-examples 。本文使用的是名为 Apache 的镜像，将此 Dockerfile 上传到虚拟机 A 中的 Gitlab ：  

![png39](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png39.png)

   现在在 Jenkins 中新建一个名为 apache 的自由风格的软件项目，在配置文件中指定之前上传 Dockerfile 的 Gitlab 地址：

![png40](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png40.png)

   在下方构建一栏中，点击增加构建步骤，选择 Execute shell ：  

![png41](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png41.png)

   此时会出现 command 一栏，在其中输入如下命令：  

![png42](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png42.png)

   这些命令将会构建镜像并将镜像上传到私有仓库中。保存好配置文件，点击开始构建，在控制台中可以看到如下画面：  

![png43](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png43.png)

   该图表示 Jenkins 已经从 Gitlab 中获取了 Dcokerfile 并正在构建和上传镜像，完成之后在虚拟机 A 中执行 docker images 命令可以看到 Jenkins 构建完成的 apache 镜像。现在检查私有仓库中存储的镜像是否包含 apache , 在 chrome 浏览器中输入 http://192.168.42.129:5000/v2/_catalog ，可以看到如图所示的结果：

![png44](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png44.png)  

   可以看到名为apache的镜像已被上传到私有仓库中。

### 作者
本文档由尹仁强创建，由王若凡整理
