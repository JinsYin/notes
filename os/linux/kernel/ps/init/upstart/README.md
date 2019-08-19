# Upstart

```sh
# Ubuntu 14.04
$ pstree
init─┬─ModemManager───2*[{ModemManager}]
     ├─NetworkManager───3*[{NetworkManager}]
     ├─accounts-daemon───2*[{accounts-daemon}]
     ├─acpid
     ├─avahi-daemon───avahi-daemon
     ├─bluetoothd
     ├─colord───2*[{colord}]
     ├─console-kit-dae───64*[{console-kit-dae}]
     ├─cron
     ├─cups-browsed
     ├─dbus-daemon
     ├─2*[dnsmasq]
     ├─dockerd─┬─docker-containe─┬─docker-containe─┬─redis-server───3*[{redis-server}]
     │         │                 │                 └─8*[{docker-containe}]
     │         │                 ├─docker-containe─┬─ss-local
     │         │                 │                 └─8*[{docker-containe}]
     │         │                 ├─docker-containe─┬─mongod───25*[{mongod}]
     │         │                 │                 └─8*[{docker-containe}]
     │         │                 ├─docker-containe─┬─entrypoint.sh───find
     │         │                 │                 └─8*[{docker-containe}]
     │         │                 └─17*[{docker-containe}]
     │         └─16*[{dockerd}]
     ├─6*[getty]
     ├─gnome-keyring-d───5*[{gnome-keyring-d}]
     ├─irqbalance
     ├─kerneloops
     ├─libvirtd───10*[{libvirtd}]
     ├─lightdm─┬─Xorg
     │         ├─lightdm─┬─init─┬─at-spi-bus-laun─┬─dbus-daemon
     │         │         │      │                 └─3*[{at-spi-bus-laun}]
     │         │         │      ├─at-spi2-registr───{at-spi2-registr}
     │         │         │      ├─bamfdaemon───3*[{bamfdaemon}]
     │         │         │      ├─chromium-browse─┬─chromium-browse───chromium-browse─┬─23*[chromium-browse───12*[{chromium-browse}]]
     │         │         │      │                 │                                   ├─40*[chromium-browse───13*[{chromium-browse}]]
     │         │         │      │                 │                                   ├─chromium-browse───7*[{chromium-browse}]
     │         │         │      │                 │                                   ├─2*[chromium-browse───15*[{chromium-browse}]]
     │         │         │      │                 │                                   ├─2*[chromium-browse───14*[{chromium-browse}]]
     │         │         │      │                 │                                   └─chromium-browse───8*[{chromium-browse}]
     │         │         │      │                 ├─chromium-browse─┬─chromium-browse
     │         │         │      │                 │                 └─7*[{chromium-browse}]
     │         │         │      │                 └─38*[{chromium-browse}]
     │         │         │      ├─code─┬─code─┬─code─┬─bash
     │         │         │      │      │      │      ├─code───20*[{code}]
     │         │         │      │      │      │      ├─2*[code───12*[{code}]]
     │         │         │      │      │      │      └─23*[{code}]
     │         │         │      │      │      ├─code───17*[{code}]
     │         │         │      │      │      ├─code───8*[{code}]
     │         │         │      │      │      └─code───12*[{code}]
     │         │         │      │      ├─code───5*[{code}]
     │         │         │      │      └─30*[{code}]
     │         │         │      ├─2*[dbus-daemon]
     │         │         │      ├─dconf-service───2*[{dconf-service}]
     │         │         │      ├─evolution-calen───4*[{evolution-calen}]
     │         │         │      ├─evolution-sourc───2*[{evolution-sourc}]
     │         │         │      ├─fcitx───{fcitx}
     │         │         │      ├─fcitx-dbus-watc
     │         │         │      ├─gconfd-2
     │         │         │      ├─glib-pacrunner───{glib-pacrunner}
     │         │         │      ├─gnome-session─┬─anydesk─┬─anydesk───3*[{anydesk}]
     │         │         │      │               │         └─2*[{anydesk}]
     │         │         │      │               ├─compiz───7*[{compiz}]
     │         │         │      │               ├─deja-dup-monito─┬─deja-dup───3*[{deja-dup}]
     │         │         │      │               │                 └─3*[{deja-dup-monito}]
     │         │         │      │               ├─gnome-user-shar───2*[{gnome-user-shar}]
     │         │         │      │               ├─nautilus───3*[{nautilus}]
     │         │         │      │               ├─nm-applet───2*[{nm-applet}]
     │         │         │      │               ├─polkit-gnome-au───3*[{polkit-gnome-au}]
     │         │         │      │               ├─telepathy-indic───2*[{telepathy-indic}]
     │         │         │      │               ├─unity-fallback-───2*[{unity-fallback-}]
     │         │         │      │               ├─update-notifier───3*[{update-notifier}]
     │         │         │      │               ├─zeitgeist-datah───6*[{zeitgeist-datah}]
     │         │         │      │               └─3*[{gnome-session}]
     │         │         │      ├─gnome-terminal─┬─2*[bash───ssh]
     │         │         │      │                ├─bash───sudo───bash───pstree
     │         │         │      │                ├─gnome-pty-helpe
     │         │         │      │                └─3*[{gnome-terminal}]
     │         │         │      ├─gvfs-afc-volume───2*[{gvfs-afc-volume}]
     │         │         │      ├─gvfs-gphoto2-vo───{gvfs-gphoto2-vo}
     │         │         │      ├─gvfs-mtp-volume───{gvfs-mtp-volume}
     │         │         │      ├─gvfs-udisks2-vo───2*[{gvfs-udisks2-vo}]
     │         │         │      ├─gvfsd───{gvfsd}
     │         │         │      ├─gvfsd-burn───{gvfsd-burn}
     │         │         │      ├─gvfsd-fuse───4*[{gvfsd-fuse}]
     │         │         │      ├─gvfsd-metadata───{gvfsd-metadata}
     │         │         │      ├─gvfsd-trash───2*[{gvfsd-trash}]
     │         │         │      ├─hud-service───3*[{hud-service}]
     │         │         │      ├─indicator-appli───{indicator-appli}
     │         │         │      ├─indicator-bluet───2*[{indicator-bluet}]
     │         │         │      ├─indicator-datet───5*[{indicator-datet}]
     │         │         │      ├─indicator-keybo───3*[{indicator-keybo}]
     │         │         │      ├─indicator-messa───3*[{indicator-messa}]
     │         │         │      ├─indicator-power───2*[{indicator-power}]
     │         │         │      ├─indicator-sessi───2*[{indicator-sessi}]
     │         │         │      ├─indicator-sound───3*[{indicator-sound}]
     │         │         │      ├─mission-control───2*[{mission-control}]
     │         │         │      ├─pgyvpn_svr───9*[{pgyvpn_svr}]
     │         │         │      ├─pulseaudio───3*[{pulseaudio}]
     │         │         │      ├─4*[sh───watershed]
     │         │         │      ├─sh───watershed───sh───system-crash-no───2*[{system-crash-no}]
     │         │         │      ├─sogou-qimpanel───10*[{sogou-qimpanel}]
     │         │         │      ├─sogou-qimpanel-
     │         │         │      ├─synergy─┬─synergys───2*[{synergys}]
     │         │         │      │         └─8*[{synergy}]
     │         │         │      ├─unity-files-dae───7*[{unity-files-dae}]
     │         │         │      ├─unity-music-dae───2*[{unity-music-dae}]
     │         │         │      ├─unity-panel-ser───2*[{unity-panel-ser}]
     │         │         │      ├─unity-scope-hom───2*[{unity-scope-hom}]
     │         │         │      ├─unity-scope-loa───3*[{unity-scope-loa}]
     │         │         │      ├─unity-settings-───3*[{unity-settings-}]
     │         │         │      ├─unity-video-len───{unity-video-len}
     │         │         │      ├─2*[upstart-dbus-br]
     │         │         │      ├─upstart-event-b
     │         │         │      ├─upstart-file-br
     │         │         │      ├─window-stack-br
     │         │         │      ├─xfconfd
     │         │         │      ├─zeitgeist-daemo───{zeitgeist-daemo}
     │         │         │      └─zeitgeist-fts─┬─cat
     │         │         │                      └─2*[{zeitgeist-fts}]
     │         │         └─{lightdm}
     │         └─2*[{lightdm}]
     ├─mysqld───16*[{mysqld}]
     ├─nmbd
     ├─ntpd
     ├─pgyvpn_monitor─┬─pgyvpn───2*[{pgyvpn}]
     │                └─sleep
     ├─polkitd───2*[{polkitd}]
     ├─rpc.idmapd
     ├─rpc.statd
     ├─rpcbind
     ├─rsyslogd───3*[{rsyslogd}]
     ├─rtkit-daemon───2*[{rtkit-daemon}]
     ├─smbd───2*[smbd]
     ├─sshd
     ├─systemd-journal
     ├─systemd-logind
     ├─systemd-udevd
     ├─teamviewerd───14*[{teamviewerd}]
     ├─thermald───{thermald}
     ├─udisksd───4*[{udisksd}]
     ├─upowerd───2*[{upowerd}]
     ├─upstart-file-br
     ├─upstart-socket-
     ├─upstart-udev-br
     ├─vmnet-bridge
     ├─2*[vmnet-dhcpd]
     ├─vmnet-natd
     ├─2*[vmnet-netifup]
     ├─vmware-authdlau
     ├─vmware-hostd───16*[{vmware-hostd}]
     ├─vmware-usbarbit
     ├─vmware-vmblock-───2*[{vmware-vmblock-}]
     ├─whoopsie───2*[{whoopsie}]
     ├─winbindd───winbindd
     ├─xrdp
     └─xrdp-sesman
```