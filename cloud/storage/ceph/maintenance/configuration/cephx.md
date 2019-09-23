# Ceph cephx 配置

## 部署方案

* ceph-deploy

* 手动部署

## 启用/禁用 cephx

* **启用**

```ini
[global]
#Clusters require authentication by default.
auth cluster required = cephx
auth service required = cephx
auth client required = cephx
```

* **禁用**

```ini
[global]
auth cluster required = none
auth service required = none
auth client required = none
```

## keyring

创建 `client.admin` keyring：

```sh
ceph auth get-or-create client.admin mon 'allow *' mds 'allow *' osd 'allow *' -o /etc/ceph/ceph.client.admin.keyring
```

创建 Monitor 集群所需的 keyring：

```sh
ceph-authtool --create-keyring /var/lib/ceph/mon/ceph-${id}/keyring--gen-key -n mon. --cap mon 'allow *'
```

为 OSD 生成 keyring：

```sh
ceph auth get-or-create osd.{$id} mon 'allow rwx' osd 'allow *' -o /var/lib/ceph/osd/ceph-{$id}/keyring
```

为 MDS 生成 keyring：

```sh
ceph auth get-or-create mds.{$id} mon 'allow rwx' osd 'allow *' mds 'allow *' -o /var/lib/ceph/mds/ceph-{$id}/keyring
```

## 配置选项

| 选项                  | 说明                                      | 描述                                                                           |
| --------------------- | ----------------------------------------- | ------------------------------------------------------------------------------ |
| auth cluster required | 可选值：`ceph` 或 `none`；默认值：`cephx` | 如果启用，集群守护进程（`ceph-mon`、`ceph-osd` 和 `ceph-mds`）之间必须相互认证 |
| auth service required | 可选值：`ceph` 或 `none`；默认值：`cephx` | 如果启用，集群守护进程要求客户端必须通过身份认证才能访问 Ceph 服务             |
| auth client required  | 可选值：`ceph` 或 `none`；默认值：`cephx` | 如果启用，客户端要求 Ceph 集群必须通过身份认证                                 |
