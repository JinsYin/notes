# Charles

* HTTP 代理服务器
* HTTP 监听器
* 反向代理服务器

## MacOS

1. 配置系统代理：
   1. 打开 HTTP 代理：菜单栏 > “Proxy Settings” > “Proxies” > 设置 HTTP 代理端口 > 勾选 ”Enable transparent HTTP proxying“
   2. 系统接入代理：菜单栏 > “Proxy” > 勾选 “macOS Proxy”（需要先授权）
   3. 验证系统代理：“打开网络偏好设置” > ”高级“ > ”代理“ > 点击 HTTP 代理和 HTTPS 代理查看步骤 2 是否已生效（如果在使用 Shadowsocks 需要取消 ”自动代理配置“）
2. 开始抓包：菜单栏 > “Proxy” > 勾选 “Start Recording”
3. HTTPS 支持（默认只抓取 HTTP 封包）：
   1. “菜单栏” > “Help” > “SSL Proxying” > “Install Charles Root Certificate”
   2. “钥匙串” 中点击打开 “Charles Proxy CA” > 在 “信任” 栏的 “使用证书时” 选择 “始终信任”
   3. “菜单栏” > “Proxy” > “SSL Proxying Settings” > “SSL Proxying” > 点击 “Add” 按钮添加一个空规则 > 直接点击 “OK”（不填写任何信息表示 `*`，即所有网站） 【这一步貌似不设置才能工作】
4. 停止使用 Charles 后记得取消系统代理（步骤 1.3），否则无法上网

## IOS

1. 确保 IOS 设备与 Charles 服务器在同一局域网
2. 获取 Charles 服务器的 IP
3. IOS > “设置” > “无线局域网” > 点击已连接的网络 > “配置代理” > “手动” > 填写 Charles 代理服务器的 IP 和端口
4. 打开 Charlse 授权 “Allow”
5. HTTPS 支持：
   1. Help -> SSL Proxying -> Install Charles Root Certificate on a Mobile Device
   2. IOS > Safari > 访问 `chls.pro/ssl` > 安装 Chales Proxy CA 证书
   3. 重启应用程序

## 参考

* [Charles 抓包入门（Mac/iOS，HTTP/HTTPS）](https://www.jianshu.com/p/e8dd1091d6d7)
