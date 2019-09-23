# 进程标识符（Process identifiers）

```sh
$ man credentials
```

* 进程 ID（PID）
* 父进程 ID（PPID）
* 进程组 ID 和会话 ID（SID）
* 用户和组标识符

## 进程凭证

每个进程都有一套用数字表示的用户 ID（UID）和组 ID（GID），这些 ID 称之为 _进程凭证（Process credentials）_。具体如下：

* _实际用户 ID（real user ID）_ 和 _实际组 ID（real group ID）_
* _有效用户 ID（effective user ID）_ 和 _有效组 ID（effective group ID）_
* 保存的 set-user-ID（saved set-user-ID） 和 保存的组 set-group-ID（saved set-group-id）
* 文件系统用户 ID （file-system ID）和文件系统组 ID （file-system group ID）
* 辅助组 ID（Supplementary group IDs）

| 

## 参考

* [credentials - process identifiers](http://man7.org/linux/man-pages/man7/credentials.7.html)
