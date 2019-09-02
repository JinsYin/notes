# 用户管理

## 认证和授权

Ceph 默认启用了身份认证（authentication）和授权（authorization），所以必须要指定 `用户名` 和 `keyring`（包含相应用户的 SecretKey）。如果没有指定用户名，默认会使用 `client.admin` 作为用户名。如果没有指定 keyring，默认从配置中查找。

以下操作是等价的：

```sh
# 没有指定用户名和 keyring
$ ceph health

# 如果 keyring 包含多个用户的 SecretKey，则使用 client.admin 用户的
$ ceph --keyring=/etc/ceph/ceph.client.admin.keyring -n client.admin health
```

环境变量可以避免重复输入：

```sh
% export CEPH_ARGS="--name client.jins --keyring ceph.jins.alice.keyring --conf ceph.conf"
% ceph health
```

## 概念

### 用户（身份认证）

**用户** 是用于身份认证的唯一标识，用于控制谁可以访问 Ceph 集群（包括存储池和池中数据）。

**用户** 由 `用户类型` 和 `用户 ID` 组成，即 `USER = TYPE.ID`。其中，**{TYPE}** 可以是 `client`、`osd`、`mon`、`mds`、`mgr` 或 `auth`；**{ID}** 可以是 `用户名` 或 `守护进程 ID`。对于命令行而言，如果指定的是 `--user`/`--id` 则必须省略用户类型；如果指定的是 `--name`/`-n` 则必须指定用户类型和用户 ID 。

`用户类型` 几乎总是 `client`，之所以要指定用户类型，是因为 ceph-mon、ceph-osd、ceph-mds 也使用 cephx 协议，但它们并不是客户端。区分用户类型有助于区分客户端用户和其他用户，可以简化访问控制及用户管理。

> Note：**Ceph 存储集群用户** 不同于 **Ceph 对象存储用户** 或 **Ceph 文件系统用户**。Ceph 对象网关与存储集群之间使用 **Ceph 存储集群用户** 进行通信，但对象网关为终端用户提供了自己的用户管理功能。Ceph 文件系统使用 POSIX 语义，其关联的用户空间与 Ceph 存储用户也不相同。

### 授权（caps）

Ceph 使用 `能力`（capabilities, `caps`）来描述对认证用户的授权，只有得到授权的认证用户才能使用 Monitor、OSD、MDS 的相应功能。`caps` 用于限制用户对某存储池内数据或某个命名空间的访问。

Caps 语法形式：

```plain
{daemon-type} 'allow {capability}' [{daemon-type} 'allow {capability}']
```

| daemon-type | capability                                                                            | template                                                                |
| ----------- | ------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| mon         | `r`、`w`、`x`、`profile {cap}`                                                        | mon 'allow rwx' <br/> mon 'allow profile osd'                           |
| osd         | `r`、`w`、`x`、`class-read`、`class-write` 和 `profile osd`（支持 pool 和 namespace） | osd 'allow {capability}' [pool={poolname}] [namespace={namespace-name}] |
| mds         | `allow` 或空白                                                                        | mds 'allow'                                                             |

> Note：Ceph 对象网关守护进程（`radosgw`）是 Ceph 存储集群的一种客户端（用户类型为 `client`），所以它没有被表示成一种独立的 Ceph 存储集群守护进程类型

Caps：

