# vim:ft=sh
# shellcheck source=/dev/null

# Enforce Homebrew to the PATH
HOMEBREW_PATH="$HOME/.homebrew"
RUBY_PATH=$(if [[ -d $HOMEBREW_PATH/Cellar/ruby ]]; then dirname $(find $HOMEBREW_PATH/Cellar/ruby/*/bin -name "ruby" -print -quit); fi)
GEMS_PATH=$(if [[ -d $HOMEBREW_PATH/lib/ruby/gems ]]; then find $HOMEBREW_PATH/lib/ruby/gems/* -name "bin" -type d -print -quit; fi)
PYTHON3_PATH=$(if [[ -d $HOMEBREW_PATH/Cellar ]]; then dirname $(find $HOMEBREW_PATH/Cellar/python*/*/bin -name "python3" -print -quit); fi)
PATH="$RUBY_PATH:$GEMS_PATH:$PYTHON3_PATH:$HOMEBREW_PATH/bin:$HOMEBREW_PATH/sbin:$PATH"
MANPATH="$HOMEBREW_PATH/share/man:$MANPATH"

. "$HOME"/.Files/framework.sh || exit 1

# Load rc plugins
# shellcheck source=/dev/null
if [ -d "$HOME"/.shellrc ]; then
	if [ "$(ls -A "$HOME"/.shellrc)" ]; then
		for file in "$HOME"/.shellrc/[A-Za-z]*.sh; do
			source "$file"
		done
	fi
else
	echo "404: ~/.shellrc folder not found"
fi

# Load local secret configurations just like GitHub tokens, etc
# shellcheck source=/dev/null
if [ -d "$HOME"/.secrc ]; then
	if [ "$(ls -A "$HOME"/.secrc)" ]; then
		for file in "$HOME"/.secrc/*; do
			source "$file"
		done
	fi
fi
