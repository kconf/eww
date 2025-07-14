#!/usr/bin/env bash
# Launch Scroll/Sway eww bar

# Kill any existing eww bars
eww kill >/dev/null 2>&1

# Wait a moment for cleanup
sleep 0.2

# Start eww daemon if not running
eww daemon &

# Wait for daemon to start
sleep 0.5

# Open Scroll bar
eww open scroll-bar

echo "Scroll/Sway bar launched successfully!"
