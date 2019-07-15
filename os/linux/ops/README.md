# Linux 运维

## Todo

* 抽象出大多数 Linux 发行版的运维共同点

## 内容

* 统一修改所有机器的主机名
* 统一配置 SSH：修改端口等等
* 批量安装常用软件
* 同步时间

## 运维管理

* 共同点

| ID   | 任务                                                             | 前提   |
| ---- | ---------------------------------------------------------------- | ------ |
| [01] | 修改主机名                                                       |        |
| [02] | 生成 SSH 公私钥                                                  |        |
| [03] | 安装常用软件：git、wget、net-tools、bind-utils、htop、vim、lrzsz |        |
| [04] | 添加 EPEL 源                                                     |        |
| [05] | 同步时间                                                         |        |
| [06] | 设置时区                                                         | tzdata |

* 仅管理节点

| ID  | 任务                                                                | 前提                           |
| --- | ------------------------------------------------------------------- | ------------------------------ |
| [1] | 修改主机名                                                          | hostnamectl 命令（默认已存在） |
| [1] | 生成 SSH 公私钥                                                     | OpenSSH 工具（默认已安装）     |
| [2] | 安装常用软件：tmux、sshpass                                         | 网络                           |
| [3] | 将公钥添加到所有被管理节点，全部实现免密钥登录                      | sshpass 工具（[2]）            |
| [4] | 修改本机 SSH 和 SSHD 配置并重启服务                                 |                                |
| [5] | 添加外部软件源：EPEL                                                | 网络                           |
| [6] | 将本机 SSH 配置同步到所有被管理节点并重启所有被管理节点的 SSHD 服务 |                                |

* 仅被管理节点

| ID   | 任务            | 前提 |
| ---- | --------------- | ---- |
| [b1] | 修改主机名      |      |
| [b2] | 生成 SSH 公私钥 |      |

作为管理节点，通常需要完成以下工作：

1. 管理节点生成 SSH 公私钥
2. 对管理节点安装常用软件，如：sshpass
3. 被管理节点安装常用软件，如：git、wget、net-tools
4. 将管理节点公钥传递到所有远程机器，全部实现免密钥登录；前提条件：#2 安装 sshpass
5. 设置所有机器的主机名；前提：#3
6. 将管理节点的 ssh_config 和 sshd_config 同步到所有远程机器，并重启 sshd 服务
7. 为所有远程机器生成 SSH 公私钥（可选）
8. 同步所有机器的时间
9. 将所有远程机器的 hostname&ip 添加 hosts 文件
10. 将管理节点的 hosts 文件同步到所有远程机器；前提条件：#6
11. 允许远程机器之间相互无密钥访问（不建议）
12. 允许远程机器无密钥访问控制节点（不建议）

* `servers.txt`（IP 地址 | 主机名 | 端口 | 用户名 | 密码）—— 不含管理节点

```txt
192.168.1.172 ip-192-168-1-172.ceph.ew 22 root test
192.168.1.173 ip-192-168-1-173.ceph.ew 22 root test
192.168.1.174 ip-192-168-1-174.ceph.ew 22 root test
192.168.1.175 ip-192-168-1-175.ceph.ew 22 root test
192.168.1.176 ip-192-168-1-176.ceph.ew 22 root test
192.168.1.177 ip-192-168-1-177.ceph.ew 22 root test
192.168.1.178 ip-192-168-1-178.ceph.ew 22 root test
```

* 脚本（需要考虑重复执行）

