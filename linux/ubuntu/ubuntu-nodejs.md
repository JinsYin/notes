# Ubuntu Node.js 环境

## 安装 nodejs

```bash
$ sudo apt-get install -y nodejs
$ sudo ln -s /usr/bin/nodejs /usr/bin/node
$ node -v # v0.10.25
```

## 安装 npm

```bash
$ sudo apt-get install -y npm
$ npm -v # 1.3.10
```

## node 版本管理

```bash
$ npm install -g n
```

## 安装常用版本

```bash
$ n 0.10.25
$ n 0.10.48
$ n 0.12.0
$ n 0.12.18
$ n lts
$ n stable
```

## 常用操作

```bash
$ n list # 查询安装版本
$ n v0.10.25 # 切换版本
$ node -v
$ npm -v
```

## 安装 express4 生成器

```bash
$ npm install -g express-generator@4
```

## 使用 express 生成 web 应用

```bash
$ express --view ejs --git myapp # --git 会添加 .gitignore 文件
$ cd myapp && npm install && npm start # 启动
```

> curl http://127.0.0.1:3000


## pm2

```bash
$ npm install -g pm2 # 安装
$ pm2 start app.js # 任务
$ pm2 list # 列表
$ pm2 logs -f [app-name] # 日志
$ pm2 describe [app-name] # 详情
$ pm2 restart/reload/stop/delete [app-name] # 操作
$ pm2 scale [app-name] 10 # 伸缩
```