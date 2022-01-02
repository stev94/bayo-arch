#!/bin/bash

if test -f ~/.config/.secrets; then
  source ~/.config/.secrets
fi

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/brave
