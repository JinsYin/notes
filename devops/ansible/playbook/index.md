# Ansible Playbook

Ansible 不只是能运行命令,它同样也拥有强大的配置管理和部署特性.

Ansible 脚本：Ansible Playbook 。

## 用法

```sh
$ ansible-playbook deploy.yml
```

## 关键字

| 关键字        | 含义                                                                                                     |
| ------------- | -------------------------------------------------------------------------------------------------------- |
| hosts         | 主机 IP，主机组名，或者关键字 `all`                                                                      |
| remote_user   | 远程主机用户名                                                                                           |
| vars          | 变量                                                                                                     |
| tasks         | 定义顺序执行的 action，每个 action 调用一个 module。action 语法：`module: module_parameter=module_value` |
| handers       | playbook 的 event。默认不会执行，在 action 中触发后才会执行，多次触发只执行一次。                        |
| become        | 切换成其他用户身份执行，可选值：`yes` 或 `no`                                                            |
| become_method | 与 become 一起用，可选值：`sudo`/`su`/`pfexec`/`doas`                                                    |
| become_user   |                                                                                                          |

```sh
# 脚本中使用 become 时，执行 playbook 可以加参数 --ask-become-pass，则执行时后提示输入 sudo 密码
$ ansible-playbook deploy.yml --ask-become-pass
```

### tasks

* 从上到下顺序执行；中途出错则整个 playbook 终止。
* 每个 task 即是对 module 的一次调用。
* 每个 task 应该有个 name（可选），便于可读。

基本写法：

```yaml
tasks
- name: make sure apache is started
  service: name=httpd state=started
```

如果参数较多，可以分多行写：

```yaml
tasks:
- name: make sure apache is started
  service:
    name: httpd
    state: started
```

执行提示：

```txt
TASK [make sure apache is started] *********************************************************************************************************************************************************************************
ok: [x.x.x.x]
```

执行状态：

* 如果任务被执行了，则 action 返回值为 `changed`
* 如果任务不需要执行（可能是以前已经执行过了），则 action 返回值为 `ok`

### handler（响应事件）

Playbook 的 handler 相当于主流编程语言的 event 机制。

* 每个 handler 是对 module 的一次调用
* 当在 tasks 中调用（`notify`）时才会被执行。
* 只有当 task 的返回状态为 changed 时，才会触发 handler 执行。
* handler 是按照在 `handlers` 定义的顺序执行的，而不是安装 `notify` 定义的顺序执行的。
* 所有任务执行完成之后才执行。

```yaml
- hosts: web
  remote_user: root
  vars:
    R1: "{{ 10000 | random }}"
    R2: "{{ 20000 | random }}"
  tasks:
  - name: Copy the /etc/hosts to /tmp/hosts.{{ R1 }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ R1 }}
    notify:
    - 3nd handler
  - name: Copy the /etc/hosts to /tmp/hosts.{{ R2 }}
    copy: src=/etc/hosts dest=/tmp/hosts.{{ R2 }}
    notify:
    - 2nd handler
    - 1nd handler
  handlers:
  - name: 1nd handler
    debug:
      msg: "define the 1nd handler"
  - name: 2nd handler
    debug:
      msg: "define the 2nd handler"
  - name: 3nd handler
    debug:
      msg: "define the 3nd handler"
```

输出：

```txt
PLAY [web] *********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************************************
ok: [192.168.1.224]
ok: [192.168.1.225]

TASK [Copy the /etc/hosts to /tmp/hosts.4107] **********************************************************************************************************************************************************************
changed: [192.168.1.224]
changed: [192.168.1.225]

TASK [Copy the /etc/hosts to /tmp/hosts.13231] *********************************************************************************************************************************************************************
changed: [192.168.1.224]
changed: [192.168.1.225]

RUNNING HANDLER [1nd handler] **************************************************************************************************************************************************************************************
ok: [192.168.1.224] => {
    "msg": "define the 1nd handler"
}
ok: [192.168.1.225] => {
    "msg": "define the 1nd handler"
}

RUNNING HANDLER [2nd handler] **************************************************************************************************************************************************************************************
ok: [192.168.1.224] => {
    "msg": "define the 2nd handler"
}
ok: [192.168.1.225] => {
    "msg": "define the 2nd handler"
}

RUNNING HANDLER [3nd handler] **************************************************************************************************************************************************************************************
ok: [192.168.1.224] => {
    "msg": "define the 3nd handler"
}
ok: [192.168.1.225] => {
    "msg": "define the 3nd handler"
}

PLAY RECAP *********************************************************************************************************************************************************************************************************
192.168.1.224              : ok=6    changed=2    unreachable=0    failed=0
192.168.1.225              : ok=6    changed=2    unreachable=0    failed=0
```

## Playbook 示例

### task

```yaml
- hosts: web
  remote_user: root
  vars:
    http_port: 80
    max_clients: 200
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest # 使用 yum 模块安装 httpd

  - name: Write the configuration file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
    notify:
    - restart apache

  - name: Write the default index.html file
    template: src=templates/index.html.j2 dest=/var/www/html/index.html

  - name: ensure apache is running
    service: name=httpd state=started
  handlers:
    - name: restart apache
      service: name=httpd state=restarted
```

