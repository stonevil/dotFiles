#!/usr/bin/env bash
# vim:ft=sh :

if [ -d "$HOME"/Development/xtensa-esp32-elf ]; then
	export XTENSA_PATH=$HOME/Development/xtensa-esp32-elf
	export PATH=$PATH:$XTENSA_PATH/bin
fi

if [ -d "$HOME"/Development/esp-idf ]; then
	export IDF_PATH=$HOME/Development/esp-idf
fi
