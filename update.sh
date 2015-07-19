#!/usr/bin/env bash

# Update brew
if command -v brew >/dev/null; then
	brew update && brew upgrade --all
fi

# Update oh-my-zsh and modules
if [[ -d $HOME/.oh-my-zsh ]]; then
	cd $HOME/.oh-my-zsh && git pull
	cd $HOME/.oh-my-zsh && git pull --recurse-submodules
fi

# Update TMUX Plugin Manager
if [[ -d $HOME/.tmux/plugins ]]; then
	for file in $HOME/.tmux/plugins/*
	do
	cd $file
		if [[ -d '.git' ]]; then
			git pull
		fi
	done
fi
