# vim:ft=sh :

# Enforce Homebrew to the PATH
HOMEBREW_PATH="$HOME/.homebrew"
RUBY_PATH=`if [[ -d $HOMEBREW_PATH/Cellar/ruby ]]; then dirname $(find $HOMEBREW_PATH/Cellar/ruby/*/bin -name "ruby" -print -quit); fi`
GEMS_PATH=`if [[ -d $HOMEBREW_PATH/lib/ruby/gems ]]; then find $HOMEBREW_PATH/lib/ruby/gems/* -name "bin" -type d -print -quit; fi`
PYTHON3_PATH=`if [[ -d $HOMEBREW_PATH/Cellar ]]; then dirname $(find $HOMEBREW_PATH/Cellar/python*/*/bin -name "python3" -print -quit); fi`
PATH="$RUBY_PATH:$GEMS_PATH:$PYTHON3_PATH:$HOMEBREW_PATH/bin:$HOMEBREW_PATH/sbin:$PATH"
MANPATH="$HOMEBREW_PATH/share/man:$MANPATH"
