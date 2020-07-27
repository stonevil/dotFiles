#!/usr/bin/env bash
# vim:ft=sh :

# EDITOR
if command -v nvim >/dev/null; then
	EDITOR="$(command -v nvim)"
else
	EDITOR="$(command -v vim)"
fi
export EDITOR

# VIM/NVIM session file
export VIM_SESSION_FILENAME=".session.vim"

# ENV Variables
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR

# Aliases
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'
