#!/usr/bin/env bash
DIRECTION="${1:-next}"

# Find and kill sidebar in current window before switching
for pane_id in $(tmux list-panes -F '#{pane_id}'); do
    val=$(tmux show-options -p -t "$pane_id" -v @is_sidebar 2>/dev/null)
    if [ "$val" = "1" ]; then
        tmux kill-pane -t "$pane_id"
        break
    fi
done

# Switch window
if [ "$DIRECTION" = "next" ]; then
    tmux select-window -t :+
else
    tmux select-window -t :-
fi

# Let the hook handle reopening
sleep 0.05
bash ~/.tmux/scripts/ensure-sidebar.sh
