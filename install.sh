#!/usr/bin/env bash

# Install dotFiles
if [[ -d $HOME/.Files ]]; then
	echo "dotFiles already installed"
else
	cd $HOME && git clone https://github.com/stonevil/dotFiles.git $HOME/.Files && cd $HOME/.Files && git pull --recurse-submodules
fi

# Install homebrew
if [[ -d $HOME/.homebrew ]]; then
	cd $HOME && mv -f $HOME/.homebrew $HOME/.homebrew.previous
fi
cd $HOME && git clone https://github.com/Homebrew/homebrew.git $HOME/.homebrew
$HOME/.homebrew/bin/brew update && $HOME/.homebrew/bin/brew upgrade --all && $HOME/.homebrew/bin/brew upgrade $HOME/.homebrew/bin/brew-cask && $HOME/.homebrew/bin/brew cleanup && $HOME/.homebrew/bin/brew cask cleanup

# Install VIM neobundle.vim plugin
curl -L https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | /bin/bash -s --

# Install oh-my-zsh and modules
if [[ -d $HOME/.oh-my-zsh ]]; then
	cd $HOME && mv -f $HOME/.oh-my-zsh $HOME/.oh-my-zsh.previous
fi
cd $HOME && git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# Install TMUX Plugin Manager
if [[ -d $HOME/.tmux ]]; then
	cd $HOME && mv -f $HOME/.tmux $HOME/.tmux.previous
fi
cd $HOME && mkdir -p $HOME/.tmux/plugins
cd $HOME && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
