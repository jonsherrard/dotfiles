#!/usr/bin/env bash
# Signal the sidebar to refresh
tmux wait-for -S sidebar-update 2>/dev/null
