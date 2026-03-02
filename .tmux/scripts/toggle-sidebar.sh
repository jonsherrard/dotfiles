#!/usr/bin/env bash
SIDEBAR_WIDTH=35
MIN_WIDTH_FOR_SIDEBAR=100

TERM_WIDTH=$(tmux display-message -p '#{client_width}')

# Find sidebar pane by custom option
SIDEBAR_PANE=""
for pane_id in $(tmux list-panes -F '#{pane_id}'); do
    val=$(tmux show-options -p -t "$pane_id" -v @is_sidebar 2>/dev/null)
    if [ "$val" = "1" ]; then
        SIDEBAR_PANE="$pane_id"
        break
    fi
done

if [ -n "$SIDEBAR_PANE" ]; then
    tmux kill-pane -t "$SIDEBAR_PANE"
    tmux set -s @sidebar_open "0"
else
    if [ "$TERM_WIDTH" -lt "$MIN_WIDTH_FOR_SIDEBAR" ]; then
        tmux display-message "Terminal too narrow for sidebar"
        exit 0
    fi
    tmux split-window -hbdl "$SIDEBAR_WIDTH" "bash ~/.tmux/scripts/sidebar.sh $SIDEBAR_WIDTH"
    tmux select-pane -t '{right}'
    tmux set -s @sidebar_open "1"
fi
