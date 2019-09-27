# VSCode & GoLang

## 安装插件

1. Extensions -> 搜索 “go” -> 选择第一个并安装

## 配置

```json
// settings.json
{
    ...
    "go.buildOnSave": "workspace",
    "go.lintOnSave": "package",
    "go.vetOnSave": "package",
    "go.buildTags": "",
    "go.buildFlags": [],
    "go.lintFlags": [],
    "go.vetFlags": [],
    "go.coverOnSave": false,
    "go.useCodeSnippetsOnFunctionSuggest": false,
    "go.formatOnSave": true,
    "go.formatTool": "goreturns", // 打开任意一个 *.go 文件，VS Code 会提示安装相应的包，选择 “Install All”
    "go.goroot": "/usr/local/go",
    "go.gopath": "~/go",
    "go.gocodeAutoBuild": false
    ...
}
```
