#!/bin/bash

set -ex

CUR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Current dir is $CUR_DIR"

##############
# PARTITIONS #
##############
echo "Preparing disk. NOTE: You need at least 5 GB of free space"
echo "Creating partitions: grub (512 MiB), swap (4 GiB), root (remaining)"
fdisk -l
read -r -p "Enter the disk to partition: (e.g. /dev/sda): " disk
if [ -d /sys/firmware/efi ]; then
  sgdisk -n 0:0:+512MiB -t 0:ef00 -c 0:efi "$disk"
  mkfs.fat -F32 "$disk"1
  mkdir /mnt/boot
  mount "$disk"1 /mnt/boot
else
  # if not UEFI system create boot partition
  sgdisk -n 0:0:+512MiB -t 0:ef02 -c 0:efi "$disk"
fi
sgdisk -n 0:0:+4GiB -t 0:8200 -c 0:swap "$disk"
sgdisk -n 0:0:0 -t 0:8300 -c 0:root "$disk"
lsblk

echo "Formatting partitions"
mkswap "$disk"2
mkfs.ext4 "$disk"3

echo "Mounting partitions"
mount "$disk"3 /mnt
swapon "$disk"2

###############
# CONF SYSTEM #
###############
echo "Updating the system clock"
timedatectl set-ntp true
timedatectl status

echo "Check Mirror list"
pacman -Syy
# To update the mirror and sorts it by download speed
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -S --noconfirm reflector
reflector -c "IT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

echo "Installing base packages (base, linux, linux-firmware)"
pacstrap /mnt base base-devel linux linux-firmware

echo "Configuring the system"
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

echo "Executing post-init script"
cp -r /root/bayo-arch /mnt/home
arch-chroot /mnt /bin/bash /home/bayo-arch/bin/build-arch/post-install.sh

umount -R /mnt

echo "All Done. Type 'reboot' to enjoy!"
