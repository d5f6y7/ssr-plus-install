#!/bin/sh
# SSR Plus+ 一键安装脚本（mipsel_24kc / OpenWrt 24.10）
# 用法：wget -qO- https://cdn.jsdelivr.net/gh/d5f6y7/ssr-plus-install/install.sh | sh

REPO="d5f6y7/openwrt-ssr-plus-build"
TAG="mipsel_24kc-openwrt-24.10"
TMPDIR="/tmp/ssr-plus-ipk"

echo "== SSR Plus+ 一键安装 =="

if ! command -v opkg >/dev/null 2>&1; then
  echo "错误：未找到 opkg，请在 OpenWrt 路由器上运行。"
  exit 1
fi

if ! opkg print-architecture 2>/dev/null | grep -q "mipsel_24kc"; then
  echo "警告：当前架构似乎不是 mipsel_24kc，继续安装可能失败。"
fi

echo "获取 release 文件列表..."
API_URL="https://api.github.com/repos/${REPO}/releases/tags/${TAG}"
URLS=$(wget -qO- "$API_URL" 2>/dev/null | grep -o '"browser_download_url": *"[^"]*\.ipk"' | sed 's/^"browser_download_url": *"//;s/"$//')

if [ -z "$URLS" ]; then
  echo "错误：release ${TAG} 中没有找到 ipk（构建可能还没完成）。"
  exit 1
fi

mkdir -p "$TMPDIR"
for u in $URLS; do
  echo "下载 $(basename "$u") ..."
  wget -O "$TMPDIR/$(basename "$u")" "$u" || { echo "下载失败：$u"; exit 1; }
done

echo "安装 ipk ..."
opkg update
opkg install $TMPDIR/*.ipk
opkg install luci-i18n-base-zh-cn 2>/dev/null || true

rm -rf "$TMPDIR"
echo "== 安装完成，请刷新 LuCI，在 服务 里找 ShadowsocksR Plus+ =="