| caps                                | 描述                                                                                                                          |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| allow                               | 在守护进程的访问设置之前，仅对 MDS 隐含 `rw`                                                                                  |
| r                                   | 授予用户读取权限；Monitor 需要它才能获取 CRUSH MAP                                                                            |
| w                                   | 授予用户写入权限                                                                                                              |
| x                                   | 授予用户调用类方法的能力（即读和写），以及在 Monitor 上执行身份验证操作                                                       |
| class-read                          | 授予用户调用类读取方法的能力理；`x` 的子集                                                                                    |
| class-write                         | 授予用户调用类写入方法的能力理；`x` 的子集                                                                                    |
| *                                   | 授予用户对某守护进程/存储池的读、写和执行权限，以及执行管理命令的能力                                                         |
| profile osd（限 Monitor）           | 授权用户以 OSD 身份连接其他 OSD 或 Monitor 的权限                                                                             |
| profile mds（限 Monitor）           | 授权用户以 MDS 身份连接其他 MDS 或 Monitor 的权限                                                                             |
| profile bootstrap-osd（限 Monitor） | 授权用户引导 OSD 的权限。比如授予部署工具（ceph-disk、ceph-deploy），以便有权添加密钥                                         |
| profile bootstrap-mds（限 Monitor） | 授权用户引导 MDS 的权限。比如收取部署工具（ceph-deploy），以便引导 MDS 时有权添加密钥                                         |
| profile rbd (Monitor and OSD)       | 授予用户操作 RBD 镜像的权限。当用作 Monitor cap 时，提供 RBD 客户端所需的最小权限。当用作 OSD cap 时，提供 RBD 客户端读写权限 |
| profile rbd-read-only (限 OSD)      | 授予用户对 RBD 镜像的只读权限                                                                                                 |

> Note：Ceph 对象存储网关守护进程（radosgw）是 Ceph 存储集群的一种客户端，所有没被表示成一种独立的 Ceph 存储集群守护进程类型

## 管理用户

用户管理功能使 Ceph 存储集群管理员能够直接在 Ceph 存储集群中创建、更新和删除用户。

* **罗列用户**

```sh
$ ceph auth list # -o {filename}
installed auth entries:

mds.0 # TYPE.ID
    key: AQCwt2pbmzt9JhAAYUIv+XoKCwpT5joN7lXKzQ==
    caps: [mds] allow
    caps: [mon] allow profile mds
    caps: [osd] allow *
osd.0
    key: AQCtt2pbkLl9DhAAoZstUkMWGxrJGcjumgmk3g==
    caps: [mon] allow profile osd
    caps: [osd] allow *
client.admin # TYPE.ID
    key: AQCrt2pbdgMZIhAAQ1MZrvFqDdpdt2Rl1m+hvw==
    auid: 0
    caps: [mds] allow
    caps: [mon] allow *
    caps: [osd] allow *
client.radosgw.gateway
    key: AQCwt2pbZ172MRAAfJQu8N/K6R9LIdLy0rsgPg==
    caps: [mon] allow rw
    caps: [osd] allow rwx
mgr.Yin
    key: AQC2t2pbMxJnHRAAL6JYUks3cUcc5cgkHSWJng==
    caps: [mon] allow *
```

`key` 用于身份验证，`caps` 用于在 ceph-mon、ceph-osd 或 ceph-mds 上读取、写入或执行

* **获取用户**

```sh
# ceph auth get {TYPE.ID}
# ceph auth export {TYPE.ID}
# 返回 keyring （包括用户名、密钥和 caps）
$ ceph auth get cllient.admin # -o client.admin.keyring
[client.admin]
    key = AQCrt2pbdgMZIhAAQ1MZrvFqDdpdt2Rl1m+hvw==
    auid = 0
    caps mds = "allow"
    caps mon = "allow *"
    caps osd = "allow *"
```

* **查看用户密钥**

```sh
# 密钥用于身份认证
# ceph auth print-key {TYPE}.{ID}
# ceph auth get-key {TYPE}.{ID}
$ ceph auth get-key client.admin
AQCrt2pbdgMZIhAAQ1MZrvFqDdpdt2Rl1m+hvw==
```

* **新增用户**

| 命令                          | 描述                                                            |
| ----------------------------- | --------------------------------------------------------------- |
| `ceph auth add`               | 将创建用户、生成密钥并添加任何指定的 caps                       |
| `ceph auth get-or-create`     | 同上，并返回 keyfile（含用户名和密钥）                          |
| `ceph auth get-or-create-key` | 创建用户并返回密钥。对只需要密钥的客户端是有用的（如：libvirt） |

