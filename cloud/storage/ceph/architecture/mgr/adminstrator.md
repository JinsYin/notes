# 管理模块

## 查看

```sh
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

## 启用/关闭

```sh
# 启用 dashboard 模块
$ ceph mgr module enable dashboard

# 关闭 dashboard 模块
$ ceph mgr module disable dashboard
````
