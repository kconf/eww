#!/usr/bin/env bash
# Theme switcher for eww configuration

THEMES_DIR="$(dirname "$0")/themes"
CONFIG_DIR="$(dirname "$0")"

show_help() {
    echo "EWW Theme Switcher"
    echo "Usage: $0 [theme-name]"
    echo ""
    echo "Available themes:"
    for theme in "$THEMES_DIR"/*.scss; do
        if [ -f "$theme" ] && [[ ! "$theme" =~ current\.scss$ ]]; then
            basename "$theme" .scss | sed 's/^/  - /'
        fi
    done
    echo ""
    echo "Examples:"
    echo "  $0 gruvbox-dark"
    echo "  $0 catppuccin-mocha"
}

apply_theme() {
    local theme="$1"
    local theme_file="$THEMES_DIR/$theme.scss"
    
    if [ ! -f "$theme_file" ]; then
        echo "❌ Theme '$theme' not found!"
        echo "Available themes:"
        for t in "$THEMES_DIR"/*.scss; do
            if [ -f "$t" ] && [[ ! "$t" =~ current\.scss$ ]]; then
                basename "$t" .scss | sed 's/^/  - /'
            fi
        done
        exit 1
    fi
    
    echo "🎨 Applying theme: $theme"
    
    # Update the current theme symlink
    cd "$THEMES_DIR"
    ln -sf "$theme.scss" current.scss
    cd - > /dev/null
    
    # Copy theme to main CSS file
    cp "$theme_file" "$CONFIG_DIR/eww.scss"
    
    # Reload eww
    echo "🔄 Reloading eww..."
    eww reload
    
    echo "✅ Theme '$theme' applied successfully!"
}

get_current_theme() {
    if [ -L "$THEMES_DIR/current.scss" ]; then
        readlink "$THEMES_DIR/current.scss" | sed 's/\.scss$//'
    else
        echo "none"
    fi
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
