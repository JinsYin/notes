教程：
	http://blog.csdn.net/weiqiangsu/article/details/46956977/
	

1. 安装ss-qt5

	sudo add-apt-repository ppa:hzwhuang/ss-qt5

	sudo apt-get update

	sudo apt-get install shadowsocks-qt5

	包依赖问题：
		sudo apt-get -f install libappindicator1 libindicator7

	启动：
		sudo ss-qt5 

		相应命令：ssserver

2. 添加代理ip信息，并在本地开一个代理（默认127.0.0.1，端口1080）

3. chrome安装switchomega插件

	https://github.com/FelisCatus/SwitchyOmega/releases

	下载crx并拖到chrome://plugins

4.浏览器配置 (或者直接使用“系统代理”，不用其他配置)

	gfwlist: https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
