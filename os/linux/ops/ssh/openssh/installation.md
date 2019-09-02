# 安装 OpenSSH

## Debian

```sh
sudo apt-get install openssh-client
sudo apt-get install openssh-server
```

## RHEL

```bash
sudo yum install openssh
```

## 相关文件

| 默认文件路径           | 说明                                                   |
| ---------------------- | ------------------------------------------------------ |
| ~/.ssh/known_hosts     | 连接过的节点，其指纹信息都会被添加到这个文件           |
| ~/.ssh/authorized_keys | 允许无密钥访问本机的所有节点的公钥都会被添加到这个文件 |
| ~/.ssh/id_rsa          | SSH 私钥                                               |
| ~/.ssh/id_rsa.pub      | SSH 公钥                                               |
| /etc/ssh/ssh_config    | OpenSSH SSH 客户端配置文件                             |
| /etc/ssh/sshd_config   | OpenSSH SSH 守护进程配置文件                           |

> 尽管各种 Linux 发行版的配置文件文件几乎是一样的，但是配置参数的值不一定相同，比如 PermitRootLogin