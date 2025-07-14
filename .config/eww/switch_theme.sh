#!/usr/bin/env bash
# Theme switcher for eww configuration

THEMES_DIR="$(dirname "$0")/themes"
CONFIG_FILE="$(dirname "$0")/eww.yuck"

show_help() {
    echo "EWW Theme Switcher"
    echo "Usage: $0 [theme-name]"
    echo ""
    echo "Available themes:"
    for theme in "$THEMES_DIR"/*.yuck; do
        if [ -f "$theme" ]; then
            basename "$theme" .yuck | sed 's/^/  - /'
        fi
    done
    echo ""
    echo "Examples:"
    echo "  $0 gruvbox-dark"
    echo "  $0 catppuccin-mocha"
}

apply_theme() {
    local theme="$1"
    local theme_file="$THEMES_DIR/$theme.yuck"
    
    if [ ! -f "$theme_file" ]; then
        echo "❌ Theme '$theme' not found!"
        echo "Available themes:"
        for t in "$THEMES_DIR"/*.yuck; do
            if [ -f "$t" ]; then
                basename "$t" .yuck | sed 's/^/  - /'
            fi
        done
        exit 1
    fi
    
    echo "🎨 Applying theme: $theme"
    
    # Update the theme include in eww.yuck
    sed -i "s|^(include \"themes/.*\.yuck\")|^(include \"themes/$theme.yuck\")|" "$CONFIG_FILE"
    
    # Reload eww
    echo "🔄 Reloading eww..."
    eww reload
    
    echo "✅ Theme '$theme' applied successfully!"
}

get_current_theme() {
    grep "^(include \"themes/" "$CONFIG_FILE" | sed 's/.*themes\/\(.*\)\.yuck.*/\1/'
}

if [ $# -eq 0 ]; then
    current=$(get_current_theme)
    echo "Current theme: ${current:-"none"}"
    echo ""
    show_help
    exit 0
fi

case "$1" in
    -h|--help)
        show_help
        ;;
    *)
        apply_theme "$1"
        ;;
esac
