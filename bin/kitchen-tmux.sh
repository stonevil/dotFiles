#!/bin/bash

SESSION=${PWD##*/}
PWD=$(pwd)
tmp=$TMUX

unset TMUX

tmux -2 new-session -d -s $SESSION

for x in $(kitchen list -b); do
  tmux new-window -t $SESSION -n "$x"
  tmux send-keys -t $SESSION  "kitchen test $x
"
done

tmux select-window -t $SESSION:1

export TMUX=$tmp
tmux switch-client -t $SESSION
