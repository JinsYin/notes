1. 修改密码：

	sudo passwd (表示当前用户)

	sudo passwd other_user

2. 列出所有group：sudo groups

3. 列出所有用户：

4. 添加新用户：

	sudo useradd -m new_user -s /bin/bash (-m创建/home/new_user目录，-s指定使用的shell)

	接着设置密码：sudo passwd new_user

	增加管理员权限(尽量)：sudo adduser new_user sudo （不是useradd）

5. 删除用户：

	sudo userdel an_user

	sudo rm -r /home/an_user

6. 修改用户名：sudo usermod -l new_username old_username

7. 切换到其他用户：su - other_user