```sh
$ ceph auth add client.jins mon 'allow r' osd 'allow rw pool=rbd'
added key for client.jins

# 返回 keyfile（含用户名和密钥），但通常保存为 keyring （因为 keyfile 是 keyring 的子集，而客户端通常只需要用户名和密钥，而不需要 caps）
$ ceph auth get-or-create client.alice mon 'allow r' osd 'allow rw pool=rbd' # -o alice.keyring
[client.alice]
    key = AQBuUHFbboP9HxAAuInIgH0ZeUmju5VJ3r1rsw==

# 返回密钥
$ ceph auth get-or-create-key client.bob mon 'allow r' osd 'allow rw pool=rbd' # -o bob.key
AQAoSXJbf7onOBAATiKenOQUTtuO+N4PU+oTEg==
```

`keyfile` 是 `keyring` 的子集。

> Note：如果 OSD caps 没有限定存储池，将允许用户访问所有存储池

* **修改用户 caps**

语法：

```sh
ceph auth caps USERTYPE.USERID {daemon} 'allow [r|w|x|*|...] [pool={pool-name}] [namespace={namespace-name}]' [{daemon} 'allow [r|w|x|*|...] [pool={pool-name}] [namespace={namespace-name}]']
```

例如：

```sh
$ ceph auth get client.jins
[client.jins]
    key = AQCiS3JbZcf+GhAAO7/32Osh5vhVu9QaEwGgMA==
    caps mon = "allow r"
    caps osd = "allow rw pool=rbd"

$ ceph auth caps client.jins mon 'allow r' osd 'allow rw pool=kube'
updated caps for client.jins

$ ceph auth caps client.jins mon 'allow rw' osd 'allow rwx pool=kube'
updated caps for client.jins

$ ceph auth caps client.brian-manager mon 'allow *' osd 'allow *'
updated caps for client.brian-manager
```

清除 caps：

```sh
ceph auth caps client.ringo mon ' ' osd ' '
```

* **删除用户**

```sh
# ceph auth rm {TYPE}.{ID}
# ceph auth del {TYPE}.{ID}
$ ceph auth del client.ringo
updated
```

* **导入用户**

```sh
# 导入一个或多个用户
# ceph auth import -i /path/to/keyring
$ ceph auth import -i /etc/ceph/ceph.keyring
```

## 密钥环（keyring）管理

Ceph 客户端使用以下四个 keyring 作为默认设置，因此不必在配置文件中设置 keyring 。

* `/etc/ceph/$cluster.$name.keyring`：`$name` 即用户名，由 `用户类型` 和 `用户 ID` 组成（比如，`client.admin` 对应 `ceph.client.admin.keyring`）；适合保存单个用户的 keyring 。
* `/etc/ceph/$cluster.keyring`：`$cluster` 是指由 Ceph 配置文件名所定义的集群名（比如，`ceph.conf` 的集群名为 `ceph`）；适合保存多个用户的 keyring 。
* `/etc/ceph/keyring`
* `/etc/ceph/keyring.bin`

命令行选项 `--keyring` 用于指定 keyring 的路径，所指定的 keyring 只需包含完整的用户名和密钥即可（一个或多个），不需要包含 caps 。

After you create a user (e.g., client.ringo), you must get the key and add it to a keyring on a Ceph client so that the user can access the Ceph Storage Cluster.

* **创建 keyring**

```sh
# 创建一个空的 keyring
# ceph-authtool --create-keyring/-C /path/to/keyring
$ ceph-authtool -C /etc/ceph/ceph.keyring
```

* **将用户加入 keyring**

```sh
#
$ ceph auth get client.jins -o /etc/ceph/ceph.client.jins.keyring

ceph-authtool /etc/ceph/ceph.keyring --import-keyring /etc/ceph/ceph.client.admin.keyring
```

* **创建用户**

```sh
# 新用户仅存在与 keyring 中，不会加入到 Ceph 存储集群
$ ceph-authtool -n client.ringo --cap osd 'allow rwx' --cap mon 'allow rwx' /etc/ceph/ceph.keyring

# 如果需要加入到 Ceph 存储集群，必须
$ ceph auth add client.ringo -i /etc/ceph/ceph.keyring
```

* **修改用户属性**

```sh
$ ceph-authtool /etc/ceph/ceph.keyring -n client.ringo --cap osd 'allow rwx' --cap mon 'allow rwx'

$ ceph auth import -i /etc/ceph/ceph.keyring
```