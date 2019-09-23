# CentOS 安装 NextCloud

由于容器部署的 NextCloud 在配置 S3 MultiBucket 时总是不成功，所以打算手动部署一次好好研究一下配置。

## 环境

* CentOS 7.3

```sh
# EPEL
$ yum install epel-release

# 关闭防火墙
$ systemctl stop firewalld
```

## MariaDB

支持的数据库：

* SQLite
* MySQL/MariaDB
* PostgreSQL

```sh
# 安装 Server 和 Client
$ yum install -y mariadb mariadb-server
```

```sh
# 启动服务
$ systemctl start mariadb
$ systemctl enable mariadb

# 查看状态
$ systemctl status mariadb
```

```sh
# 运行脚本来强化 MariaDB 的安全性
$ mysql_secure_installation
Enter current password for root (enter for none): # 直接回车

Set root password? [Y/n] Y
New password: 123456
Re-enter new password: 123456

Remove anonymous users? [Y/n] Y

Disallow root login remotely? [Y/n] n

Remove test database and access to it? [Y/n] Y

Reload privilege tables now? [Y/n] Y
```

```sh
$ mysql -u root -p
> create database nextcloud;
> create user nextclouduser@localhost identified by 'nextclouduser@';
> grant all privileges on nextcloud.* to nextclouduser@localhost identified by 'nextclouduser@';
> flush privileges;
> exit
```

## Apache

```sh
$ yum install -y httpd

systemctl start httpd
systemctl enable httpd
```

## PHP

```sh
# 通过 SCL repository 安装 PHP
$ yum install -y centos-release-scl

# 安装 PHP 7.0 及相关模块
$ yum install -y rh-php70 rh-php70-php rh-php70-php-gd rh-php70-php-mbstring
```

```sh
# 为数据库安装相应模块

# MariaDB/MySQL
$ yum install rh-php70-php-mysqlnd

# 如果需要使用 Nextcloud LDAP app
$ yum install rh-php70-php-ldap
```

```plaintext
ln -s /opt/rh/httpd24/root/etc/httpd/conf.d/rh-php70-php.conf /etc/httpd/conf.d/
ln -s /opt/rh/httpd24/root/etc/httpd/conf.modules.d/15-rh-php70-php.conf /etc/httpd/conf.modules.d/
ln -s /opt/rh/httpd24/root/etc/httpd/modules/librh-php70-php7.so /etc/httpd/modules/
```

```sh
# 重启 Apache
$ systemctl restart httpd
```

## NextCloud

```sh
$ yum install -y zip

# 下载
$ wget https://download.nextcloud.com/server/releases/nextcloud-13.0.5.tar.bz2

# 解压
$ tar -jvxf nextcloud-13.0.5.tar.bz2
```

```sh
# 转移
$ mv nextcloud /var/www/html/
$ chown apache:apache -R /var/www/html
```

## Redis

```sh
# 安装
$ yum install -y redis

# 启动服务
$ systemctl start redis
$ systemctl enable redis
```

```sh
$ vi /var/www/nextcloud/config/config.php
'memcache.local' => '\OC\Memcache\APCU',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => array(
    'host' => 'localhost',
    'port' => 6379
),
```

## 参考

* [Installing PHP 7.0 on RHEL 7 and CentOS 7](https://docs.nextcloud.com/server/13/admin_manual/installation/php_70_installation.html)
