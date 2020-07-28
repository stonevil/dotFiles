#!/usr/bin/env zsh
# vim:ft=zsh :

# INFO
# CTRL-f - Edit selected file(s)
# CTRL-t - Work with selected file(s)
# CTRL-r - Paste the selected command from history into the command line

# List of all bindkey: bindkey

if command -v fzf >/dev/null; then
	export FZF_DEFAULT_COMMAND_IGNORE="--glob '!.git/*' --glob '!.svn/*' --glob '!node_modules/*' --glob '!.undodir/*' --glob '!.session.vim' --glob '!.DS_Store'"

	export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --ignore-case $FZF_DEFAULT_COMMAND_IGNORE"

	export FZF_DEFAULT_OPTS='--bind F2:toggle-preview,ctrl-f:page-down,ctrl-b:page-up,alt-f:preview-page-down,alt-b:preview-page-up,q:abort --border --preview-window bottom:hidden --height 80% --layout=reverse --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers,changes --color=always {} || head -100 {}) 2> /dev/null | head -100"'

	export FZF_COMPLETION_OPTS="$FZF_COMPLETION_OPTS"

	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"

	export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:5:hidden:wrap"

	export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

	# Enter key to select the item, CTRL-C / CTRL-G / ESC to exit
	# On multi-select mode (-m), TAB and Shift-TAB to mark multiple items


	# CTRL-f - Edit selected file(s)
	fzf-file-edit-widget() {
		local files
		IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
		[[ ${#files[@]} -ne 0 ]] && vim "${files[@]}"
	}
	zle -N fzf-file-edit-widget
	bindkey -s '^f' 'fzf-file-edit-widget^M'


	# CTRL-t - Work with selected file(s)
	__fsel() {
		local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3-"}"
		setopt localoptions pipefail no_aliases 2> /dev/null
		eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
			echo -n "${(q)item} "
		done
		local ret=$?
		echo
		return $ret
	}
	__fzf_use_tmux__() {
		[ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
	}
	__fzfcmd() {
		__fzf_use_tmux__ && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
	}
	fzf-file-widget() {
		LBUFFER="${LBUFFER}$(__fsel)"
		local ret=$?
		zle reset-prompt
		return $ret
	}
	zle -N fzf-file-widget
	bindkey -s '^t' fzf-file-widget


	# CTRL-r - Paste the selected command from history into the command line
	fzf-history-widget() {
		local selected num
		setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
		selected=( $(fc -rl 1 |
		FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
		local ret=$?
		if [ -n "$selected" ]; then
			num=$selected[1]
			if [ -n "$num" ]; then
				zle vi-fetch-history -n $num
			fi
		fi
		zle reset-prompt
		return $ret
	}
	zle -N fzf-history-widget
	bindkey '^r' fzf-history-widget


	# fzf-content-widget [FUZZY PATTERN] - Search by content and edit selected file(s)
	fzf-content-widget() {
		local files
		IFS=$'\n' files=($(rg --files-with-matches --no-messages --no-ignore --hidden --follow --ignore-case --glob '!.git/*' --glob '!.svn/*' --glob '!node_modules/*' --glob '!.undodir/*' --glob '!.session.vim' --glob '!.DS_Store' $1 | fzf --multi --preview "(bat --style=numbers,changes --color=always {}) 2> /dev/null | head -100 | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 100 $1 || rg --ignore-case --pretty --context 100 $1 {}"))
		[[ ${#files[@]} -ne 0 ]] && vim "${files[@]}"
	}


	# cd to selected directory
	fzf-cd-widget() {
		local dir
		dir=$(find "${1:-.}" -not -path '*/\.git/*' -not -path '*/\.svn/*' -not -path '*/\.undodir/*' -type d -print 2>/dev/null | fzf +m) && cd "$dir" || return
	}


	# Kill selected process
	fzf-kill-widget() {
		local pid
		if [ "$UID" != "0" ]; then
			pid=$(ps -f -u $UID | sed 1d | fzf -m --preview 'echo {}' --preview-window down:5:hidden:wrap | awk '{print $2}')
		else
			pid=$(ps -ef | sed 1d | fzf -m --preview 'echo {}' --preview-window down:5:hidden:wrap | awk '{print $2}')
		fi

		if [ "x$pid" != "x" ]; then
			echo "$pid" | xargs kill -"${1:-9}"
		fi
	}
fi
