#!/usr/bin/env zsh
# vim:ft=zsh :
# shellcheck source=/dev/null

. "$HOME"/.Files/framework.sh || exit 1
_install_zinit

#zle && { zle reset-prompt; zle -R }

# Load rc plugins
if [ -d "$HOME"/.shellrc ]; then
	if [ "$(ls -A "$HOME"/.shellrc)" ]; then
		for file in "$HOME"/.shellrc/[0-9]*; do
			source "$file"
		done
	fi
else
	echo "404: ~/.shellrc folder not found"
fi

# ZPM
source $HOME/.zinit/bin/zinit.zsh

setopt promptsubst

zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

zinit light zpm-zsh/colors
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Theme
GREEN="%{$fg_bold[green]%}"
YELLOW="%{$fg_bold[yellow]%}"
CYAN="%{$fg_bold[cyan]%}"
RED="%{$fg_bold[red]%}"
RESET="%{$reset_color%}"

PROMPT='$YELLOW%c $(git_prompt_info) $RESET'

ZSH_THEME_GIT_PROMPT_PREFIX=" $CYAN"
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
