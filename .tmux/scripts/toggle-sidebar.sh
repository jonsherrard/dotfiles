#!/usr/bin/env bash
# Toggle sidebar globally - opens/closes on ALL windows
SIDEBAR_WIDTH=35
MIN_WIDTH_FOR_SIDEBAR=100

CURRENT_STATE=$(tmux show -sv @sidebar_open 2>/dev/null)

if [ "$CURRENT_STATE" = "1" ]; then
    # Close sidebar on ALL windows
    tmux set -s @sidebar_open "0"
    for win_id in $(tmux list-windows -F '#{window_id}'); do
        for pane_id in $(tmux list-panes -t "$win_id" -F '#{pane_id}'); do
            val=$(tmux show-options -p -t "$pane_id" -v @is_sidebar 2>/dev/null)
            if [ "$val" = "1" ]; then
                tmux kill-pane -t "$pane_id"
            fi
        done
    done
else
    TERM_WIDTH=$(tmux display-message -p '#{client_width}')
    if [ "$TERM_WIDTH" -lt "$MIN_WIDTH_FOR_SIDEBAR" ]; then
        tmux display-message "Terminal too narrow for sidebar"
        exit 0
    fi
    # Open sidebar on current window, mark globally open
    tmux set -s @sidebar_open "1"
    tmux split-window -hbdl "$SIDEBAR_WIDTH" "bash ~/.tmux/scripts/sidebar.sh $SIDEBAR_WIDTH"
    tmux select-pane -t '{right}'
fi
