#!/bin/bash

SESH="dev1"
EDITOR_DIR="~"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "editor"

  tmux send-keys -t $SESH:editor "cd $EDITOR_DIR" C-m
  tmux send-keys -t $SESH:editor "nvim ." C-m
  tmux select-window -t $SESH:editor
fi

tmux attach-session -t $SESH
