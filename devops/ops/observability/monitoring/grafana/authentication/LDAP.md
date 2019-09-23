# LDAP 认证

Grafana 集成 LDAP 后，用户可以使用 LDAP 凭证进行登录。

## 配置流程

### 开启 LDAP

```ini
# 别忘了移除逗号
$ vi /etc/grafana/grafana.ini

[auth.ldap]
enabled = true
config_file = /etc/grafana/ldap.toml # LDAP 配置文件路径
allow_sign_up = true # 允许注册用户到 LDAP；如果设置为 false 只有预先存在的用户才能存在
```

### 配置 LDAP

```ini
$ vi /etc/grafana/ldap.toml

# Set to true to log user information returned from LDAP（调试时建议设置为 true）
verbose_logging = false

[[servers]]
# Ldap server host (specify multiple hosts space separated)
host = "127.0.0.1" # -_- -_- -_-
# Default port is 389 or 636 if use_ssl = true
port = 389
# Set to true if ldap server supports TLS
use_ssl = false
# set to true if you want to skip ssl cert validation
ssl_skip_verify = false
# set to the path to your root CA certificate or leave unset to use system defaults
# root_ca_cert = /path/to/certificate.crt

# Search user bind dn
bind_dn = "cn=admin,dc=eway,dc=link" # -_- -_- -_-
# Search user bind password
bind_password = 'admin' # -_- -_- -_-

# User search filter, for example "(cn=%s)" or "(sAMAccountName=%s)" or "(uid=%s)"
search_filter = "(cn=%s)" # -_-

# An array of base dns to search through
search_base_dns = ["ou=people,dc=eway,dc=link","cn=cloud,ou=it,ou=people,dc=eway,dc=link"] # -_-

# 如果 LDAP 服务器不支持 memberOf 属性，需要添加以下选项
group_search_filter = "(&(objectClass=posixGroup)(memberUid=%s))" # -_-
group_search_filter_user_attribute = "cn" # -_-
group_search_base_dns = ["ou=grafana,ou=group,dc=eway,dc=link"] # （不一定要很下层，可以稍微上层一些） DNs

# In POSIX LDAP schemas, without memberOf attribute a secondary query must be made for groups.
# This is done by enabling group_search_filter below. You must also set member_of= "cn"
# in [servers.attributes] below.

# Users with nested/recursive group membership and an LDAP server that supports LDAP_MATCHING_RULE_IN_CHAIN
# can set group_search_filter, group_search_filter_user_attribute, group_search_base_dns and member_of
# below in such a way that the user's recursive group membership is considered.
#
# Nested Groups + Active Directory (AD) Example:
#
#   AD groups store the Distinguished Names (DNs) of members, so your filter must
#   recursively search your groups for the authenticating user's DN. For example:
#
#     group_search_filter = "(member:1.2.840.113556.1.4.1941:=%s)"
#     group_search_filter_user_attribute = "distinguishedName"
#     group_search_base_dns = ["ou=groups,dc=grafana,dc=org"]
#
#     [servers.attributes]
#     ...
#     member_of = "distinguishedName"

## Group search filter, to retrieve the groups of which the user is a member (only set if memberOf attribute is not available)
# group_search_filter = "(&(objectClass=posixGroup)(memberUid=%s))"
## Group search filter user attribute defines what user attribute gets substituted for %s in group_search_filter.
## Defaults to the value of username in [server.attributes]
## Valid options are any of your values in [servers.attributes]
## If you are using nested groups you probably want to set this and member_of in
## [servers.attributes] to "distinguishedName"
# group_search_filter_user_attribute = "distinguishedName"
## An array of the base DNs to search through for groups. Typically uses ou=groups
# group_search_base_dns = ["ou=groups,dc=grafana,dc=org"]

# Specify names of the ldap attributes your ldap uses
[servers.attributes]
name = "givenName"
surname = "sn"
username = "cn"
member_of = "cn" # -_-
email =  "email"

# Map ldap groups to grafana org roles
[[servers.group_mappings]]
group_dn = "cn=grafana-admins,ou=grafana,ou=group,dc=eway,dc=link"
org_role = "Admin"
# The Grafana organization database id, optional, if left out the default org (id 1) will be used
# org_id = 1

[[servers.group_mappings]]
group_dn = "cn=grafana-editors,ou=grafana,ou=group,dc=eway,dc=link"
org_role = "Editor"

[[servers.group_mappings]]
# If you want to match all (or no ldap groups) then you can use wildcard
group_dn = "cn=grafana-viewers,ou=grafana,ou=group,dc=eway,dc=link"
org_role = "Viewer"
```

相关说明：

* `host` 和 `port` 指定 LDAP Server 的地址和端口
* `bind_dn`/`bind_dn`: 可以执行 LDAP search 的只读用户
* 由于使用的 OpenLDAP 是没有 memberOf 属性的 POSIX Schema，所以获取用户的 Group 信息需要另一个查询：通过 `group_search_base_dns` 和 `group_search_filter`，同时需要设置 `member_of = "cn"`
* `[[servers.group_mappings]]` 用于指定 LDAP `group` 与 Grafana `org_role`（Organization user roles）的映射关系，主要

## 参考

* [配置 Grafana 启动 LDAP 认证](https://blog.frognew.com/2017/07/config-grafana-with-ldap.html)
* [Grafana Document - LDAP Authentication](http://docs.grafana.org/auth/ldap/)
