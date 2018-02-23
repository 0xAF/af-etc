#!/bin/bash

# create new profile in yakuake and set this script as a login shell


# this script will:
# start a root shell... and give it some time before starting multitail
# so the screen is initialized and multitail will see the real screen size
# then after a second, start multitail
# only after that, split screen and start htop
# set the unattached options after we are attached, otherwise the session will be killed before we are attached

sess="yakuake"

tmux new-session -d -s $sess 'HISTFILE= su;exit'
tmux set -t $sess status off
#tmux set -t $sess mouse on

sleep 1
#tmux send-keys -t $sess "multitail -D /var/log/messages;exit" Enter
tmux send-keys -t $sess "HISTFILE= TERM=xterm-256color lnav /var/log/messages;exit" Enter
sleep 1
tmux send-keys -t $sess Enter
tmux split-window -t $sess:1 -d -p 50 htop
tmux attach -t $sess \; set -t $sess exit-unattached on \; set -t $sess destroy-unattached on






# old stuff

#/usr/bin/tmux new-session -d -s yakuake \; set -g status off \; set -g mouse on \; send-keys 'su -c "multitail -D /var/log/messages";exit' Enter \; send-keys Enter \; split-window -d -p 55 htop \; attach

