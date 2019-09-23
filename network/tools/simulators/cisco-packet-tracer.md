# Cisco Packet Tracer

## 安装（Ubuntu）

访问 <https://www.netacad.com/group/offerings/packet-tracer/>，需要先登录再下载，下载完成后正常安装即可。

```sh
# 安装完成后需要 Desktop launcher desktop（安装目录为 ~/packet-tracer）
$ cp ~/packet-tracer/bin/Cisco-PacketTracer.desktop ~/.local/share/applications/

# 修改默认的配置
$ sed -i -e "s|Exec=.*|Exec=~/packet-tracer/packettracer|g" -e "s|Icon=.*|Icon=~/packet-tracer/art/app.png|g" ~/.local/share/applications/Cisco-PacketTracer.desktop

$ chmod +x ~/.local/share/applications/Cisco-PacketTracer.desktop
```
