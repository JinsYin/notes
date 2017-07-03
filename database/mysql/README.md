# Mysql 从入门到放弃

# version
mysql:5.7.17 (140 MB)
mysql/mysql-server:5.7.17 (84 MB)
phpmyadmin/phpmyadmin: 4.6.6-2 (32MB)

# Dockerfile
https://github.com/docker-library/mysql/blob/master/5.7/Dockerfile
https://github.com/mysql/mysql-docker/blob/mysql-server/5.7/Dockerfile
https://github.com/phpmyadmin/docker/blob/master/Dockerfile

# command line (docker0 --> 172.17.42.1)
docker run -it --name mysql -p 3306:3306 -v mysql_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST=172.17.42.1 -d mysql:5.7.17
docker run -it --name mysql -p 3306:3306 -v mysql_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST=172.17.42.1 -d mysql/mysql-server:5.7.17

# remove container
docker rm -f mysql && docker volume rm mysql_data

# cluster
mysql/mysql-cluster

# software client

# web client
docker run -it --name phpmyadmin -p 8080:80 -v phpmyadmin_data:/sessions -e PMA_HOST=192.168.0.100 -e PMA_PORT=3306 -e PMA_USER=root -e PMA_PASSWORD=123456 -d  phpmyadmin/phpmyadmin:4.6.6-2
docker run -it --name phpmyadmin -p 8080:80 -v phpmyadmin_data:/sessions -e PMA_HOSTS='192.168.1.101:3306,192.168.1.102:3306' -e PMA_USER=root -e PMA_PASSWORD=123456 -d  phpmyadmin/phpmyadmin:4.6.6-2
docker rm -f phpmyadmin && docker volume rm phpmyadmin_data

# Command line client (sudo apt-get install mysql-client)
mysql -h 127.0.0.1 -P 3306 -u root -p123456

# ERROR1:
	ERROR 1130 (HY000): Host '172.17.42.1' is not allowed to connect to this MySQL server

	yy:
		docker exec -it mysql mysql -u root -p123456
		SELECT host FROM mysql.user WHERE User = 'root'; 
		(容器的localhost不同于主机的localhost)

	jjbf:
		1)
		-e MYSQL_ROOT_HOST=172.17.42.1
		-e MYSQL_ROOT_HOST=%

		2) 
		CREATE USER 'root'@'%' IDENTIFIED BY '123456';
		GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
		FLUSH PRIVILEGES;

# ERROR2:
	ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock'

	jjbf:
		1) mysql -h 127.0.0.1 -P 3306 -u root -p123456	# 使用127.0.0.1代替默认的localhost
		2) mysql -u root --protocol=tcp -p123456