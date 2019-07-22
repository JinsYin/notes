# 初始化服务

## Systemd（aria2.service）

```bash
$ vi /usr/lib/systemd/system/aria2.service
[Unit]
Description=Aria2c download manager
Requires=network.target
After=dhcpcd.service

[Service]
Type=forking
User=root
RemainAfterExit=yes
ExecStart=/usr/bin/aria2c --conf-path=~/.aria2/aria2.conf --daemon
ExecReload=/usr/bin/kill -HUP $MAINPID
RestartSec=1min
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## Upstart（Aria2 init.d script）

```bash
# chmod +x /etc/init.d/aria2c
$ vi /etc/init.d/aria2
#!/bin/sh
### BEGIN INIT INFO
# Provides:          Aria2
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop::    $network $local_fs $remote_fs
# Should-Start:      $all
# Should-Stop:       $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Aria2 - Download Manager
### END INIT INFO

NAME=aria2c
ARIA2C=/usr/bin/$NAME
PIDFILE=/var/run/$NAME.pid
CONF=/etc/aria2/aria2.conf
ARGS="--conf-path=${CONF}"
USER="www-data"
GROUP="www-data"

test -f $ARIA2C || exit 0

. /lib/lsb/init-functions

echo $PIDFILE

case "$1" in
start)  log_daemon_msg "Starting aria2c" "aria2c"
        start-stop-daemon --start --quiet -b -m --pidfile $PIDFILE --chuid $USER:$GROUP --startas $ARIA2C -- $ARGS
        ;;
stop)   log_daemon_msg "Stopping aria2c" "aria2c"
        start-stop-daemon --stop --quiet --pidfile $PIDFILE
        ;;
restart|reload|force-reload)
        log_daemon_msg "Restarting aria2c" "aria2c"
        start-stop-daemon --stop --retry 5 --quiet --pidfile $PIDFILE
        start-stop-daemon --start --quiet -b -m --pidfile $PIDFILE --chuid $USER:$GROUP --startas $ARIA2C -- $ARGS
        ;;
status)
        status_of_proc -p $PIDFILE $ARIA2C aria2c && exit 0 || exit $?
        ;;
*)      log_action_msg "Usage: /etc/init.d/aria2c {start|stop|restart|reload|force-reload|status}"
        exit 2
        ;;
esac
exit 0
```

* [Aria2 init.d script](https://gist.github.com/KyonLi/f8937a1f486bf35437d340b9e445e997)