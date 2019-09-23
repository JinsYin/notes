# Raspbian 网络配置

Raspbian 的默认网络管理器（Network Manager）是 **dhcpcd**

```sh
$ vi /etc/dhcpcd.conf
# define static profile
profile static_eth0
static ip_address=⋯
static routers=⋯
static domain_name_servers=⋯

# fallback to static profile on eth0
interface eth0
fallback static_eth0
```
