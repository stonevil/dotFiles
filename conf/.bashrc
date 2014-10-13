#!/usr/bin/env bash

# dotFiles #####################################################################
# Path to your dotFiles configuration.
export DOTFILES=$HOME/.Files

# Load numbered shared for bash and zsh config file
if [ -d $DOTFILES/conf/.shellrc ]; then
  for file in $DOTFILES/conf/.shellrc/[0-9]*
  do
    source $file
  done
else
  echo "404: $DOTFILES/conf/.shellrc/ folder not found"
fi

# Shared Config File ###########################################################
# Load shared for bash and zsh config file
if [ -d $DOTFILES/conf/.shellrc ]; then
  for file in $DOTFILES/conf/.shellrc/[A-Za-z]*
  do
    source $file
  done
else
  echo "404: $DOTFILES/conf/.shellrc/ folder not found"
fi
