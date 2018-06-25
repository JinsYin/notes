# Ansible

Ansible 使用 SSH 与目标节点进行通信，不需要在目标节点上安装任何客户端程序。

<!--
Ansible之所以不需要agent，原理在于其将要执行的命令或者脚本通过sftp的方式传到要执行的对象机器，然后通过ssh远程执行，执行之后清理现场将sftp传过去的文件删除，好像一切都没有发生过的一样，这个就是ansible不需要agent的原理。
-->

真正具有批量部署的是ansible所运行的模块，ansible只是提供一种框架。主要包括：
(1)、连接插件connection plugins：负责和被监控端实现通信；
(2)、host inventory：指定操作的主机，是一个配置文件里面定义监控的主机；
(3)、各种模块核心模块、command模块、自定义模块；
(4)、借助于插件完成记录日志邮件等功能；
(5)、playbook：剧本执行多个任务时，非必需可以让节点一次性运行多个任务。


## 术语


## 特点

* no agents: 不需要在被管控主机上安装任何客户端进程
* no server: 无服务器端，使用时直接运行命令即可
* modules in any languages: 基于模块工作，可使用任何语言开发模块；
* yaml,no code: 使用 yaml 语言定制 playbook
* ssh by default: 基于 SSH 工作
* strong multi-tier solution: 可实现多级指挥