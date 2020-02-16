#!/usr/bin/env zsh
# vim:ft=zsh :
# shellcheck source=/dev/null

. "$HOME"/.Files/framework.sh || exit 1
_install_zinit

# Load rc files
if [ -d "$HOME"/.shellrc ]; then
	if [ "$(ls -A "$HOME"/.shellrc)" ]; then
		for file in "$HOME"/.shellrc/[0-9]*; do
			source "$file"
		done
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

# Zinit
source $HOME/.zinit/bin/zinit.zsh

#zplug "plugins/git", from:oh-my-zsh
#zplug "plugins/branch", from:oh-my-zsh
#zplug "plugins/colored-man-pages", from:oh-my-zsh

#zplug "Aloxaf/fzf-tab"
FZF_TAB_OPTS=""

#zplug "lincheney/fzf-tab-completion"

#zplug 'wfxr/forgit'
# ga - Interactive git add selector
# glo - Interactive git log viewer
# gli - Interactive .gitignore generator
# gd - Interactive git diff viewer
# grh - Interactive git reset HEAD <file> selector
# gcf - Interactive git checkout <file> selector
# gss - Interactive git stash viewer
# gclean - Interactive git clean selector
#FORGIT_FZF_DEFAULT_OPTS=""

zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/git.zsh
#ZSH_THEME="stoned"

#CASE_SENSITIVE="true"
#DISABLE_AUTO_UPDATE="true"
#export UPDATE_ZSH_DAYS=2
## DISABLE_LS_COLORS="true"
#DISABLE_AUTO_TITLE="true"
#ENABLE_CORRECTION="true"
#COMPLETION_WAITING_DOTS="true"
## DISABLE_UNTRACKED_FILES_DIRTY="true"
## HIST_STAMPS="mm/dd/yyyy"
#ZSH_CUSTOM=$HOME/.zsh_custom

## Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
## Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
#plugins=(colored-man-pages docker golang rsync sudo vagrant vault vi-mode)

## Load oh-my-zsh
#if [[ -f $ZSH/oh-my-zsh.sh && -r $ZSH/oh-my-zsh.sh ]]; then
	#echo "Oh My ZSH detected and loaded!"
	#source $ZSH/oh-my-zsh.sh
#fi


# Theme
#GREEN="%{$fg_bold[green]%}"
#YELLOW="%{$fg_bold[yellow]%}"
#CYAN="%{$fg_bold[cyan]%}"
#RED="%{$fg_bold[red]%}"
#RESET="%{$reset_color%}"

#PROMPT='$YELLOW%c $(git_prompt_info) $RESET'

#ZSH_THEME_GIT_PROMPT_PREFIX=" $CYAN"
#ZSH_THEME_GIT_PROMPT_SUFFIX=""
#ZSH_THEME_GIT_PROMPT_DIRTY=" $RED⦿"
#ZSH_THEME_GIT_PROMPT_CLEAN=" $GREEN⦾"


# Reload zshrc
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && reload"

bindkey -v
