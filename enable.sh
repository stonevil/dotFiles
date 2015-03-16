#!/usr/bin/env bash

# Install oh-my-zsh and modules
if [[ -d $HOME/.oh-my-zsh ]]; then
  cd $HOME && mv -f $HOME/.oh-my-zsh $HOME/.oh-my-zsh.previous
fi
cd $HOME && git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# Install vim and vim modules
if [[ -d $HOME/.vim ]]; then
  cd $HOME && mv -f $HOME/.vim $HOME/.vim.previous
fi
cd $HOME && git clone git://github.com/akitaonrails/vimfiles.git $HOME/.vim
cd $HOME/.vim && git submodule update --init
cd $HOME/.vim && git pull --recurse-submodules

# Install TMUX Plugin Manager
if [[ -d $HOME/.tmux ]]; then
  cd $HOME && mv -f $HOME/.tmux $HOME/.tmux.previous
fi
cd $HOME && mkdir -p $HOME/.tmux/plugins
cd $HOME && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
