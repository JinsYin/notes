# Synergy

Synergy 可以帮助我们在多台 PC（支持 Linux、Windows、MacOS）之间共享某台 PC 的鼠标和键盘，也就是说，利用 Synergy 我们可以使用某台 PC 的鼠标和键盘（该 PC 称为 _Server_）通过局域网控制其他 PC（称为 _Client_）。

## 要求

* 各 PC 必须连接在同一个局域网
* 只能有一个 Server，可以有多个 Client
* 各 PC 的 Synergy 版本保持一致

## 安装

下载地址（macOS/Linux/Windows）：<https://sourceforge.net/projects/synergy-stable-builds/>

## 配置

### Server（连接鼠标和键盘的 PC）

1. 前往 Synergy 的 `Edit > Settings` 设置本机的 Screen name
2. 选择 `Server` 复选框 > 选择 `Configure interactively` 选项 > 点击 `configure server...` 按钮
3. 按照 PC 的位置拖拽电脑图标完成相应布局，双击电脑图标修改各 Client 的 Screen name
4. Start

### Client（受控制的 PC）

1. 前往 Synergy 的 `Edit > Settings` 设置本机的 Screen name
2. 选择 `Server` 复选框 > 填写 Server IP
3. Start