# jenkins 搭建修改版
### 1.下载 jenkins.war 包，拷贝到 Tomact 的 webapps 目录
### 2.Tomcat 启动后，进入 http://localhost:8080/jenkins/ 中
### 3.安装 GIT plugin 插件
系统管理-----管理插件-----可选插件----git plugin-----下载安装
### 4.配置 Maven 和 JDK 路径
a)系统管理-----系统设置
b)配置 Maven 和 JDK （略）
### 5.第二种配置，直接安装 jenkins
```sh
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo  
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install Jenkins
```
修改 jenkins 端口
```sh
vi /etc/sysconfig/Jenkins
```
![png1](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png1.png)

启动 jenkins
```sh
service jenkins start
```
![png2](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png2.png)

### 6.启动的时候如果报错 `Starting Jenkins  bash :  /usr/bin/java` : 没有那个文件或目录     [失败]
a)错误的原因 JDK 配置错误
b)执行命令

![png3](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png3.png)

c)看到 jdk 的版本，复制该名称，加入到以下代码中

```sh
vim /etc/init.d/Jenkins
```
![png4](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png4.png)

d)保存退出，重新执行启动命令
```sh

Service Jenkins start
```
### 7.启动 http://192.168.1.30:18080/
a)启动界面

![png5](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png5.png)

b)如果 jenkins 需要密码或者是密码忘记了，修改 config.xml 实现无密码登录
```sh
vim /var/lib/jenkins/config.xml
```
![png6](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png6.png)

c)安装 GIT plugin 插件

![png7](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png7.png)

d) Maven jdk git 配置
i.Maven Configuration

![png8](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png8.png)

ii.JDK

![png9](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png9.png)

iii.Git

![png10](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png10.png)

iv.Maven

![png11](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png11.png)


### 8.Jenkins git maven 集成测试
a)首先将一个 maven 项目上传到 gitlab

b)在 jenkins 中新建一个自由风格的工程

 ![png12](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png12.png)

c)源码管理 Git

![png13](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png13.png)

d)构建 maven

![png14](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png14.png)

保存
### 9.立即构建
构建运行的结果

![png15](https://github.com/wangruofanWRF/notes/blob/master/jenkins/png/png15.png)

### 作者  
本文档由尹仁强创建，由王若凡整理
