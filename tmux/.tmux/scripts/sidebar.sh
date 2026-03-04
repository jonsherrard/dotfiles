#!/usr/bin/env bash
# tmux sidebar - shows windows with title and last line preview

SESSION=$(tmux display-message -p '#{session_name}')
WIDTH=${1:-35}

# Mark this pane as sidebar (must target explicitly since we're launched with -d)
tmux set-option -p -t "$TMUX_PANE" @is_sidebar "1"

draw_sidebar() {
    clear
    local cols=$WIDTH

    # Session header
    printf "\033[1;36m"
    printf "  ⌘ %s\n" "$SESSION"
    printf "\033[0m"
    printf "\033[2m"
    printf "%*s\n" "$cols" "" | tr ' ' '─'
    printf "\033[0m"

    # List windows
    tmux list-windows -t "$SESSION" -F '#{window_index}|#{window_name}|#{pane_current_command}|#{window_active}|#{pane_current_path}|#{pane_id}' | while IFS='|' read -r idx name cmd active path pane_id; do
        # Get last non-empty line from the pane as preview
        local preview
        preview=$(tmux capture-pane -t "$pane_id" -p 2>/dev/null | grep -v '^$' | tail -1)
        local max_preview=$((cols - 4))
        if [ ${#preview} -gt $max_preview ]; then
            preview="${preview:0:$max_preview}…"
        fi

        # Shorten path
        local short_path="${path/#$HOME/~}"
        if [ ${#short_path} -gt $((cols - 4)) ]; then
            short_path="…${short_path: -$((cols - 6))}"
        fi

        if [ "$active" = "1" ]; then
            printf "\033[7;1m"
            printf " %-*s\n" "$((cols - 1))" " ★ $name"
            printf " %-*s\n" "$((cols - 1))" "   $short_path"
            if [ -n "$preview" ]; then
                printf " %-*s\n" "$((cols - 1))" "   $preview"
            fi
            printf "\033[0m"
        else
            printf "\033[0m"
            printf "\033[1m  ◦ %s\033[0m\n" "$name"
            printf "\033[2m    %s\033[0m\n" "$short_path"
            if [ -n "$preview" ]; then
                printf "\033[2m    %s\033[0m\n" "$preview"
            fi
        fi
        printf "\033[2m"
        printf "%*s\n" "$cols" "" | tr ' ' '·'
        printf "\033[0m"
    done

    printf "\n\033[2m  prefix+Tab: toggle\n"
    printf "  prefix+j/k: nav\033[0m\n"
}

draw_sidebar

while true; do
    tmux wait-for sidebar-update 2>/dev/null
    SESSION=$(tmux display-message -p '#{session_name}' 2>/dev/null) || exit 0
    draw_sidebar
done
