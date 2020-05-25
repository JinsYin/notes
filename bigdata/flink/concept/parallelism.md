# 并行度

* ① 系统级别 - 配置 `$FLINK_HOME/conf/flink-config.yaml`
* ② 客户端级别 - `$FLINK_HOME/bin/flink` 的 `-p` 参数
* ③ 运行时级别 - 设置 executaionEnvironment 方法
* ④ 算子级别 - 通过算子函数修改

优先级：① < ② < ③ < ④
并行度不能大于 slot 个数
