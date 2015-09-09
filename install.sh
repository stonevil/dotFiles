#!/bin/bash

# Install dotFiles
if [ -d $HOME/.Files ]; then
	echo "dotFiles already installed"
else
	if [ `curl -sL -w "%{http_code}\\n" "http://www.google.com/" -o /dev/null` -eq 200 ]; then
		# Clone dotFiles from git repository
		pushd $HOME && git clone https://github.com/stonevil/dotFiles.git $HOME/.Files && pushd $HOME/.Files && git pull --recurse-submodules && popd && popd
	fi
fi

if [ `curl -sL -w "%{http_code}\\n" "http://www.google.com/" -o /dev/null` -eq 200 ]; then
	# Read shell config file
	echo "Install everything releated"
	/bin/bash -c "source $HOME/.Files/conf/.bashrc && dotfiles-install-all && dotfiles-aliases-all"
fi
