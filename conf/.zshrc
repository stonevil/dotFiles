# dotFiles #####################################################################
# Path to your dotFiles configuration.
DOTFILES=$HOME/.Files


# Oh My ZSH ####################################################################
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
plugins=(attery brew colorize copydir copyfile git knife knife_ssh osx ruby terminalapp thor tmuxinator vagrant vi-mode zsh-syntax-highlighting)

# Load oh-my-zsh
if [[ -f $ZSH/oh-my-zsh.sh && -r $ZSH/oh-my-zsh.sh ]]; then
  echo "Oh My ZSH detected and loaded!"
  source $ZSH/oh-my-zsh.sh
fi


# ZSH ##########################################################################
# Reload ZSH configuration
alias zr='source ~/.zshrc'

# Load zsh syntax highlighting
ZSHCOMPLETIONS=$DOTFILES/modules/zsh-completions
if [[ -d $ZSHCOMPLETIONS/zsh-completions/src ]]; then
  fpath=($ZSHCOMPLETIONS/zsh-completions/src $fpath)
fi

# Load zsh syntax highlighting
ZSHHISTORYSUBSTRINGSEARCH=$DOTFILES/modules/zsh-history-substring-search
if [[ -f $ZSHHISTORYSUBSTRINGSEARCH/zsh-history-substring-search.zsh ]]; then
  source $ZSHHISTORYSUBSTRINGSEARCH/zsh-history-substring-search.zsh
  # bind UP and DOWN arrow keys
  zmodload zsh/terminfo
  # bindkey "$terminfo[kcuu1]" history-substring-search-up
  # bindkey "$terminfo[kcud1]" history-substring-search-down
  # bind k and j for VI mode
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Load zsh syntax highlighting
ZSHSYNTAXHIGHLIGHTING=$DOTFILES/modules/zsh-syntax-highlighting
if [[ -f $ZSHSYNTAXHIGHLIGHTING/zsh-syntax-highlighting.zsh ]]; then
  source $ZSHSYNTAXHIGHLIGHTING/zsh-syntax-highlighting.zsh
fi


# Shared Config File ###########################################################
# Load shared for bash and zsh config file
if [ -f $DOTFILES/conf/.shellrc ]; then
  source $DOTFILES/conf/.shellrc
else
  print "404: $DOTFILES/conf/.shellrc file not found"
fi


# Aliases ######################################################################
# Customise ls command
alias ll='ls -lahG'
alias l='ls -lahG'


# ENV ##########################################################################
# Force support UTF8
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Customize ENV variables
PATH=/opt/bin:/opt/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$DOTFILES/bin:$PATH
MANPATH=/opt/share/man:/usr/local/share/man:$MANPATH


# Homebrew #####################################################################
# Add homebreb to the PATH
HOMEBREW=/opt/homebrew
if [[ -d $HOMEBREW ]]; then
  PATH=$HOMEBREW/bin:$HOMEBREW/gettext/bin:$PATH
  MANPATH=$HOMEBREW/share/man:$MANPATH
fi


# Chef #########################################################################
# Add OpScode Chef to the PATH
CHEF=/opt/chef
if [[ -d $CHEF ]]; then
  PATH=$CHEF/bin:$CHEF/embedded/bin:$PATH
  MANPATH=$CHEF/share/man:$CHEF/embedded/share/man:$MANPATH
fi

# Puppet #######################################################################
PUPPET=/opt/puppet
if command -v puppet >/dev/null; then
  alias pval='puppet parser validate'
fi

if command -v puppet-lint >/dev/null; then
  alias plint='puppet-lint --no-hard_tabs-check --no-2sp_soft_tabs-check'
fi


# AWS ##########################################################################
# Load source for AWS CLI completion
AWSCLI=/usr/local
if [[ -f $AWSCLI/bin/aws_zsh_completer.sh && -r $AWSCLI/bin/aws_zsh_completer.sh ]]; then
  source $AWSCLI/bin/aws_zsh_completer.sh
fi


# Editors ######################################################################
# Set EDITOR
if [[ -f /opt/homebrew/bin/vim ]]; then
  EDITOR="/opt/homebrew/bin/vim"
  VIMRUNTIME="/opt/homebrew/share/vim/vim74"
