# GlusterFS

GlusterFS 是一个开源的、可扩展的网络文件系统，适用于高数据密集型工作负载。

GlusterFS 通过 Infiniband RDMA 或者 TCP/IP 方式将多个廉价的 x86 主机，通过网络互联组成一个并行的网络文件系统。


## 目录

* [GlusterFS 安装部署](./gluster-installation.md)
* [GlusterFS Volume](./gluster-volume.md)
* [GlusterFS 调优](./gluster-performance.md)
* [GlusterFS 监控](./gluster-monitor.md)


## 术语

* Brick - 可信存储池中服务器上基本存储（目录）。
* Brick server - gluster server
* Volume - Brick 的逻辑集合。
* Cluster - 一组关联的计算机节点。
* Client - 挂载 Volume 的节点。
* Server - 实际存储数据的节点。
* Fuse - 可加载的 kernel 模块，允许非特权用户在不编辑内核代码的情况下创建自己的文件系统。


## 客户端挂载

http://www.mamicode.com/info-detail-1925105.html


## 参考

* [CentOS 7 安装 GlusterFS](http://www.cnblogs.com/jicki/p/5801712.html)
* [Setting up GlusterFS Volumes](http://docs.gluster.org/en/latest/Administrator%20Guide/Setting%20Up%20Volumes/)

