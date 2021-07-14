#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	youtube-dlc -f mp4 --audio-format "best" "$@"
}
