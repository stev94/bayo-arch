# Install Arch-i3

Boot your Arch image and follow the [installation doc](https://wiki.archlinux.org/title/installation_guide)

## Before Installation

1. Set the console keyboard layout
```console
# List available layouts
# ls /usr/share/kbd/keymaps/**/*.map.gz
loadkeys it
```

2. Verify the boot mode
```console
ls /sys/firmware/efi/efivars
```
If the command shows the directory without error, then the system is booted in
UEFI mode. If the directory does not exist, the system may be booted in BIOS
(or CSM) mode. If the system did not boot in the mode you desired, refer to your
motherboard's manual.

3. Connect to the internet
```console
# to show the list of available network adapters
ip link         
# set up the adapter
ip link set enp0s3  up
# verify your connection
ping archlinux.org
```

4. Prepare partitions
- To create ext4 file system
```console
mkfs.ext4 /dev/root_partition
```
- To setup a partition for swap (at least 512 MB)
```console
mkswap /dev/swap_partition
```

- Mount the partitions
```console
mount /dev/root_partition /mnt
```
- Enable Swap
```console
swapon /dev/swap_partition
```

Root partition -> /mnt
Efi partition -> /mnt/efi (At least 260 MB)
## Install

```console
curl https://raw.githubusercontent.com/stev94/myi3config/main/new/install.sh -o install.sh
bash install.sh
```

## i3

[Arch i3 guide](https://wiki.archlinux.org/title/i3)
[i3-online-color-config](https://thomashunter.name/i3-configurator/)

# The ~/.Xresources should contain a line such as
#     *color0: #121212
# and must be loaded properly, e.g., by using
#     xrdb ~/.Xresources
# This value is picked up on by other applications (e.g., the URxvt terminal
# emulator) and can be used in i3 like this:
#set_from_resource $black i3wm.color0 #000000

## Security

Start reading [this](https://wiki.archlinux.org/title/Security)


## Tools

- [Pacman](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
- [i3-guide](https://i3wm.org/docs/userguide.html#exec)
- [xsh](https://github.com/sgleizes/xsh)
