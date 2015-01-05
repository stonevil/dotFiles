# dotFiles #####################################################################
# Path to your dotFiles configuration.
DOTFILES=$HOME/.Files

# Oh My ZSH ####################################################################
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Load numbered shared for bash and zsh config file
if [ -d $DOTFILES/conf/.shellrc ]; then
  for file in $DOTFILES/conf/.shellrc/[0-9]*
  do
    source $file
  done
else
  print "404: $DOTFILES/conf/.shellrc/ folder not found"
fi

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# plugins=(brew bundler colored-man colorize copyfile cp forklift rsync textmate tmux tmuxinator vi-mode)
plugins=(brew bundler colored-man colorize copyfile cp golang forklift rsync textmate tmux vagrant)

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
if [ -d $DOTFILES/conf/.shellrc ]; then
  for file in $DOTFILES/conf/.shellrc/[A-Za-z]*
  do
    source $file
  done
else
  print "404: $DOTFILES/conf/.shellrc/ folder not found"
fi

alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && reload"

bindkey -v