tasks 中的每个 action 实际上就是对 module 的调用。

### role

role 就是将 task 写成文件。

```yaml
- hosts: remote
  roles:
    - common
    - docker
    - kubeadm
- hosts: registry[0]
  roles:
    - registry

- hosts: master
  roles:
    - master
    - deploy
- hosts: node
  roles:
    - node
- hosts: remote
  tasks:
    - name: Upload config file for kubelet
      template:
        src: "templates/01-pause.conf.j2"
        dest: "/etc/systemd/system/kubelet.service.d/01-pause.conf"
    - name: Enable kubelet service
      systemd:
        name: kubelet
        state: restarted
        enabled: yes
        daemon-reload: yes
```

## vars/vars_files

当变量较少时，可以使用 vars 关键字定义变量，并使用 `\{\{\}\}` 调用。当变量较多时可以将变量单独放到一个文件中。

定义和使用变量：

```yaml
- hosts: web
  remote_user: root
  vars:
    http_port: 80
  vars_files:
  - vars/server_vars.yml # http_host: 127.0.0.1
  tasks:
  - name: using-vars
    shell: echo {{ http_host }}:{{ http_port }} > /tmp/var1
```

变量是一个对象：

```yaml
- hosts: web
  remote_user: root
  vars:
    http:
      host: 127.0.0.1
      port: 80
  tasks:
  - name: using-vars
    shell: echo {{ http.host }}:{{ http['port'] }} > /tmp/var2
```

文件模板中使用变量：

Ansible 模板文件使用变量的语法是 Python 的模板引擎 [Jinja2](http://jinja.pocoo.org/)。

index.html.j2 ：

```html
<html>
<title>Demo</title>
<body>
<div class="block" style="height: 99%;">
    <div class="centered">
        <h1>#46 Demo {{ defined_name }}</h1>
        <p>Served by {{ ansible_hostname }} ({{ ansible_default_ipv4.address }})</p>
    </div>
</div>
</body>
</html>
```

```yaml
- hosts: web
  vars:
    http_port: 80
    defined_name: "Hello My name is Jingjng"
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest

  - name: Write the configuration file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
    notify:
    - restart apache

  - name: Write the default index.html file
    template: src=templates/index2.html.j2 dest=/var/www/html/index.html

  - name: ensure apache is running
    service: name=httpd state=started

  - name: insert firewalld rule for httpd
    firewalld: port={{ http_port }}/tcp permanent=true state=enabled immediate=yes

  handlers:
  - name: restart apache
    service: name=httpd state=restarted
```

* 将 task 的执行结果作为变量

注册变量经常与 `debug` module 一同使用，便于调试。

```yaml
- hosts: web
  tasks:
  - shell: pwd
    register: result
    ignore_errors: True
  - debug: msg={{ result.stdout }}
```

* 命令行传递变量

```yaml
- hosts: "{{ hosts }}" # 必须有引号
  remote_user: "{{ user }}"
  tasks:
  - debug: msg="Hello world"
```

```sh
# K/V 形式
ansible-playbook playbook.yml --extra-vars "hosts=web user=root"

# JSON 形式
ansible-playbook playbook.yml --extra-vars "{'hosts': 'web', 'user': 'root'}"

# 文件形式
ansible-playbook playbook.yml --extra-vars "@vars.json"
```

## 逻辑控制

### when

类似编程语言的 if 。

远程中的系统变量 facts 变量作为 when 的条件，用 `|int` 还可以转换返回值的类型。

```yaml
tasks:
- name: "shutdown Debian flavored systems"
  command: /sbin/shutdown -t now
  when: ansible_os_family == "Debian"
- debug: msg="only on Red Hat 7, derivatives, and later"
  when: ansible_os_family == "RedHat" and ansible_lsb.major_release|int >= 6
```

条件表达式：

```yaml
- hosts: web
  vars:
    value: true
  tasks:
  - shell: echo "TRUE"
    when: value
  - shell: echo "FALSE"
    when: no value
  - shell: echo "foo is defined"
    when: foo is defined
  - shell: echo "bar is not define"
    when: bar is not define
  - shell: echo {{ item }}
    with_items: [1 3 5 7 9]
    when: item > 5
```

与 include 一起使用：

```yaml
- include: tasks/sometasks.yml
  when: "'reticulating splines' in output"
```

与 role 一起使用：

```yaml
- hosts: web
  roles:
  - role: debian_stock_config
    when: ansible_os_family == 'Debian'
```

### loop

* 标准循环

```yaml
- hosts: web
  vars:
    list: ["Y1", "Y2"]
  tasks:
  - debug: msg={{ item }}
    with_items:
    - X1
    - X2
  - debug: msg={{ item }}
    with_items: "{{ list }}"
```

### block

## roles

## Ansible Galaxy

* [Galaxy](https://galaxy.ansible.com/)

## 参考

* [Ansible Examples](https://github.com/ansible/ansible-examples)
