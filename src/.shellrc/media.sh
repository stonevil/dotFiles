#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	youtube-dl -f mp4 --audio-format "best" "$@"
}
