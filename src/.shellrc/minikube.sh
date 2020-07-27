#!/usr/bin/env bash
# vim:ft=sh :

export MINIKUBE_CPU_COUNT="2"
export MINIKUBE_MEMORY_SIZE="4gb"
export MINIKUBE_DISK_SIZE="40gb"

if command -v minikube >/dev/null; then
	alias minikube-create='minikube start --cpus=$MINIKUBE_CPU_COUNT --memory=$MINIKUBE_MEMORY_SIZE --disk-size=$MINIKUBE_DISK_SIZE --extra-config=apiserver.authorization-mode=RBAC'
fi
