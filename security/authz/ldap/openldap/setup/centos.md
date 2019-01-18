# 部署 OpenLDAP

## 安装

| 软件包           | 描述                                                |
| ---------------- | --------------------------------------------------- |
| openldap         | 包含 OpenLDAP 配置文件、库和文档                    |
| openldap-servers | 包含 `slapd` 和 `slurpd` 服务器、迁移脚本和相关文件 |
| openldap-clients | 包含客户机程序，用来访问和修改 OpenLDAP 目录        |
| openldap-devel   |                                                     |
| compat-openldap  |                                                     |
| phpLDAPadmin     |                                                     |

```bash
$ yum install -y openldap openldap-servers openldap-clients # openldap-devel compat-openldap

# 查看安装的软件包
$ rpm -qa | grep openldap
openldap-clients-2.4.44-5.el7.x86_64
openldap-servers-2.4.44-5.el7.x86_64
openldap-2.4.44-5.el7.x86_64

# 查看安装的版本
$ sldap -V
@(#) $OpenLDAP: slapd 2.4.44 (Oct 30 2018 23:14:27) $
    mockbuild@x86-01.bsys.centos.org:/builddir/build/BUILD/openldap-2.4.44/openldap-2.4.44/servers/slapd
```

## 配置

配置文件：

| 文件路径                                          | 描述                                                                                             |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
|                                                   |                                                                                                  |
| `/etc/openldap/slapd.conf`                        | 主配置文件，记录 `根域`、管理员名称、密码、日志、权限等                                          |
| `/etc/openldap/slapd.d/*`                         | 这下面是 /etc/openldap/slapd.conf 配置信息生成的文件，每修改一次配置信息，这里的东西就要重新生成 |
| `/etc/openldap/schema/*`                          | Schema 存放位置                                                                                  |
| `/var/lib/ldap/*`                                 | 数据文件                                                                                         |
| `/usr/share/openldap-servers/slapd.conf.obsolete` | 模板配置文件                                                                                     |
| `/usr/share/openldap-servers/DB_CONFIG.example`   | 模板数据库配置文件                                                                               |

监听端口：

| 端口 | 描述                           |
| ---- | ------------------------------ |
| 389  | 默认监听端口；用于明文数据传输 |
| 636  | 加密监听端口；用于密文数据传输 |

* 设置管理员密码

```bash
# 生成加密的密码（每次执行都不一样）
$ slappasswd -s 123456
{SSHA}0qrpJ5LK9n+O5FOgyXiRL4chdgvCjBAB
```

```bash
# 添加或修改
$ vi /etc/openldap/slapd.d/cn=config/olcDatabase\=\{2\}hdb.ldif
olcSuffix: dc=eway,dc=link # 根域
olcRootDN: cn=root,dc=eway,dc=link # 管理员用户名
olcRootPW: {SSHA}0qrpJ5LK9n+O5FOgyXiRL4chdgvCjBAB # 管理员密码
```

```bash
$ sed -i -e "s|cn=Manager,dc=my-domain,dc=com|cn=root,dc=eway,dc=link|g" \
  /etc/openldap/slapd.d/cn=config/olcDatabase\=\{1\}monitor.ldif
```

验证配置是否正确：

```bash
$ slaptest -u
5c3ee69e ldif_read_file: checksum error on "/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif"
5c3ee69e ldif_read_file: checksum error on "/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif"
config file testing succeeded
```

## 运行

```bash
$ cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

# 启动
$ systemctl enable slapd
$ systemctl start slapd

# 查看服务状态
$ systemctl status -l slapd

# 查看端口使用情况
$ netstat -tpln | grep slapd
tcp   0  0 0.0.0.0:389  0.0.0.0:*  LISTEN  22887/slapd
tcp6  0  0 :::389       :::*       LISTEN  22887/slapd

# 如果启动失败，请排错日志
$ journalctl -f -u slapd
```

* 设置管理员密码

```bash
#
$ slappasswd
New password:
Re-enter new password:
{SSHA}bVIaZCbrmkFO6CcpfAhRdJTXefjAPOeM
```

* 新建文件

```bash
$ touch chrootpw.ldif

echo "dn: olcDatabase={0}config,cn=config" >> chrootpw.ldif
echo "changetype: modify" >> chrootpw.ldif
echo "add: olcRootPW" >> chrootpw.ldif
echo "olcRootPW: {SSHA}bVIaZCbrmkFO6CcpfAhRdJTXefjAPOeM" >> chrootpw.ldif
```

* 导入该文件

```bash
$ ldapadd -Y EXTERNAL -H ldapi:/// -f chrootpw.ldif
SASL/EXTERNAL authentication started
SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
SASL SSF: 0
modifying entry "olcDatabase={0}config,cn=config"
```

* 导入基本 Schema（可以有选择地导入）

```bash
$ cd /etc/openldap/schema/
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f collective.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f corba.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f core.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f duaconf.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f dyngroup.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f inetorgperson.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f java.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f misc.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f openldap.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f pmi.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f ppolicy.ldif
```

## 设置自己的 Domain Name