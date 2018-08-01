# Maven服务器搭建
### 1. maven 版本：apache-maven-3.3.9
官网下载：http://maven.apache.org/download.cgi  
nexus 版本：nexus-2.13.0-01-bundle  
官网下载：http://www.sonatype.org/nexus/go   

### 2. maven 配置

a)在服务器 192.168.1.30 中:
Vim .bashrc

![png1](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png1.png)

export MAVEN_OPTS="-Xms256m -Xmx512m" //maven 运行的内存空间，暂时未设

b)测试版本 mvn – v
 
![png2](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png2.png)

这样 maven 安装成功  

c)配置用户范围 setting.xml（此步骤可不用，参见d）  
```bash
<!-- localRepository
   | The path to the local repository maven will use to store artifacts.
   |
   | Default: ${user.home}/.m2/repository
  <localRepository>/path/ to/local/repo</localRepository>
  -->
 	// <localRepository>/home/kernel/repository/maven</localRepository>
```
/home/kernel/repository/maven 是你 maven 本地仓库的路径  

d)配置用户范围 setting.xml   

i.执行以下语句，自动生成 ~/.m2 目录   
mvn clean  

![png3](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png3.png)

ii.将 /root/Cloud/apache-maven-3.3.9/conf/settings.xml 文件 copy 到 ~/.m2 目录：
```bash  
cp /home/kernel/Cloud/apache-maven-3.3.9/conf/settings.xml ~/.m2
```
![png4](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png4.png)

e) vim settings.xml  

![png5](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png5.png)

其中：${user.home}/repository/maven 是你 maven 本地仓库的路径。
 
### 3. nexus 配置
a)启动nexus  
```bash
./nexus   
./nexus start  
```
![png6](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png6.png)

b)查看控制台  
```bash
./nexus console
```
c)查看nexus日志  
```bash
tail -f wrapper.log
```
d)vim nexus  
加上RUN_AS_USER=root 

![png7](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png7.png)

### 4.访问地址：http://ip:8081/nexus	

a) 登录 nexus  
默认登录密码：admin/admin123
 
![png8](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png8.png)

b)关于仓库的类型介绍  
hosted 类型的仓库，内部项目的发布仓库  
releases 内部的模块中release模块的发布仓库  
snapshots 发布内部的SNAPSHOT模块的仓库  
3rd party 第三方依赖的仓库，这个数据通常是由内部人员自行下载之后发布上去  
proxy 类型的仓库，从远程中央仓库中寻找数据的仓库  
group 类型的仓库，组仓库用来方便我们开发人员进行设置的仓库  

c)需要将其他几个代理的库配置映射到 Public 中，分别将 Apache Snapshots,Central ,下 Download Remote Indexes 选项选择 [true] ，保存即可，默认是 false

d)设置 Releases 下的 Configuration 把 Deployment Policy 设置为 Allow  

e)将类型为 Proxy 的库 Apache Snapshots, Central 配置到 Public Repositories 下  

cf)然后分别将 Apache Snapshots, Central 更新 Index，在每一个库上面右键操作 Repair Index  

g)最后将 Public Repositories 操作 Repair Index  

然后接可以测试 maven 仓库了。  

### 5.测试 maven 仓库

a)在 ~/.m2 中配置 settings.xml  
```bash
<server>
         <id>nexus-releases</id>
         <username>admin</username>
         <password>admin123</password>
     </server>
     <server>
         <id>nexus-snapshots</id>
         <username>admin</username>
         <password>admin123</password>
     </server>
  </servers>

<mirror>
          <id>central</id>
          <mirrorOf>*</mirrorOf>
          <name>Central Repository</name>
          <url>http://192.168.1.30:8081/nexus/content/groups/public/</url>
      </mirror>
  </mirrors>
```
b)在 pom.xml 配置
```bash
<distributionManagement>
    <repository>
      <id>nexus-releases</id>
      <name>Local Nexus Repository</name>
      <url>http://192.168.1.30:8081/nexus/content/repositories/releases/</url>
    </repository>
    <snapshotRepository>
      <id>nexus-snapshots</id>
      <name>Local Nexus Repository</name>
      <url>http://192.168.1.30:8081/nexus/content/repositories/snapshots</url>
    </snapshotRepository>
  </distributionManagement>
```
### 6.测试结果

![png9](https://github.com/wangruofanWRF/notes/blob/master/maven/png/png9.png)  

### 作者
本文档由尹仁强创建，由王若凡整理

