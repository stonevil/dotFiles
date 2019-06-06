#!/usr/bin/env bash

# Path to your dotFiles configuration.
DOTFILES=$HOME/.Files

# Load numbered shared for bash and zsh config file
SHELLRC=$DOTFILES/conf/.shellrc
if [ -d $SHELLRC ]; then
	if [ "$(ls -A $SHELLRC)" ]; then
		for file in $SHELLRC/[0-9]*; do
			source $file
		done
	fi
else
  echo "404: $SHELLRC folder not found"
fi

# Load shared for bash and zsh config file
if [ -d $SHELLRC ]; then
	if [ "$(ls -A $SHELLRC)" ]; then
		for file in $SHELLRC/[A-Za-z]*; do
			[[ $f != ^zsh* ]] && continue
			source $file
		done
	fi
else
	echo "404: $SHELLRC folder not found"
fi
