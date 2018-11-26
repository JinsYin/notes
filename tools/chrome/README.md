# Google Chrome

## 安装

```bash
# Chrome
$ sudo apt-cache policy google-chrome-stable
$ sudo apt-get install google-chrome-stable=${YOUR-VERSION}

# Chromium
$ sudo apt-cache policy chromium-browser
$ sudo apt-get install chromium-browser=${YOUR-VERSION}
```

## 帮助

* [chrome://chrome-urls/](chrome://chrome-urls/)
* Flash 支持

```bash
% apt-get install adobe-flashplugin
```

## 插件

Chrome 插件分为 [extension](chrome://extensions/) 和 [app](chrome://apps/)。

### Extension

* [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)
* [Postman Interceptor](https://chrome.google.com/webstore/detail/postman-interceptor/aicmkgpgakddgnaphhhpliifpcfhicfo)
* [划词翻译](https://chrome.google.com/webstore/detail/%E5%88%92%E8%AF%8D%E7%BF%BB%E8%AF%91/ikhdkkncnoglghljlkmcimlnlhkeamad)
* [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall)

### App

* [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop)
* [马克飞象](https://chrome.google.com/webstore/detail/marxico/kidnkfckhbdkfgbicccmdggmpgogehop/related)

## 导出 Extension

方法一：

1. 访问 <chrome://extensions>
2. 选择 Developer mode，此时每个插件都会显示一个 ID，复制相应插件的 ID
3. 进入插件目录 `~/.config/google-chrome/Default/Extensions/<ID>/<VERSION>` 或 `~/.config/chromium/Default/Extensions/<ID>/<VERSION>`
4. 访问 <chrome://extensions>，点击 Pack extension 按钮，在 Extension root directory 一栏中输入上面的路径即可打包插件

方法二：

通过 [Chrome Extension Downloader](https://chrome-extension-downloader.com/) 网站下载插件，支持通过 web store url 和 extension ID 两种方式，但是对于停更的插件只能手动导出。