#!/usr/bin/env bash
# vim:ft=sh

export BAT_THEME="TwoDark"

dbat() {
	if [ $# -eq 2 ]; then
		diff -t -y --color "$1" "$2" | bat -l rs
	else
		echo "bat diff function accepts two and only two arguments"
	fi
}

tfbat() {
	if [ $# -ge 1 ]; then
		tail -f "$@" | bat --paging=never -l log --style="grid"
	else
		echo "bat tail -f function requires at least one arguments"
	fi
}
