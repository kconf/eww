#!/usr/bin/env bash
# Launch Hyprland eww bar

# Check for theme parameter
if [ "$1" = "--theme" ] && [ -n "$2" ]; then
    echo "Applying theme: $2"
    ./switch_theme.sh "$2"
fi

# Kill any existing eww bars
eww kill >/dev/null 2>&1

# Wait a moment for cleanup
sleep 0.2

# Start eww daemon if not running
eww daemon &

# Wait for daemon to start
sleep 0.5

# Open Hyprland bar
eww open hyprland-bar

echo "Hyprland bar launched successfully!"
