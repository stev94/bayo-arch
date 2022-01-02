#!/usr/bin/zsh

#        (1)  Linux           (10)  MX Linux        (19)  Kali Linux
#        (2)  Debian          (11)  PopOS           (20)  Parrot OS
#        (3)  Ubuntu          (12)  ArchStrike
#        (4)  Manjaro         (13)  BlackArch
#        (5)  Arch Linux      (14)  EndeavourOS
#        (6)  Windows 11      (15)  Gentoo Linux
#        (7)  Linux Mint      (16)  Pentoo Linux
#        (8)  Void Linux      (17)  Zorin OS
#        (9)  Fedora          (18)  Red Hat

THEME="13"

cd /tmp || exit
git clone --depth 1 https://github.com/vandalsoul/darkmatter-grub2-theme.git
cd darkmatter-grub2-theme || exit
printf "%s" "$THEME" | sudo python install.py
cd /tmp && rm -rf darkmatter-grub2-theme
