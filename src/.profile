# vim:ft=sh :

if [ "$(uname)" = "Darwin" ]; then
	# Add homebrew to the PATH
	export HOMEBREW=~/.homebrew
	export PATH=$HOMEBREW/bin:$HOMEBREW/sbin:$PATH
	export MANPATH=$HOMEBREW/share/man:$MANPATH
fi
