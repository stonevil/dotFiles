#!/usr/bin/env zsh
# vim:ft=zsh :
# shellcheck source=/dev/null

# Enforce Homebrew to the PATH
HOMEBREW_PATH="$HOME/.homebrew"
RUBY_PATH=`if [[ -d $HOMEBREW_PATH/Cellar/ruby ]]; then dirname $(find $HOMEBREW_PATH/Cellar/ruby/*/bin -name "ruby" -print -quit); fi`
GEMS_PATH=`if [[ -d $HOMEBREW_PATH/lib/ruby/gems ]]; then find $HOMEBREW_PATH/lib/ruby/gems/* -name "bin" -type d -print -quit; fi`
PYTHON3_PATH=`if [[ -d $HOMEBREW_PATH/Cellar ]]; then dirname $(find $HOMEBREW_PATH/Cellar/python*/*/bin -name "python3" -print -quit); fi`
PATH="$RUBY_PATH:$GEMS_PATH:$PYTHON3_PATH:$HOMEBREW_PATH/bin:$HOMEBREW_PATH/sbin:$PATH"
MANPATH="$HOMEBREW_PATH/share/man:$MANPATH"

. "$HOME"/.Files/framework.sh || exit 1

source "$HOME/.antigen.zsh"

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle colored-man-pages
antigen bundle docker
antigen bundle kubectl
antigen bundle rsync
antigen bundle sudo
antigen bundle textastic
antigen bundle vagrant
antigen bundle vi-mode
antigen bundle Aloxaf/fzf-tab

# Load the theme
#antigen theme candy

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
# Tell Antigen that you're done
antigen apply

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=2
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Theme
GREEN="%{$fg_bold[green]%}"
YELLOW="%{$fg_bold[yellow]%}"
CYAN="%{$fg_bold[cyan]%}"
RED="%{$fg_bold[red]%}"
RESET="%{$reset_color%}"

PROMPT='$YELLOW%c $(git_prompt_info) $RESET'

ZSH_THEME_GIT_PROMPT_PREFIX="⥍ $CYAN"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $RED⦿"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GREEN⦾"

# Load rc plugins
if [ -d "$HOME"/.shellrc ]; then
	if [ "$(ls -A "$HOME"/.shellrc)" ]; then
		for file in "$HOME"/.shellrc/[A-Za-z]*; do
			source "$file"
		done
	fi
else
	echo "404: ~/.shellrc folder not found"
fi

# Load local secret configurations just like GitHub tokens, etc
if [ -d "$HOME"/.secrc ]; then
	if [ "$(ls -A "$HOME"/.secrc)" ]; then
		for file in "$HOME"/.secrc/*; do
			source "$file"
		done
	fi
fi

# Reload zshrc
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && reload"
