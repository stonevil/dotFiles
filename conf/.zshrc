# dotFiles #####################################################################
# Path to your dotFiles configuration.
DOTFILES=$HOME/.Files


# Oh My ZSH ####################################################################
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Optionally, if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.
# ZSH_THEME="steeef"
# ZSH_THEME="arrow"
# ZSH_THEME="bira" #! too long promtp
# ZSH_THEME="kafeitu" # -
# ZSH_THEME="miloshadzic" #!!!
# ZSH_THEME="nebirhos" #!!!
# ZSH_THEME="norm"
ZSH_THEME="sorin"
# ZSH_THEME="sporty_256" #!!!

# CASE_SENSITIVE="true"
CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=2
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
ZSH_CUSTOM=~/.Files/conf/.zsh_custom


# Homebrew #####################################################################
# Add homebrew to the PATH
HOMEBREW="/opt/homebrew"
if [[ -d $HOMEBREW ]]; then
  PATH=$HOMEBREW/bin:$HOMEBREW/sbin:$HOMEBREW/gettext/bin:$PATH
  MANPATH=$HOMEBREW/share/man:$MANPATH
  source $HOMEBREW/share/zsh/site-functions/*
fi


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(brew bundler colored-man colorize copyfile cp forklift rsync textmate tmux tmuxinator vi-mode)


# Load oh-my-zsh
if [[ -f $ZSH/oh-my-zsh.sh && -r $ZSH/oh-my-zsh.sh ]]; then
  echo "Oh My ZSH detected and loaded!"
  source $ZSH/oh-my-zsh.sh
fi


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
#if [ -f $DOTFILES/conf/.shellrc ]; then
#  source $DOTFILES/conf/.shellrc
#else
#  print "404: $DOTFILES/conf/.shellrc file not found"
#fi


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


# RVM #### #####################################################################
# Add RVM to the PATH
RVM=~/.rvm/
if [[ -d $RVM ]]; then
  PATH=$RVM/bin:$PATH
  MANPATH=$RVM/man:$MANPATH
  source $RVM/scripts/rvm
fi


# RVM #### #####################################################################
# Add RVM to the PATH
RBENV=~/.rbenv/
if [[ -d $RBENV ]]; then
  eval "$(rbenv init -)"
fi


# Chef #########################################################################
# Add OpScode Chef to the PATH
CHEFDK=/opt/chefdk
if [[ -d $CHEFDK ]]; then
  PATH=$CHEFDK/bin:$CHEFDK/embedded/bin:$PATH
  MANPATH=$CHEFDK/share/man:$MANPATH
# Chef Ruby Gems
  function chef-gem() { $CHEFDK/embedded/bin/gem $@; }
  function chef-bundle() { $CHEFDK/embedded/bin/bundle $@ --path ~/.chefdk/gem; }
  function chef-gems-update-all() { $CHEFDK/embedded/bin/gem update `/opt/chefdk/embedded/bin/gem list | cut -d ' ' -f 1`; echo "All gems in system path updated"; }
  function chef-gems-remove-old() { $CHEFDK/embedded/bin/gem cleanup; }
  function chef-gems-list-local() { $CHEFDK/embedded/bin/gem query --local; }
fi

CHEFDKLOCAL=~/.chefdk/gem/ruby/2.1.0
if [[ -d $CHEFDKLOCAL ]]; then
  PATH=$PATH:$CHEFDKLOCAL/bin
  MANPATH=$MANPATH:$CHEFDKLOCAL/share/man
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

# Xcode 5.1 clang hot-fix for old software
ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

# VMware #######################################################################
if [[ -d '/Applications/VMware\ Fusion.app' ]]; then
  function ovftool() {
    cd /Applications/VMware\ Fusion.app/Contents/Library/
    ./vmrun $@
  }
  function ovftool() {
    cd /Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/
    ./ovftool $@
  }
  function vmware-vdiskmanager() {
    cd /Applications/VMware\ Fusion.app/Contents/Library/
    ./vmware-vdiskmanager $@
  }
fi


# Vagrant ######################################################################
if command -v vagrant >/dev/null; then
  if [[ -f '/Applications/VMware Fusion.app/Contents/Library/vmrun' ]]; then
    echo "VMware Fusion detected. Vagrant now use VMware Fusion!"
    function vv() { vagrant up $@ --provider vmware_fusion; }
    VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
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
# if command -v mux >/dev/null; then
#   # tmux automation alias
#   alias t='mux'
#   alias tlist='tmux list-windows'
#   # Tmuxinator
#   compctl -K _tmuxinator tmuxinator mux
#
#   _tmuxinator() {
#     local words completions
#     read -cA words
#
#     if [ "${#words}" -eq 2 ]; then
#       completions="$(tmuxinator commands)"
#     else
#       completions="$(tmuxinator completions ${words[2,-2]})"
#     fi
#
#     reply=("${(ps:\n:)completions}")
#   }
#
#   # Setup iTerm/Terminal window name
#   set_terminal_tab_title() {
#     print -Pn "\e]1;$1:q\a"
#   }
#   indicate_tmux_session_in_terminal() {
#     set_terminal_tab_title "$(tmux display-message -p '#S')"
#   }
#   precmd_functions=($precmd_functions indicate_tmux_session_in_terminal)
#
# fi


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

# Speed ssh X session
alias sshx="ssh -XC -c blowfish-cbc,arcfour"

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
function gems-remove-old() { gem cleanup; }
function gems-list-local() { gem query --local; }

# Clean up whiteboard screen
if command -v convert >/dev/null; then
  function whiteboard-clean() { convert $1 -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 $2; }
fi

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
  echo Total free: $TOTAL MB
}

# AirPort OS X command line
function airport() { /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport; }

# Flush DNS cache
function dns-cache-flush() { dscacheutil -flushcache; sudo killall -HUP mDNSResponder; }

# Search in Internet with Safari from CLI
function search() { open /Applications/Safari.app/ "http://duckduckgo.com/?q= $@"; }

# Flush Finder Context Menu
function finder-context-menu-flush() { sudo /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user; killall Finder; echo "Open With has been rebuilt, Finder will relaunch"; }

# Game on/off optimisation
function game-on { sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist }
function game-off { sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist }


bindkey -v