```bash
#!/bin/bash
# RHEL

# 检查软件包是否存在
fn::centos::pkg_exists()
{
  rpm -q $@ > /dev/null 2>&1
}

# 安装软件包
fn::centos::install_pkg()
{
  for package in $@; do
    if ! fn::centos::pkg_exists $package; then
      yum install -y $package
    fi
  done
}

fn::centos::sync_time()
{
  # ntpdate 软件包已被弃用
  fn::centos::install_pkg

  # 同步一次时钟（停止 ntpd 为了避免 ntpdate 不能打开 socket <UDP port 123> 连接 ntp 服务器）
  systemctl stop ntpd
  ntpdate -s cn.pool.ntp.org

  # 将系统时间写入 BIOS（系统重启后会首先读取 BIOS 时间）
  hwclock -w

  # 后台运行的 ntpd 会不断调整系统时间（具体配置：/etc/ntp.conf）
  systemctl enable ntpd
  systemctl start ntpd
}

# 管理节点
fn::centos::src()
{
    #1
  echo "[1]"
  sed -i "/StrictHostKeyChecking/ s|^#| |; /StrictHostKeyChecking/ s|ask|no|" /etc/ssh/ssh_config
  sed -i "/#UseDNS/ s|^#||; /UseDNS/ s|yes|no|" /etc/ssh/sshd_config
  echo -e "n\n" | ssh-keygen -q -f ~/.ssh/id_rsa -t rsa -N '' &> /dev/null

  #2
  echo "[2]"
  fn::centos::pkg_exists sshpass git wget net-tools
}

# 被管理节点
fn::centos::dst()
{
    # $1: 服务器文件
    cat $1 | while read ip hostname port user passwd; do
        echo " - $ip"
        #3
        fn::centos::pkg_exists git wget net-tools
        #3
        echo "[3]"
        sshpass -p $passwd ssh-copy-id -p $port $user@$ip &> /dev/null
        #4
        echo "[4]"
        ssh -nq $user@$ip "hostnamectl set-hostname $hostname"
        #5
        echo "[5]"
        scp /etc/ssh/ssh_config $user@$ip:/etc/ssh/ssh_config &> /dev/null
        scp /etc/ssh/sshd_config $user@$ip:/etc/ssh/sshd_config &> /dev/null
        ssh -nq $user@ip "systemctl restart sshd"
        #6
        echo "[6]"
        ssh -nq $user@$ip 'echo -e "n\n" | ssh-keygen -q -f ~/.ssh/id_rsa -t rsa -N ""' &> /dev/null
        #7
        fn::centos::sync_time $@
        #8
        echo "[8]"
        #if ! grep -E "$ip|$hostname" /etc/hosts &> /dev/null; then
        if ! grep -E "$ip $hostname" /etc/hosts &> /dev/null; then
        echo -e "$ip\t$hostname" >> /etc/hosts
        fi
    done

    echo " - "
    cat "servers.txt" | while read ip hostname port user passwd; do
        #9
        echo "[9] $ip"
        scp /etc/hosts $user@$ip:/etc/hosts &> /dev/null
    done
}

main()
{
    fn::centos::src
    fn::centos::dst servers.txt
}

main $@
```

破坏：

```bash
vi /etc/hosts
```

## 参考

```bash
#!/bin/bash
rm -f ./authorized_keys; touch ./authorized_keys
sed -i '/StrictHostKeyChecking/ s/^#/ /; /StrictHostKeyChecking/ s/ask/no/' /etc/ssh/ssh_config
sed -i "/#UseDNS/ s/^#//; /UseDNS/ s/yes/no/" /etc/ssh/sshd_config

cat hostsname.txt | while read host ip pwd; do
  sshpass -p $pwd ssh-copy-id -f $ip 2>/dev/null
  ssh -nq $ip "hostnamectl set-hostname $host"
  ssh -nq $ip "echo -e 'y\n' | ssh-keygen -q -f ~/.ssh/id_rsa -t rsa -N ''"
  echo "===== Copy id_rsa.pub of $ip ====="
  scp $ip:/root/.ssh/id_rsa.pub ./$host-id_rsa.pub
  #cat ./$host-id_rsa.pub >> ./authorized_keys
  echo $ip $host >> /etc/hosts
done

cat ~/.ssh/id_rsa.pub >> ./authorized_keys
cat hostsname.txt | while read host ip pwd; do
  rm -f ./$host-id_rsa.pub
  echo "===== Copy authorized_keys to $ip ====="
  scp ./authorized_keys $ip:/root/.ssh/
  scp /etc/hosts $ip:/etc/
  scp /etc/ssh/ssh_config $ip:/etc/ssh/ssh_config
  scp /etc/ssh/sshd_config $ip:/etc/ssh/sshd_config
  ssh -nq $ip "systemctl restart sshd"
done
```