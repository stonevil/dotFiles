#!/usr/bin/env bash
# vim:ft=sh :

# Configure Go ENV
export GOPATH=$HOME/.golang
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH
export GO111MODULE=on
if [ ! -d "$GOPATH" ]; then
	mkdir -p "$GOPATH"
fi
