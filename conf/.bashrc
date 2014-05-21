#!/usr/bin/env bash

# Customize to your needs...
PATH=/opt/bin:/opt/sbin:/opt/homebrew/bin:/opt/homebrew/opt/gettext/bin:/opt/chef/bin:/opt/chef/embedded/bin:/usr/bin:/usr/sbin:/bin:/sbin:~/.Files/bin:$PATH

MANPATH=/opt/share/man:/opt/homebrew/share/man:/usr/local/share/man:$MANPATH

VIMRUNTIME="/opt/homebrew/share/vim/vim74"

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set my editor and git editor
export EDITOR="/opt/homebrew/bin/vim"
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export EDITOR=$EDITOR

# Force support UTF8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Aliases
alias tail='/opt/homebrew/bin/multitail'
alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR
alias ll='ls -lahG'
alias l='ls -lahG'


# Shared Config File ###########################################################
# Load shared for bash and zsh config file
if [ -f $DOTFILES/conf/.shellrc ]; then
  source $DOTFILES/conf/.shellrc
else
  print "404: $DOTFILES/conf/.shellrc file not found"
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

