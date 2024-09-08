#!/bin/bash

echo "[+] Running noVNC initialization script..."

VNC_HOST=$(hostname --all-ip-addresses | awk '{print $1}')
VNC_PORT=$((5900 + ${VNCPORT}))

VNC_IP="$VNC_HOST:$VNC_PORT"

if [ -n "${NOVNCPORT}" ]; then
    if [ ! -d "/noVNC" ]; then
        git clone https://github.com/novnc/noVNC.git /noVNC
    fi
    mv /tmp/novnc_redirect.html /noVNC/index.html
    # using sudo here will allow 'docker stop' to bring us down quickly
    exec sudo /noVNC/utils/novnc_proxy --vnc $VNC_IP --listen 0.0.0.0:$NOVNCPORT
fi

# todo: add https cert features
# todo: suppress log msg?