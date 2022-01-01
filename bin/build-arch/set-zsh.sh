#!/bin/bash

ZSH=~/.config/zsh/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --unattended)"
cp "$ROOT_DIR"/configs/zsh/.zprofile ~/.config/zsh/
cp "$ROOT_DIR"/configs/zsh/.zshrc ~/.config/zsh/
cp "$ROOT_DIR"/configs/zsh/alias ~/.config/zsh/
cp "$ROOT_DIR"/configs/zsh/functions ~/.config/zsh/
cp "$ROOT_DIR"/configs/zsh/bayo.zsh-theme ~/.config/zsh/oh-my-zsh/custom/themes/
