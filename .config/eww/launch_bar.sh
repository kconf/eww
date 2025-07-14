#!/usr/bin/env bash
# Auto-detect window manager and launch appropriate eww bar

detect_wm() {
    # Check for Hyprland
    if pgrep -x "Hyprland" > /dev/null 2>&1; then
        echo "hyprland"
        return
    fi
    
    # Check for Sway
    if pgrep -x "sway" > /dev/null 2>&1; then
        echo "sway"
        return
    fi
    
    # Check for Scroll (assuming it shows as scroll process)
    if pgrep -x "scroll" > /dev/null 2>&1; then
        echo "scroll"
        return
    fi
    
    # Check for i3
    if pgrep -x "i3" > /dev/null 2>&1; then
        echo "i3"
        return
    fi
    
    # Default fallback
    echo "unknown"
}

launch_bar() {
    local wm="$1"
    
    # Kill any existing eww bars
    eww kill >/dev/null 2>&1
    
    case "$wm" in
        "hyprland")
            echo "Launching Hyprland bar..."
            eww open hyprland-bar
            ;;
        "sway"|"scroll")
            echo "Launching Scroll/Sway bar..."
            eww open scroll-bar
            ;;
        "i3")
            echo "i3 support not implemented yet, using scroll bar as fallback..."
            eww open scroll-bar
            ;;
        *)
            echo "Unknown WM: $wm, using scroll bar as fallback..."
            eww open scroll-bar
            ;;
    esac
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    WM=$(detect_wm)
    echo "Detected window manager: $WM"
    launch_bar "$WM"
fi
