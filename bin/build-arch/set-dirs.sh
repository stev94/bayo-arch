#!/usr/bin/env zsh

mkdir -p desktop
mkdir -p documents
mkdir -p media
mkdir -p media/music
mkdir -p media/videos
mkdir -p media/pics
mkdir -p downloads
mkdir -p documents/templates
mkdir -p code
mkdir -p notes
mkdir -p work
mkdir -p packages
mkdir -p public

rm -rf Desktop Documents Music Downloads Pictures Public Videos Templates

cp "$ROOT_DIR"/configs/user-dirs.dirs ~/.config/
#  xdg-user-dirs-update