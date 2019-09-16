# GlusterFS 性能

## 性能调优

### 参数分析

```bash
$ gluster volume get gv0 all
Option                                  Value（默认值）            Describe                   
------                                  -----                    -----            
cluster.lookup-unhashed                 on                                      
cluster.lookup-optimize                 off                                     
cluster.min-free-disk                   10%                      剩余磁盘空间阈值；合法值：百分比
cluster.min-free-inodes                 5%                                      
cluster.rebalance-stats                 off                                     
cluster.subvols-per-directory           (null)                                  
cluster.readdir-optimize                off                                     
cluster.rsync-hash-regex                (null)                                  
cluster.extra-hash-regex                (null)                                  
cluster.dht-xattr-name                  trusted.glusterfs.dht                   
cluster.randomize-hash-range-by-gfid    off                                     
cluster.rebal-throttle                  normal                                  
cluster.lock-migration                  off                                     
cluster.local-volume-name               (null)                                  
cluster.weighted-rebalance              on                                      
cluster.switch-pattern                  (null)                                  
cluster.entry-change-log                on                                      
cluster.read-subvolume                  (null)                                  
cluster.read-subvolume-index            -1                                      
cluster.read-hash-mode                  1                                       
cluster.background-self-heal-count      8                                       
cluster.metadata-self-heal              on                                      
cluster.data-self-heal                  on                                      
cluster.entry-self-heal                 on                                      
cluster.self-heal-daemon                on                                      
cluster.heal-timeout                    600                                     
cluster.self-heal-window-size           1                                       
cluster.data-change-log                 on                                      
cluster.metadata-change-log             on                                      
cluster.data-self-heal-algorithm        (null)                                  
cluster.eager-lock                      on                                      
disperse.eager-lock                     on                                      
cluster.quorum-type                     none                                    
cluster.quorum-count                    (null)                                  
cluster.choose-local                    true                                    
cluster.self-heal-readdir-size          1KB                                     
cluster.post-op-delay-secs              1                                       
cluster.ensure-durability               on                                      
cluster.consistent-metadata             no                                      
cluster.heal-wait-queue-length          128                                     
cluster.favorite-child-policy           none                                    
cluster.stripe-block-size               128KB                    条带大小；合法值：字节
cluster.stripe-coalesce                 true                                    
diagnostics.latency-measurement         off                                     
diagnostics.dump-fd-stats               off                                     
diagnostics.count-fop-hits              off                                     
diagnostics.brick-log-level             INFO                                    
diagnostics.client-log-level            INFO                                    
diagnostics.brick-sys-log-level         CRITICAL                                
diagnostics.client-sys-log-level        CRITICAL                                
diagnostics.brick-logger                (null)                                  
diagnostics.client-logger               (null)                                  
diagnostics.brick-log-format            (null)                                  
diagnostics.client-log-format           (null)                                  
diagnostics.brick-log-buf-size          5                                       
diagnostics.client-log-buf-size         5                                       
diagnostics.brick-log-flush-timeout     120                                     
diagnostics.client-log-flush-timeout    120                                     
diagnostics.stats-dump-interval         0                                       
diagnostics.fop-sample-interval         0                                       
diagnostics.stats-dump-format           json                                    
diagnostics.fop-sample-buf-size         65535                                   
diagnostics.stats-dnscache-ttl-sec      86400                                   
performance.cache-max-file-size         0                                       
performance.cache-min-file-size         0                                       
performance.cache-refresh-timeout       1                        缓存刷新时间；缺省值（1s）；合法值：0-61
performance.cache-priority                                                      
performance.cache-size                  32MB                     缓存大小；缺省值（32MB）；合法值：字节               
performance.io-thread-count             16                       IO 线程数；缺省值（16）；合法值：0-65
performance.high-prio-threads           16                                      
performance.normal-prio-threads         16                                      
performance.low-prio-threads            16                                      
performance.least-prio-threads          1                                       
performance.enable-least-priority       on                                      
performance.cache-size                  128MB                                   
performance.flush-behind                on                                      
performance.nfs.flush-behind            on                                      
performance.write-behind-window-size    1MB                                     
performance.resync-failed-syncs-after-fsyncoff                                     
performance.nfs.write-behind-window-size1MB                                     
performance.strict-o-direct             off                                     
performance.nfs.strict-o-direct         off                                     
performance.strict-write-ordering       off                                     
performance.nfs.strict-write-ordering   off                                     
performance.lazy-open                   yes                                     
performance.read-after-open             no                                      
performance.read-ahead-page-count       4                                       
performance.md-cache-timeout            1                                       
performance.cache-swift-metadata        true                                    
performance.cache-samba-metadata        false                                   
performance.cache-capability-xattrs     true                                    
performance.cache-ima-xattrs            true                                    
features.encryption                     off                                     
encryption.master-key                   (null)                                  
encryption.data-key-size                256                                     
encryption.block-size                   4096                                    
network.frame-timeout                   1800                     请求等待时间；缺省值（1800s）；合法值：1-1800
network.ping-timeout                    42                       客户端等待时间；缺省值（42s）；合法值：0-42
network.tcp-window-size                 (null)                                  
features.lock-heal                      off                                     
features.grace-timeout                  10                                      
network.remote-dio                      disable                                 
client.event-threads                    2                                       
client.tcp-user-timeout                 0                                       
client.keepalive-time                   20                                      
client.keepalive-interval               2                                       
client.keepalive-count                  9                                       
network.tcp-window-size                 (null)                                  
network.inode-lru-limit                 16384                                   
auth.allow                              *                                       
auth.reject                             (null)                                  
transport.keepalive                     1                                       
server.allow-insecure                   (null)                                  
server.root-squash                      off                                     
server.anonuid                          65534                                   
server.anongid                          65534                                   
server.statedump-path                   /var/run/gluster                        
server.outstanding-rpc-limit            64                                      
features.lock-heal                      off                                     
features.grace-timeout                  10                                      
server.ssl                              (null)                                  
auth.ssl-allow                          *                                       
server.manage-gids                      off                                     
server.dynamic-auth                     on                                      
client.send-gids                        on                                      
server.gid-timeout                      300                                     
server.own-thread                       (null)                                  
server.event-threads                    1                                       
server.tcp-user-timeout                 0                                       
server.keepalive-time                   20                                      
server.keepalive-interval               2                                       
server.keepalive-count                  9                                       
transport.listen-backlog                10                                      
ssl.own-cert                            (null)                                  
ssl.private-key                         (null)                                  
ssl.ca-list                             (null)                                  
ssl.crl-path                            (null)                                  
ssl.certificate-depth                   (null)                                  
ssl.cipher-list                         (null)                                  
ssl.dh-param                            (null)                                  
ssl.ec-curve                            (null)                                  
transport.address-family                inet                                    
performance.write-behind                on                       先写入缓存内，在写入硬盘，以提高写入的性能。               
performance.read-ahead                  on                       预读方式提高读取的性能，利于频繁持续性的访问文件，当应用完成当前数据块读取的时候，下一个数据块就已经准备好了
performance.readdir-ahead               on                                      
performance.io-cache                    on                       缓存已经被读过的数据               
performance.quick-read                  on                       优化读取小文件的性能               
performance.open-behind                 on                                      
performance.nl-cache                    off                                     
performance.stat-prefetch               on                                      
performance.client-io-threads           off                                     
performance.nfs.write-behind            on                                      
performance.nfs.read-ahead              off                                     
performance.nfs.io-cache                off                                     
performance.nfs.quick-read              off                                     
performance.nfs.stat-prefetch           off                                     
performance.nfs.io-threads              off                                     
performance.force-readdirp              true                                    
performance.cache-invalidation          false                                   
features.uss                            off                                     
features.snapshot-directory             .snaps                                  
features.show-snapshot-directory        off                                     
network.compression                     off                                     
network.compression.window-size         -15                                     
network.compression.mem-level           8                                       
network.compression.min-size            0                                       
network.compression.compression-level   -1                                      
network.compression.debug               false                                   
features.limit-usage                    (null)                                  
features.default-soft-limit             80%                                     
features.soft-timeout                   60                                      
features.hard-timeout                   5                                       
features.alert-time                     86400                                   
features.quota-deem-statfs              off                                     
geo-replication.indexing                off                                     
geo-replication.indexing                off                                     
geo-replication.ignore-pid-check        off                                     
geo-replication.ignore-pid-check        off                                     
features.quota                          off                                     
features.inode-quota                    off                                     
features.bitrot                         disable                                 
debug.trace                             off                                     
debug.log-history                       no                                      
debug.log-file                          no                                      
debug.exclude-ops                       (null)                                  
debug.include-ops                       (null)                                  
debug.error-gen                         off                                     
debug.error-failure                     (null)                                  
debug.error-number                      (null)                                  
debug.random-failure                    off                                     
debug.error-fops                        (null)                                  
nfs.disable                             on                       关闭 NFS 服务；缺省值（off）；合法值：off|on
features.read-only                      off                                     
features.worm                           off                                     
features.worm-file-level                off                                     
features.default-retention-period       120                                     
features.retention-mode                 relax                                   
features.auto-commit-period             180                                     
storage.linux-aio                       off                                     
storage.batch-fsync-mode                reverse-fsync                           
storage.batch-fsync-delay-usec          0                                       
storage.owner-uid                       -1                                      
storage.owner-gid                       -1                                      
storage.node-uuid-pathinfo              off                                     
storage.health-check-interval           30                                      
storage.build-pgfid                     off                                     
storage.gfid2path                       on                                      
storage.gfid2path-separator             :                                       
storage.bd-aio                          off                                     
cluster.server-quorum-type              off                                     
cluster.server-quorum-ratio             0                                       
changelog.changelog                     off                                     
changelog.changelog-dir                 (null)                                  
changelog.encoding                      ascii                                   
changelog.rollover-time                 15                                      
changelog.fsync-interval                5                                       
changelog.changelog-barrier-timeout     120                                     
changelog.capture-del-path              off                                     
features.barrier                        disable                                 
features.barrier-timeout                120                                     
features.trash                          off                                     
features.trash-dir                      .trashcan                               
features.trash-eliminate-path           (null)                                  
features.trash-max-filesize             5MB                                     
features.trash-internal-op              off                                     
cluster.enable-shared-storage           disable                                 
cluster.write-freq-threshold            0                                       
cluster.read-freq-threshold             0                                       
cluster.tier-pause                      off                                     
cluster.tier-promote-frequency          120                                     
cluster.tier-demote-frequency           3600                                    
cluster.watermark-hi                    90                                      
cluster.watermark-low                   75                                      
cluster.tier-mode                       cache                                   
cluster.tier-max-promote-file-size      0                                       
cluster.tier-max-mb                     4000                                    
cluster.tier-max-files                  10000                                   
cluster.tier-query-limit                100                                     
cluster.tier-compact                    on                                      
cluster.tier-hot-compact-frequency      604800                                  
cluster.tier-cold-compact-frequency     604800                                  
features.ctr-enabled                    off                                     
features.record-counters                off                                     
features.ctr-record-metadata-heat       off                                     
features.ctr_link_consistency           off                                     
features.ctr_lookupheal_link_timeout    300                                     
features.ctr_lookupheal_inode_timeout   300                                     
features.ctr-sql-db-cachesize           12500                                   
features.ctr-sql-db-wal-autocheckpoint  25000                                   
features.selinux                        on                                      
locks.trace                             off                                     
locks.mandatory-locking                 off                                     
cluster.disperse-self-heal-daemon       enable                                  
cluster.quorum-reads                    no                                      
client.bind-insecure                    (null)                                  
features.shard                          off                                     
features.shard-block-size               64MB                                    
features.scrub-throttle                 lazy                                    
features.scrub-freq                     biweekly                                
features.scrub                          false                                   
features.expiry-time                    120                                     
features.cache-invalidation             off                                     
features.cache-invalidation-timeout     60                                      
features.leases                         off                                     
features.lease-lock-recall-timeout      60                                      
disperse.background-heals               8                                       
disperse.heal-wait-qlength              128                                     
cluster.heal-timeout                    600                                     
dht.force-readdirp                      on                                      
disperse.read-policy                    round-robin                             
cluster.shd-max-threads                 1                                       
cluster.shd-wait-qlength                1024                                    
cluster.locking-scheme                  full                                    
cluster.granular-entry-heal             no                                      
features.locks-revocation-secs          0                                       
features.locks-revocation-clear-all     false                                   
features.locks-revocation-max-blocked   0                                       
features.locks-monkey-unlocking         false                                   
disperse.shd-max-threads                1                                       
disperse.shd-wait-qlength               1024                                    
disperse.cpu-extensions                 auto                                    
disperse.self-heal-window-size          1                                       
cluster.use-compound-fops               off                                     
performance.parallel-readdir            off                                     
performance.rda-request-size            131072                                  
performance.rda-low-wmark               4096                                    
performance.rda-high-wmark              128KB                                   
performance.rda-cache-limit             10MB                                    
performance.nl-cache-positive-entry     false                                   
performance.nl-cache-limit              10MB                                    
performance.nl-cache-timeout            60                                      
cluster.brick-multiplex                 off                                     
cluster.max-bricks-per-process          0                                       
disperse.optimistic-change-log          on                                      
cluster.halo-enabled                    False                                   
cluster.halo-shd-max-latency            99999                                   
cluster.halo-nfsd-max-latency           5                                       
cluster.halo-max-latency                5                                       
cluster.halo-max-replicas               99999                                   
cluster.halo-min-replicas               2
```

### 调优操作

```bash
# 调整卷的缓存大小
$ gluster volume set gv0 performance.cache-size 64M

# 查看卷的缓存大小
$ gluster volume get gv0 performance.cache-size
Option                                  Value                                   
------                                  -----                                   
performance.cache-size                  32MB
```


## 参考

* [GlusterFS 缺点分析](http://blog.sina.com.cn/s/blog_6b89db7a0101gbcy.html)
* [分布式存储之 GlusterFS 高性能优化实践](https://www.liuliya.com/archive/736.html)