#!/usr/bin/env bash
# vim:ft=sh :

# Docker Machine
export MACHINE_STORAGE_PATH=$HOME/.docker/storage
export MACHINE_CPU_COUNT="2"
export MACHINE_MEMORY_SIZE="4096"
export MACHINE_DISK_SIZE="40960"

if command -v docker-machine >/dev/null; then
	alias docker-create-vb='docker-machine create --driver virtualbox --virtualbox-cpu-count $MACHINE_CPU_COUNT --virtualbox-memory $MACHINE_MEMORY_SIZE --virtualbox-disk-size $MACHINE_DISK_SIZE --virtualbox-ui-type "headless"'
	alias docker-env-default='eval "$(docker-machine env default)"'

	if [ "$(docker-machine status default)" = "Running" ]; then
		eval "$(docker-machine env default)"
	fi
fi
