.DEFAULT_GOAL := help
SHELL := /usr/bin/zsh

.PHONY: help
help:							## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$'  $(MAKEFILE_LIST) | sort | awk -F: '{printf "%s: %s\n", $$2, $$3}' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: refresh-pacman-list
refresh-pacman-list: 				## Refresh mirror list
	@pacman -Syyu

.PHONY: install
install:							## Install arch-i3
	@echo "Welcome to bayo-arch :D. Starting building..."
	@cd $(CURDIR)/bin/build-arch && sh install.sh

.PHONY: backup-arch
backup-arch: 						## Backup arch-i3
	@echo "Welcome to backup-bayo-arch :D. Starting backing up..."
	@cd $(CURDIR)/bin/backup-arch && sh backup.sh
