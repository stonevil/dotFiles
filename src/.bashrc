#!/usr/bin/env bash
# vim:ft=sh

# shellcheck source=/dev/null
if [ -d "$HOME"/.shellrc ]; then
	if [ "$(ls -A "$HOME"/.shellrc)" ]; then
		for file in "$HOME"/.shellrc/[A-Za-z]; do
			source "$file"
		done
	fi
else
	echo "404: ~/.shellrc folder not found"
fi

. "$HOME"/.Files/framework.sh || exit 1
