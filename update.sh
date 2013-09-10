#!/bin/bash

# Update vim and vim modules
cd ~/.oh-my-zsh && git pull
cd ~/.oh-my-zsh && git pull --recurse-submodules

# Update vim and vim modules
cd ~/.vim && git pull
cd ~/.vim && git pull --recurse-submodules

# Update tmux-powerline
cd ~/.tmux-powerline && git pull
