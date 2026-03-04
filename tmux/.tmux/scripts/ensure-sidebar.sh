#!/usr/bin/env bash
# Opens sidebar in current window if global state says it should be open
# Atomic: uses a per-window flag to prevent double-open from racing hooks
SIDEBAR_WIDTH=35
MIN_WIDTH_FOR_SIDEBAR=100

SIDEBAR_OPEN=$(tmux show -sv @sidebar_open 2>/dev/null)
[ "$SIDEBAR_OPEN" != "1" ] && exit 0

TERM_WIDTH=$(tmux display-message -p '#{client_width}' 2>/dev/null)
[ "$TERM_WIDTH" -lt "$MIN_WIDTH_FOR_SIDEBAR" ] && exit 0

WIN_ID=$(tmux display-message -p '#{window_id}')

# Check if sidebar already exists in this window
for pane_id in $(tmux list-panes -t "$WIN_ID" -F '#{pane_id}'); do
    val=$(tmux show-options -p -t "$pane_id" -v @is_sidebar 2>/dev/null)
    if [ "$val" = "1" ]; then
        exit 0
    fi
done

# Use a window-level flag as a lock to prevent racing hooks
CREATING=$(tmux show-window-option -v @sidebar_creating 2>/dev/null)
[ "$CREATING" = "1" ] && exit 0
tmux set-window-option @sidebar_creating "1"

# Open sidebar
tmux split-window -hbdl "$SIDEBAR_WIDTH" "bash ~/.tmux/scripts/sidebar.sh $SIDEBAR_WIDTH"
tmux select-pane -t '{right}'

# Clear lock after a beat
sleep 0.2
tmux set-window-option -u @sidebar_creating 2>/dev/null
