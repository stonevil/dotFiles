#!/usr/bin/env bash

# Install dotFiles
if [[ -d $HOME/.Files ]]; then
	echo "dotFiles already installed"
else
	# Clone dotFiles from git repository
	pushd $HOME && git clone https://github.com/stonevil/dotFiles.git $HOME/.Files && pusdh $HOME/.Files && git pull --recurse-submodules && popd && popd
fi

# Read shell config file
echo "Detecting shell"
CURRENT_SHELL=`echo $0`
# Install everything
echo "Install everything releated"
case $CURRENT_SHELL in
	bash)	echo "BASH. Yikes!"
				source $HOME/conf/.bashrc
				dotfiles-install-all
				;;
	zsh)	echo "ZSH. You cool!"
				source $HOME/conf/.zshrc
				dotfiles-install-all
				;;
	*)		echo "Not supported shell"
				;;
esac
