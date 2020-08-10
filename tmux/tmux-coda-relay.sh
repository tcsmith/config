#!/bin/bash
SESSIONNAME="coda-relay"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]
then
    tmux new-session -s $SESSIONNAME -d 
    tmux send-keys 'cd src/projects/tsmith_balw-tsmith3_firaxislive/FiraxisLive/Development/Services/coda-relay' Enter
    tmux split-window -v
    tmux send-keys 'cd src/projects/tsmith_balw-tsmith3_firaxislive/FiraxisLive/Development/Services/coda-relay' Enter
fi

tmux attach -t $SESSIONNAME
