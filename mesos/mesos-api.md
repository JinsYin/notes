# Mesos API

## 查询任务和框架

```bash
$ curl -XGET http://leader.mesos:5050/master/tasks # 查询所有运行任务
$ curl -XGET http://leader.mesos:5050/master/frameworks # 查询所有框架（含每个框架运行的任务）
```

## 从框架中 kill 任务 （忘了是否都有效）

```
$ curl -XPOST http://leader.mesos:5050/api/v1/scheduler -H 'Content-Type:application/json; Accept:application/json; Connection:close' -d '{
   "type": "SUBSCRIBE",
   "subscribe"  : {
      "framework_info"  : {
        "user" :  "yin",
        "name" :  "chronos"
      }
  }
}'
````

```
$ curl -XPOST http://leader.mesos:5050/api/v1/scheduler -H 'Content-Type: application/json' -d '{
	"type": "KILL",
	"kill": {
		"task_id": {"value": "ct:1488934800861:0:test-ping:"}
	}
}'
```

```
$ curl -XPOST http://leader.mesos:5050/api/v1/scheduler -H 'Content-Type: application/json;Mesos-Stream-Id' -d '{
	"framework_id": {"value" : "7d93d301-2845-46a8-b406-c7a6c4edd3b6-0001"},
	"type": "KILL",
	"kill": {
		"task_id":  {"value" : "ct:1488934800861:0:test-ping:"},
		"agent_id":  {"value" : "7d93d301-2845-46a8-b406-c7a6c4edd3b6-S8"}
	}
}'
```

## 撤销框架

```
$ curl -XPOST http://leader.mesos:5050/api/v1/scheduler -H 'Content-Type: application/json' -d '{
	"framework_id": {"value": "7d93d301-2845-46a8-b406-c7a6c4edd3b6-0017"},
	"type": "TEARDOWN"
}'
```

```
$ curl -XPOST http://leader.mesos:5050/master/teardown -d 'frameworkId=7d93d301-2845-46a8-b406-c7a6c4edd3b6-0014'
```

```
$ /opt/spark/sbin/stop-mesos-dispatcher.sh
```
