# vim:ft=sh :

stmux() { ssh "$@" -t sh -c '~/.homebrew/bin/tmux attach-session -dv'; }
