# 导出 Extension

## 离线导出

1. 进入 <chrome://extensions>
2. 选择 **Developer mode**，然后复制 Extension ID
3. 进入（查询）插件存储目录

```bash
# Linux - Chrome
$ cd ~/.config/google-chrome/Default/Extensions/<ID>/<VERSION>

# Linux - Chromium
$ cd ~/.config/chromium/Default/Extensions/<ID>/<VERSION>
```

4. 回到 <chrome://extensions>，点击 **Pack extension** 按钮，在 `Extension root directory` 一栏中输入插件的具体路径，完成打包

## 在线导出

1. 访问 [Chrome Extension Downloader](https://chrome-extension-downloader.com/) 网站
2. 输入插件的 `web store url` 或 `Extension ID` 即可下载
3. 对于停更或不在 Chrome Store 的插件只能手动导出