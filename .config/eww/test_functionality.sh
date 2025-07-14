#!/usr/bin/env bash
# Test script for eww bar functionality

echo "=== EWW Bar Functionality Test ==="
echo

# Test 1: Check if eww is running
echo "1. Checking eww daemon status..."
if pgrep -x "eww" > /dev/null; then
    echo "   ✅ EWW daemon is running"
else
    echo "   ❌ EWW daemon is not running"
fi

# Test 2: Check active windows
echo "2. Checking active windows..."
active_windows=$(eww active-windows)
if [[ -n "$active_windows" ]]; then
    echo "   ✅ Active windows: $active_windows"
else
    echo "   ❌ No active windows found"
fi

# Test 3: Test Hyprland integration
echo "3. Testing Hyprland integration..."
if command -v hyprctl &> /dev/null; then
    current_workspace=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')
    echo "   ✅ Current workspace: $current_workspace"
    
    # Test workspace data
    if [[ -x "./widgets/hyprland/get_hyprland_workspaces" ]]; then
        echo "   ✅ Workspace script is executable"
    else
        echo "   ❌ Workspace script not executable"
    fi
else
    echo "   ❌ hyprctl not found"
fi

# Test 4: Test widget scripts
echo "4. Testing widget scripts..."
scripts=(
    "widgets/hyprland/get_hyprland_workspaces"
    "widgets/hyprland/get_hyprland_window_title"
    "widgets/scroll/get_scroll_workspaces"
    "widgets/scroll/get_window_title"
    "widgets/pulseaudio/get_vol"
    "widgets/wifi/get_wifi"
)

for script in "${scripts[@]}"; do
    if [[ -x "$script" ]]; then
        echo "   ✅ $script is executable"
    else
        echo "   ❌ $script not executable or missing"
    fi
done

# Test 5: Test bar switching
echo "5. Testing bar switching..."
echo "   Switching to Hyprland bar..."
eww close-all >/dev/null 2>&1
sleep 0.5
eww open hyprland-bar >/dev/null 2>&1
sleep 1

if eww active-windows | grep -q "hyprland-bar"; then
    echo "   ✅ Hyprland bar opened successfully"
else
    echo "   ❌ Failed to open Hyprland bar"
fi

echo
echo "=== Test Complete ==="
echo "Current layout: Left=Workspaces, Center=Window Title, Right=Status Bar"
echo "Status bar includes: WiFi + Volume + Time + System Tray"
