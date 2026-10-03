# ssr-plus-install

SSR Plus+ 一键安装脚本（mipsel_24kc）。

## OpenWrt 18.06

在路由器 SSH 里运行：

```sh
wget -qO- https://raw.githubusercontent.com/d5f6y7/openwrt-ssr-plus-build/main/install.sh | sh
```

脚本会自动识别版本，18.06 会安装 release tag `mipsel_24kc-openwrt-18.06` 的安装包（Shadowsocks 为 libev 版）。

## OpenWrt 24.10

同一条命令即可：

```sh
wget -qO- https://raw.githubusercontent.com/d5f6y7/openwrt-ssr-plus-build/main/install.sh | sh
```

24.10 会安装 tag `mipsel_24kc-openwrt-24.10` 的安装包（Shadowsocks 为 Rust 版）。

安装包来自 [d5f6y7/openwrt-ssr-plus-build](https://github.com/d5f6y7/openwrt-ssr-plus-build) 的 release。脚本仅支持 mipsel_24kc + OpenWrt 18.06 / 24.10，其他版本会直接报错退出。
