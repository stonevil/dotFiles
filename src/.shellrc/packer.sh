#!/usr/bin/env bash
# vim:ft=sh :

# Configure packer env
if command -v packer >/dev/null; then
	export PACKER_CACHE_DIR=~/.packer.d/cache
	export PACKER_ISO_DIR=~/.packer.d/iso
	export PACKER_BOX_DIR=~/.packer.d/box
	export PACKER_LOG_PATH=~/.packer.d/log
fi
