#!/bin/bash

echo "Updating mirrorlist. Backup can be found at /etc/pacman.d/mirrorlist.bak"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlis
