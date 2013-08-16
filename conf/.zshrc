# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="steeef"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(attery brew colorize copydir copyfile git knife knife_ssh osx ruby thor tmuxinator vagrant vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/opt/bin:/opt/sbin:/opt/homebrew/bin:/opt/homebrew/opt/gettext/bin:/opt/chef/bin:/opt/chef/embedded/bin:/usr/bin:/usr/sbin:/bin:/sbin:~/.Files/bin:$PATH

MANPATH=/opt/share/man:/opt/homebrew/share/man:/usr/local/share/man:$MANPATH

VIMRUNTIME="/opt/homebrew/share/vim/vim74"

# Set my editor and git editor
EDITOR="/opt/homebrew/bin/vim"
GIT_EDITOR=$EDITOR
VISUAL=$EDITOR
EDITOR=$EDITOR

# Change this to your console based IRC client of choice.
IRC_CLIENT='irssi'

# Force support UTF8
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

## Aliases
alias zr='source ~/.zshrc'

alias tail='/opt/homebrew/bin/multitail'
alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR
alias plint='puppet-lint --no-hard_tabs-check --no-2sp_soft_tabs-check'
alias pval='puppet parser validate'
alias po2mo='/opt/homebrew/opt/gettext/bin/msgfmt'
alias lshwd="lspci -vv | awk '/Kernel/{print $5}' | sort -u" # Determine the 1 modules your hardware needs on Linux.
alias ll='ls -lahG'
alias l='ls -lahG'

# Lock console with a nice screensaver. Requires password to unlock.
alias tl="tty-clock -s -r; vlock"

# VMware aliases
alias vmrun='/Applications/VMware\ Fusion.app/Contents/Library/vmrun'

# Git aliases
alias ga='git add'
alias gA='git add -A'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -v'
alias gma='git commit -a -v'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
# leverage an alias from the ~/.gitconfig
alias gh='git hist'
alias glg1='git lg1'
alias glg2='git lg2'
alias glg='git lg'
# review all files in a git-managed directory that are not yet added to git
alias gv='vim $(git ls-files -o -X .gitignore)'
# Vagrant
alias vb='vagrant up'
alias vv='vagrant up --provider vmware_fusion'
alias va='vagrant up --provider aws'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vs='vagrant ssh'
alias vt='vagrant status'
alias vl='vagrant reload'
alias vr='vagrant resume'


## FUNCTIONS
# return my IP address
function myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

bindkey -v


## TMUX
# tmux automation alias
alias t='mux'

# Add autocompletion for Teamocil
compctl -g '~/.teamocil/*(:t:r)' teamocil

# Tmuxinator
compctl -K _tmuxinator tmuxinator mux

_tmuxinator() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(tmuxinator commands)"
  else
    completions="$(tmuxinator completions ${words[2,-2]})"
  fi

  reply=("${(ps:\n:)completions}")
}
