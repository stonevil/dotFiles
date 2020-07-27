#!/usr/bin/env zsh
# vim:ft=zsh :

if command -v fzf >/dev/null; then
	# ts [FUZZY PATTERN] - switch to selected tmux session
	ts() {
		local session
		session=$(tmux list-sessions -F "#{session_name}" | fzf --query="$1" --select-1 --exit-0) && tmux switch-client -t "$session"
	}


	# tp - switch to selected tmux pane
	tp() {
		local panes current_window current_pane target target_window target_pane
		panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
		current_pane=$(tmux display-message -p '#I:#P')
		current_window=$(tmux display-message -p '#I')

		target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

		target_window=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$1}')
		target_pane=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

		if [[ $current_window -eq $target_window ]]; then
			tmux select-pane -t "${target_window}"."${target_pane}"
		else
			tmux select-pane -t "${target_window}"."${target_pane}" && tmux select-window -t "$target_window"
		fi
	}
fi
