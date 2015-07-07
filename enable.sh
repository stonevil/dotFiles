#!/usr/bin/env bash

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
