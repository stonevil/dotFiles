#!/usr/bin/env bash

# Install dotFiles
if [[ -d $HOME/.Files ]]; then
	echo "dotFiles already installed"
else
	# Clone dotFiles from git repository
	pushd $HOME && git clone https://github.com/stonevil/dotFiles.git $HOME/.Files && pusdh $HOME/.Files && git pull --recurse-submodules && popd && popd
	# Install everything
	source $HOME/conf/.zshrc
	dotfiles-install-all
fi
