# ImgBot

## 优化流程

1. 在 Github Marketplace 搜索并安装 `imgbot`，并将其应用到相应项目或所有项目
2. 安装完成后，如果对应项目存在可优化的图片，ImgBot 会自动创建一个 `imgbot` 分支并完成优化提交，同时发起一个 PR
3. 合并此 PR（“rebase and merge”）
4. 手动删除 `imgbot` 分支，或者等待 ImgBot 自动删除
