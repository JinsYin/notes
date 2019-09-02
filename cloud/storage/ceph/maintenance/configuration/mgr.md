# Ceph Manager Daemon

## Modules

```sh
$ ceph mgr module ls
{
    "enabled_modules": [
        "balancer",
        "dashboard",
        "restful",
        "status"
    ],
    "disabled_modules": [
        "influx",
        "localpool",
        "prometheus",
        "selftest",
        "zabbix"
    ]
}
```

```sh
# 启用模块
$ ceph mgr module enable prometheus

# 关闭模块
$ ceph mgr module disable prometheus
```

### Prometheus

```sh
# 配置 IP 和 端口
$ ceph config-key put mgr/prometheus/server_addr 192.168.8.220
$ ceph config-key put mgr/prometheus/server_port 9283 # 默认端口
```

```sh
# 启用 prometheus 模块
$ ceph mgr module enable prometheus
```

浏览器打开：<http://192.168.8.220:9283/metrics>

```sh
# Prometheus
$ docker run -d --name prometheus -p 9090:9090 prom/prometheus:v1.0.0

# Grafana
$ docker run -d --name grafana -p 3000:3000 grafana/grafana:3.1.1
```

* <https://ceph.com/planet/%E5%BF%AB%E9%80%9F%E6%9E%84%E5%BB%BAceph%E5%8F%AF%E8%A7%86%E5%8C%96%E7%9B%91%E6%8E%A7%E7%B3%BB%E7%BB%9F/>

### Dashboard

默认 `dashboard` 以及启用，如需手动配置：

```sh
# 配置 IP 和 端口
$ ceph config-key put mgr/dashboard/server_addr 192.168.8.220
$ ceph config-key put mgr/dashboard/server_port 7000 # 默认端口
```

```sh
# 启用 dashboard 模块
$ ceph mgr module enable dashboard
```

浏览器打开：<http://192.168.8.220:7000>

## Services

```sh
$ ceph mgr services
{
    "dashboard": "http://192.168.8.220:7000/"
}
```

## 参考

* [Ceph Luminous 新功能之内置 Dashboard](https://ceph.com/planet/ceph-luminous-%E6%96%B0%E5%8A%9F%E8%83%BD%E4%B9%8B%E5%86%85%E7%BD%AEdashboard/)