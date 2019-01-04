# Iptables

## Iptables Service

```bash
$ yum install iptables-services
```

## Iptables

```bash
$ yum install iptables
```

## 接受

```bash
$ iptables -I INPUT -s 1.2.3.4 -j ACCEPT
```

## 限制 IP

```bash
$ iptables -I INPUT -s 1.2.3.4 -j DROP
```