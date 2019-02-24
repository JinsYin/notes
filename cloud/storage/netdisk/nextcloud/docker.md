# Docker 部署 Nextcloud

```sh
$ docker run -d --name nextcloud \
  -p 8888:80 \
  --restart=always \
  --env TZ="Asia/Shanghai" \
  nextcloud:production
```