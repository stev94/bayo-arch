#!/bin/bash

if test -f ~/.config/.secrets; then
  source ~/.config/.secrets
fi

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/brave
export SHELL=/usr/bin/zsh
export ZDOTDIR=/home/stev/.config/zsh