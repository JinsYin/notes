# CentOS Iptables

## Iptables Service

```sh
$ yum install iptables-services
```

## Iptables

```sh
$ yum install iptables
```

## 接受

```sh
$ iptables -I INPUT -s 1.2.3.4 -j ACCEPT
```

## 限制 IP

```sh
$ iptables -I INPUT -s 1.2.3.4 -j DROP
```
