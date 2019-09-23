# CEPH-ANSIBLE 角色

| 角色                   | 分支                                                  | 描述                                                                                                                                  |
| ---------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| ceph-agent             | * `stable-2.1` - `stable-4.0` √ <br> * `master` ×     | * 允许远程节点通过配置 salt 来注册 Calamari 主服务器 <br> * 仅限 RedHat，若使用了 `ceph-mgr` 基本就不再需要该角色，新版本将废弃该角色 |
| ceph-client            | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-common-coreos     | * `stable-2.1` - `stable-3.2` √ <br> * `stable-4.0` × |                                                                                                                                       |
| ceph-common            | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-config            | * `stable-3.0` - `stable-4.0` √                       |                                                                                                                                       |
| ceph-container-common  | * `stable-4.0` √                                      |                                                                                                                                       |
| ceph-container-engine  | * `stable-4.0` √                                      |                                                                                                                                       |
| ceph-dashboard         | * `stable-4.0` √                                      |                                                                                                                                       |
| ceph-defaults          | * `stable-3.0` - `stable-4.0` √                       |                                                                                                                                       |
| ceph-docker-common     | * `stable-2.1` - `stable-3.2` √ <br> * `stable-4.0` × |                                                                                                                                       |
| ceph-facts             | * `stable-3.2` - `stable-4.0` √                       |                                                                                                                                       |
| ceph-fetch-keys        | * `stable-2.1` - `stable-3.2` √ <br>                  |                                                                                                                                       |
| ceph-grafana           | * `stable-4.0` √                                      |                                                                                                                                       |
| ceph-handler           | * `stable-3.2` - `stable-4.0` √                       |                                                                                                                                       |
| ceph-infra             | * `stable-3.2` - `stable-4.0` √                       |                                                                                                                                       |
| ceph-iscsi-gw          | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-mds               | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-mgr               | * `stable-2.2` - `stable-4.0`                         |                                                                                                                                       |
| ceph-mon               | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-nfs               | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-node-exporter     | * `stable-4.0` √ <br>                                 |                                                                                                                                       |
| ceph-osd               | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-prometheus        | * `stable-4.0` √ <br>                                 |                                                                                                                                       |
| ceph-rbd-mirror        | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-restapi           | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-rgw-loadbanlancer | * `stable-4.0` √ <br>                                 |                                                                                                                                       |
| ceph-rgw               | * `stable-2.1` - `stable-4.0` √ <br>                  |                                                                                                                                       |
| ceph-validate          | * `stable-4.0` √ <br>                                 |                                                                                                                                       |

## CEPH-ANSIBLE 分支

| 分支       | 支持的 ceph 版本    | 依赖的 ansible 版本 |
| ---------- | ------------------- | ------------------- |
| stable-3.2 | `jewel`、`luminous` | `2.4`               |
| stable-3.2 | `luminous`、`mimic` | `2.4`               |
| stable-3.2 | `luminous`、`mimic` | `2.6`               |
| stable-4.0 | `nautilus`          | `2.7`               |
