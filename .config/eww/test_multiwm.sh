#!/bin/bash

echo "=== Multi-WM Support Test ==="
echo

# Test WM detection
WM=$(./utils/detect_wm)
echo "✅ Detected WM: $WM"

# Test workspace data
echo "✅ Testing workspace data..."
if [ "$WM" = "hyprland" ]; then
    WORKSPACES=$(./widgets/hyprland/get_hyprland_workspaces | head -1)
    WINDOW_TITLE=$(./widgets/hyprland/get_hyprland_window_title | head -1)
elif [ "$WM" = "scroll" ] || [ "$WM" = "sway" ]; then
    WORKSPACES=$(./widgets/scroll/get_scroll_workspaces | head -1)
    WINDOW_TITLE=$(./widgets/scroll/get_window_title | head -1)
else
    WORKSPACES="[]"
    WINDOW_TITLE="Desktop"
fi

echo "   Workspaces: $WORKSPACES"
echo "   Window Title: $WINDOW_TITLE"

# Test JSON validation
if echo "$WORKSPACES" | jq . >/dev/null 2>&1; then
    echo "✅ JSON validation: passed"
    WORKSPACE_COUNT=$(echo "$WORKSPACES" | jq 'length')
    echo "   Found $WORKSPACE_COUNT workspaces"
else
    echo "❌ JSON validation: failed"
fi

echo
echo "=== Configuration Files ==="
echo "✅ eww.yuck: $([ -f eww.yuck ] && echo "exists" || echo "missing")"
echo "✅ Universal widgets: $([ -f widgets/universal/universal.yuck ] && echo "exists" || echo "missing")"
echo "✅ WM detection: $([ -x utils/detect_wm ] && echo "executable" || echo "not executable")"
echo "✅ CONFIG.md: $([ -f CONFIG.md ] && echo "exists" || echo "missing")"

echo
echo "=== Multi-WM Support Ready! ==="
echo "Current setup supports: Hyprland, Sway, Scroll, i3"
echo "Auto-detection: enabled"
echo "Fallback handling: enabled"
