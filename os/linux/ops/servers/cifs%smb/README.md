# CIFS/SMB

* [SMB 协议](#)
* [SMB 服务端](server.md)
* [SMB 客户端](client.md)

## SMB vs CIFS

CIFS（Common Internet File System）是一种网络文件系统协议，用于在网络上的计算机之间共享文件和打印机。

CIFS 协议最初由 IBM 开发，之后命名为 SMB（Server Message Block）。微软在 Windows 95 对更新版本的 SMB 协议进行了大量修改又重新改名为 CIFS，其实现是事实上的 CIFS 标准，不同版本的 Windows 可能使用不同版本的 CIFS/SMB（1.x、2.x、3.x ...）。

简而言之，CIFS 是微软对 SMB 的扩展（增强版本），通常认为 CIFS/SMB 是一回事。

## SMB 协议

SMB（Server Message Block）

CIFS/SMB 消息使用 NetBIOS 或 TCP 协议发送，分别使用不同的端口 `139` 或 `445`，目前倾向于使用 `445` 端口。

SMB 协议常用于 PC 间（MacOS、Windows、Linux）的文件共享（内核内置驱动），而 NFS 协议常用于服务器间的文件共享

## Samba vs SMB

微软主导了 CIFS/SMB 的开发但没有公开其文件共享机制，因此 Samba 项目通过 _逆向工程_ 提供了一个与 CIFS/SMB 软件兼容的自由软件，使得 Unix 系列系统（Linux、MacOS）可以与 Windows 系统相互共享。

## 参考

* [CIFS](https://cifs.com/)
* [CIFS vs SMB: What’s the Difference?](https://www.varonis.com/blog/cifs-vs-smb/)
