#!/usr/bin/env bash
# Close all sidebars if terminal is too narrow (mobile)
MIN_WIDTH_FOR_SIDEBAR=100

TERM_WIDTH=$(tmux display-message -p '#{client_width}' 2>/dev/null)
[ -z "$TERM_WIDTH" ] && exit 0

if [ "$TERM_WIDTH" -lt "$MIN_WIDTH_FOR_SIDEBAR" ]; then
    # Kill all sidebar panes across all windows
    for win_id in $(tmux list-windows -F '#{window_id}'); do
        for pane_id in $(tmux list-panes -t "$win_id" -F '#{pane_id}'); do
            val=$(tmux show-options -p -t "$pane_id" -v @is_sidebar 2>/dev/null)
            if [ "$val" = "1" ]; then
                tmux kill-pane -t "$pane_id"
            fi
        done
    done
fi
