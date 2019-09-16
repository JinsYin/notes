# Ceph Manager Daemon (ceph-mgr)

<!--
The Ceph manager handles execution of many of the read-only Ceph CLI queries
-->

Ceph manager 处理许多只读 Ceph CLI 查询的执行。

## 模块管理

### 查看

```bash
$ ceph mgr module ls
{
    "enabled_modules": [
        "balancer",
        "iostat",
        "restful",
        "status"
    ],
    "disabled_modules": [
        {
            "name": "dashboard",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "hello",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "influx",
            "can_run": false,
            "error_string": "influxdb python module not found"
        },
        {
            "name": "localpool",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "prometheus",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "selftest",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "smart",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "telegraf",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "telemetry",
            "can_run": true,
            "error_string": ""
        },
        {
            "name": "zabbix",
            "can_run": true,
            "error_string": ""
        }
    ]
}
```

### 启用/关闭

```bash
# 启用 dashboard 模块
$ ceph mgr module enable dashboard

# 关闭 dashboard 模块
$ ceph mgr module disable dashboard
```

## 参考

* [ceph api 使用](http://www.li-rui.top/2018/11/04/ceph/ceph%20api%E4%BD%BF%E7%94%A8/)