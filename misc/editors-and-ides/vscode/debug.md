# Debug

调试设置入口：`Debug` > `Open Configurations`，对应的文件：`<项目目录>/.vscode/launch.json`。

## 调试快捷键

| 快捷键                 | 描述      |
| ---------------------- | --------- |
| <kbd>F5</kbd>          | 运行调试  |
| <kbd>F9</kbd>          | 切换断点  |
| <kbd>F10</kbd>         | Step over |
| <kbd>F11</kbd>         | Step in   |
| <kbd>Shift + F11</kbd> | Step out  |

## Go 语言

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "client",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "remotePath": "",
            "port": 2345,
            "host": "127.0.0.1",
            "program": "${fileDirname}",
            "env": {},
            "args": [],
            "showLog": true
        },
        {
            "name": "server",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "remotePath": "",
            "port": 2345,
            "host": "127.0.0.1",
            "program": "${workspaceRoot}/src/server",
            "env": {},
            "args": [],
            "showLog": true
        }
    ]
}
```

相关说明：

* `program` 中的 `${fileDirname}` 是以选中的文件作为启动点，该文件必须包含 `package main` 和 `main` 方法。
* `program` 中的 `${workspaceRoot}` 是以包名作为启动点。
* `env` 用于设置环境变量，比如 GOPATH；默认使用系统环境变量。
* [使用Visual Studio Code调试Golang工程](https://www.jianshu.com/p/75abf65462db)