else
  if [[ -f /Applications/MacVim.app/Contents/MacOS/Vim ]]; then
    EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
    VIMRUNTIME="/Applications/MacVim.app/Contents/Resources/vim/runtime"
  else
    if [[ -f /usr/bin/vim ]]; then
      EDITOR="/usr/bin/vim"
      VIMRUNTIME="/usr/share/vim/vim"
    fi
  fi
fi

# ENV Variables
GIT_EDITOR=$EDITOR
VISUAL=$EDITOR
EDITOR=$EDITOR

# Aliases
alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR


# VMware #######################################################################
if [[ -f '/Applications/VMware\ Fusion.app/Contents/Library/vmrun' ]]; then
  alias vmrun='/Applications/VMware\ Fusion.app/Contents/Library/vmrun'
  function ovftool() { /Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/ovftool $@; }
fi


# Vagrant ######################################################################
if command -v vagrant >/dev/null; then
  if [[ -f '/Applications/VMware Fusion.app/Contents/Library/vmrun' ]]; then
    echo "VMware Fusion detected. Vagrant now use VMware Fusion!"
    function vv() { vagrant up $@ --provider vmware_fusion; }
  else
    echo "Vagrant now use VirtualBox!"
    function vv() { vagrant up $@; }
  fi

  function vl() { vagrant reload $@ --provision; }
  alias vh='vagrant halt'
  alias vd='vagrant destroy'
  alias vs='vagrant ssh'
  alias vt='vagrant status'
  alias vr='vagrant resume'

  function vagrant-update-all-plugins() { for plugin in $(vagrant plugin list | cut -f1 -d' '); do vagrant plugin update $plugin; done; }
fi


# Git ##########################################################################
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

function git-submodule-remove() {
git config -f .git/config --remove-section submodule.$1
git config -f .gitmodules --remove-section submodule.$1
git rm --cached $1
git commit -m "Remove $1 cookbook submodule"
rm -rf $1
rm -rf .git/modules/$1; }


# Guard ########################################################################
if command -v guard >/dev/null; then
  alias guard='guard --no-bundler-warning --latency 10'
fi


# TMUX #########################################################################
if command -v mux >/dev/null; then
  # tmux automation alias
  alias t='mux'
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
fi


# Tools ########################################################################
# Replace tail with multitail
if command -v multitail >/dev/null; then
  alias tail='multitail -C'
fi

# More OR Less
if command -v pygmentize >/dev/null; then
  function more() { pygmentize -g $1 | less -R; }
fi

# Change this to your console based IRC client of choice.
if command -v irssi >/dev/null; then
  IRC_CLIENT='irssi'
fi

# Lock console with a nice screensaver. Requires password to unlock.
if command -v vlock >/dev/null; then
  alias tl="tty-clock -s -r; vlock"
fi

# Return my IP address
function IP-all() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}
function IP-external() { dig +short myip.opendns.com @resolver1.opendns.com; }

# Speed Test
function speed-test() { wget -O /dev/null http://speedtest.wdc01.softlayer\.com/downloads/test10.zip; }

# Ruby Gems
function gems-update-all() { gem update `gem list | cut -d ' ' -f 1`; echo "All gems in system path updated"; }
function gems-remove-all() { for x in `gem list --no-versions`; do gem uninstall $x -a -x -I; done; echo "All gems in system path updated"; }

## OS X specific
# Return OS X memory status
function memory-stats() {
FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')
FREE=$((($FREE_BLOCKS+SPECULATIVE_BLOCKS)*4096/1048576))
INACTIVE=$(($INACTIVE_BLOCKS*4096/1048576))
TOTAL=$((($FREE+$INACTIVE)))
echo Free:       $FREE MB
echo Inactive:   $INACTIVE MB
echo Total free: $TOTAL MB }

# Flush DNS cache
function dns-cache-flush() { sudo killall -HUP mDNSResponder; }

# Search in Internet with Safari from CLI
function search() { open /Applications/Safari.app/ "http://www.google.com/search?q= $@"; }

# Flush Finder Context Menu
function finder-context-menu-flush() { sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user; killall Finder; echo "Open With has been rebuilt, Finder will relaunch"; }

bindkey -v
