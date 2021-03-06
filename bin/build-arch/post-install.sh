#!/bin/bash

set -ex

confirm() {

  local _prompt _response

  if [ "$1" ]; then _prompt="$1"; else _prompt="Are you sure"; fi
  _prompt="$_prompt [y/n] ?"

  # Loop forever until the user enters a valid response (Y/N or Yes/No).
  while true; do
    read -r -p "$_prompt " _response
    case "$_response" in
      [Yy][Ee][Ss]|[Yy]) # Yes or Y (case-insensitive).
        return 0
        ;;
      [Nn][Oo]|[Nn])  # No or N.
        return 1
        ;;
      *) # Anything else (including a blank) is invalid.
        ;;
    esac
  done
}

CURR_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$CURR_DIR"/../..

read -r -p "Enter computer name: " hostname
read -r -p "Enter a new user name: " username

echo "Setting the root password"
passwd

echo "Creating user"
useradd -m -G wheel -s /bin/bash "$username"
usermod --append --groups wheel "$username"
sed --in-place=.bak 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
passwd "$username"

echo "Installing the GRUB bootloader"
read -r -p "Enter boot disk name (e.g. /dev/sdX): " bootdevice
pacman -S grub efibootmgr dosfstools os-prober mtools --noconfirm
if [ -d /sys/firmware/efi ]; then
  mkdir /boot/EFI
  mount "$bootdevice"1 /boot/EFI  #Mount FAT32 EFI partition
  grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
else
  lsblk
  read -r -p "Enter boot disk name (e.g. /dev/sdX): " bootdevice
  grub-install --target=i386-pc "$bootdevice"
fi
grub-mkconfig -o /boot/grub/grub.cfg

read -r -p "Enter the timezone in the format Time/Zone: " timezone
timedatectl set-timezone "$timezone"
#ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
#hwclock --systohc

echo "Setting locale"
sed --in-place=.bak -e 's/^#en_US\.UTF-8/en_US\.UTF-8/' -e 's/^#it_IT\.UTF-8/it_IT\.UTF-8/' /etc/locale.gen
locale-gen
cat << EOF > /etc/locale.conf
LANG=en_US.UTF-8
LC_ADDRESS=it_IT.UTF-8
LC_IDENTIFICATION=it_IT.UTF-8
LC_MEASUREMENT=it_IT.UTF-8
LC_MONETARY=it_IT.UTF-8
LC_NAME=it_IT.UTF-8
LC_NUMERIC=it_IT.UTF-8
LC_PAPER=it_IT.UTF-8
LC_TELEPHONE=it_IT.UTF-8
LC_TIME=it_IT.UTF-8
EOF
echo "KEYMAP=it" > /etc/vconsole.conf
localectl set-keymap it
localectl --no-convert set-x11-keymap it pc104 ,qwerty grp:win_space_toggle

echo "Configuring hostname"
echo "$hostname" > /etc/hostname

echo "Setting up Xorg drivers"
confirm "Do you want to install the Intel driver" && pacman -S --noconfirm mesa xf86-video-intel
confirm "Do you want to install the AMD driver" && pacman -S --noconfirm mesa xf86-video-amdgpu
confirm "Do you want to install the NVIDIA driver" && pacman -S --noconfirm nvidia nvidia-utils

echo "Installing main packages"
INSTALL_DIR="$ROOT_DIR"/packages
pacman -Syyu
grep -v "#" "$INSTALL_DIR"/pacmanlist.txt | pacman -S --noconfirm -

echo "Setting up coloring in pacman"
sed --in-place=.bak 's/^#COLOR/COLOR/' /etc/pacman.conf

#################
# Setting up UI #
#################
echo "Setting up lightdm"
sed --in-place=.bak -e "s/#autologin-user=.*/autologin-user=$USER/g" \
                    -e "s/#autologin-session=.*/autologin-session=i3/g" \
                    -e "s/#greeter-session=.*/greeter-session=lightdm-gtk-greeter/g" \
                    /etc/lightdm/lightdm.conf
systemctl enable lightdm

#####################
# Starting services #
#####################
echo "Enabling boot services"
systemctl enable sshd
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cronie.service
systemctl enable tlp.service
systemctl enable NetworkManager-dispatcher.service
# mask to avoid conflicts
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

####################
# SETTING ROOT ZSH #
####################
#mkdir -p /etc/zsh
#cp -r "$ROOT_DIR"/configs/zsh/etc /etc/zsh

#################
## ADD CRONJOBS #
#################
echo "Installing cronjobs"
bash "$ROOT_DIR"/bin/build-arch/add-cronjobs.sh

###################
## SWITCHING USER #
###################
echo "Login with $username user"
su "$username" <<EOF

  ROOT_DIR=/home/bayo-arch

  echo "Creating default folders"
  mkdir -p ~/.config
  cp "$ROOT_DIR"/configs/user-dirs.dirs ~/.config/
  ##  xdg-user-dirs-update
  bash "$ROOT_DIR"/bin/build-arch/set-dirs.sh

  echo "Installing yay"
  cd ~/packages
  git clone https://aur.archlinux.org/yay.git
  sudo chown -R "$username":users ./yay
  cd yay
  makepkg -si --noconfirm
  grep -v "#" "$INSTALL_DIR"/aur.txt | yay -S --noconfirm -

  ##############
  # Setting i3 #
  ##############
  cd ~/.config
  cp -r "$ROOT_DIR"/configs/i3 .

  cp -r "$ROOT_DIR"/configs/conky .
  chmod +x conky/*.lua

  cp -r "$ROOT_DIR"/configs/dunst .
  chmod +x dunst/alert.sh

  # copy configs
  cp "$ROOT_DIR"/configs/home/* ~/

  # install oh-y-zsh
  bash "$ROOT_DIR"/bin/build-arch/set-zsh.sh

  # Copying background image
  cp -r "$ROOT_DIR"/data/media/wallpapers ~/media/pics/

  # install grub theme
  bash "$ROOT_DIR"/bin/build-arch/install-grub-theme.sh

  # setting wallpaper
  cp "$ROOT_DIR"/data/media/wallpapers/fractal-br.jpg /usr/share/backgrounds/
EOF

#echo "Setting theme"
#cp -r /usr/share/themes/Adapta-Nokto/gtk-3.0/ ~/.config/
#cat << EOF > /home/"$username"/.config/gtk-3.0/settings.ini
#[Settings]
#gtk-icon-theme-name=Papirus-Adapta-Nokto
#gtk-theme-name=Adapta-Nokto
#gtk-cursor-theme-name=xcursor-breeze
#gtk-font-name=Noto Sans 10
#gtk-xft-antialias=1
#gtk-xft-hinting=1
#gtk-xft-hintstyle=hintslight
#gtk-xft-rgba=rgb
#gtk-application-prefer-dark-theme=true
#gtk-cursor-theme-size=0
#gtk-toolbar-style=GTK_TOOLBAR_BOTH
#gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
#gtk-button-images=1
#gtk-menu-images=1
#gtk-enable-event-sounds=1
#gtk-enable-input-feedback-sounds=1
#EOF
#yay -S --noconfirm xcursor-breeze

