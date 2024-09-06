#!/bin/bash

echo "[!] Setting wallpaper for XFCE..."

#  xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/image-style -n -t int -s 0
#  xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -n -t string -s /tmp/wpimg
#  xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/rgba1 -n -t double -s 0.180392 -t double -s 0.0.203922 -t double -s 0.250980 -t double -s 1.000000

# for PROP in `xfconf-query --channel xfce4-desktop --list`; do
#   xfconf-query --channel xfce4-desktop --property ${PROP} -n -t string -s /tmp/wallpaper.jpg
# done

xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/image-style -n -t int -s 3
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -n -t string -s /tmp/wallpaper.png

echo "[+] Done."