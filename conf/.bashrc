#!/usr/bin/env bash

# dotFiles #####################################################################
# Path to your dotFiles configuration.
export DOTFILES=$HOME/.Files
export SHELLRC=$DOTFILES/conf/.shellrc

# Load numbered shared for bash and zsh config file
if [ -d $SHELLRC ]; then
  for file in $SHELLRC/[0-9]*
  do
    source $file
  done
else
  echo "404: $SHELLRC folder not found"
fi

# Shared Config File ###########################################################
# Load shared for bash and zsh config file
if [ -d $SHELLRC ]; then
  for file in $SHELLRC/[A-Za-z]*
  do
    source $file
  done
else
  echo "404: $SHELLRC folder not found"
fi

ITERMINTEGRATIONRC=$DOTFILES/conf/.iterm2_shell_integration.bash
if [[ $(uname) == "Darwin" ]] && [[ -f $ITERMINTEGRATIONRC ]]; then
  source $ITERMINTEGRATIONRC
fi

