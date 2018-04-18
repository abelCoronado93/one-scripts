#!/bin/bash

tmux has-session -t $1
if [ $? != 0 ]
then
    tmux new-session -s $1 -d
    tmux send-keys -t $1:0.0 'cd Desktop/one/' C-m
    tmux splitw -h -p 30 -t $1:0.0
    tmux send-keys -t $1:0.1 'irssi' C-m
    tmux send-keys -t $1:0.1 '/connect freenode' C-m
    tmux splitw -v -p 40 -t $1:0.1
    tmux splitw -v -p 60 -t $1:0.0
    tmux splitw -h -p 100 -t $1
    tmux splitw -h -p 100 -t $1:0.0
    tmux send-keys -t $1:0.1 'cd Desktop/docs/' C-m
    tmux send-keys -t $1:0.3 'vim' C-m
    tmux attach -t $1
fi