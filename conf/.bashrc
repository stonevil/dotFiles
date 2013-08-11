#!/usr/bin/env bash

# Add rvm gems and nginx to the path
export PATH=/opt/bin:/opt/sbin:/opt/homebrew/bin:/opt/homebrew/opt/gettext/bin:/opt/chef/bin:/opt/chef/embedded/bin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH

export MANPATH=/opt/share/man:/opt/homebrew/share/man:/usr/local/share/man:$MANPATH

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

export VIMRUNTIME="/opt/homebrew/share/vim/vim73"

# Set my editor and git editor
export EDITOR="/opt/homebrew/bin/vim"
export GIT_EDITOR='/opt/homebrew/bin/vim'

export VISUAL="/opt/homebrew/bin/vim"
export EDITOR="/opt/homebrew/bin/vim"

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Force support UTF8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
source $BASH_IT/bash_it.sh

# TMUX
complete -W "$(teamocil --list)" teamocil

# Aliases
alias v='/opt/homebrew/bin/vim'
alias plint='puppet-lint --no-hard_tabs-check --no-2sp_soft_tabs-check'
alias pval='puppet parser validate'
alias po2mo='/opt/homebrew/opt/gettext/bin/msgfmt'
alias lshwd="lspci -vv | awk '/Kernel/{print $5}' | sort -u" # Determine the 1st level of kernel modules your hardware needs on Linux.
