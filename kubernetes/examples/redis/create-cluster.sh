#!/usr/bin/env bash
 redis_count=`kubectl get pod -o wide -l app=redis | grep Running | wc -l`
 #echo "redis_count:"$redis_count
 if [ $redis_count -ne 6 ]; then
 echo "the running redis count: ${redis_count} is error"
 exit 1
 fi
 redis_blue_ips=`kubectl get pod -o wide -l app=redis -l member=redis-blue | awk 'NR>1{printf $6":6379 "}'
 redis_green_ips=`kubectl get pod -o wide -l app=redis -l member=redis-green | awk 'NR>1{printf $6":6380 "}'
 redis_ips=$redis_blue_ips" "$redis_green_ips
 echo "redis_ips:"$redis_ips
 redis_blue_name=`kubectl get pod -o wide -l app=redis -l member=redis-blue | grep Running | awk '{printf $1" "}'
 #echo $redis_ips | awk -F' ' '{for( i=1;i<NF; i++ ) print $i}' `` kubectl create -f redis-cluster.yaml bash create_cluster.sh