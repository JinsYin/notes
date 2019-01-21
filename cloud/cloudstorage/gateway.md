# 云存储网关

存储协议主要有两种：

* 基于区块（Block-based）的存储协议，如：iSCSI、光纤通道（Fibre Channel）
* 基于文件（File-based）的存储协议，如：NFS、CIFS（SMB）

远程访问的 Web API 风格：

* SOAP
* REST

云存储网关可以根据需求安装在客户端上，便于像访问本地端存储一样使用云存储服务。云存储网关是透过网络设备或服务器（server），将云存储的 SOAP 或 REST API 转换成 `基于区块的存储协议` 或 `基于文件的存储协议`。