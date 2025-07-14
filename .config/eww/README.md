# EWW Multi-WM Configuration

This configuration provides separate bars for different window managers, making it simple and maintainable.

## Supported Window Managers

- **Hyprland** - Uses `hyprland-bar`
- **Scroll/Sway** - Uses `scroll-bar`

## Usage

### Manual Launch (Recommended)

Choose the appropriate script for your window manager:

```bash
# For Hyprland
~/.config/eww/launch_hyprland.sh

# For Scroll/Sway
~/.config/eww/launch_scroll.sh
```

### Auto-Detection Launch

If you want automatic WM detection:

```bash
~/.config/eww/launch_bar.sh
```

### Direct EWW Commands

You can also use eww directly:

```bash
# For Hyprland
eww open hyprland-bar

# For Scroll/Sway  
eww open scroll-bar

# Close all bars
eww kill
```

## Integration with WM Startup

### Hyprland

Add to your `~/.config/hypr/hyprland.conf`:

```
exec-once = ~/.config/eww/launch_hyprland.sh
```

### Scroll

Add to your scroll configuration:

```
exec ~/.config/eww/launch_scroll.sh
```

### Sway

Add to your `~/.config/sway/config`:

```
exec ~/.config/eww/launch_scroll.sh
```

## Widget Features

Each bar uses a unified layout:

- **Left**: Workspaces (clickable workspace indicators)
- **Center**: Active window title
- **Right**: Status bar with WiFi, volume, time, and system tray

### Workspace Features

- Click to switch workspaces
- Visual indication of:
  - Focused workspace
  - Occupied workspaces (with windows)
  - Empty workspaces
- Real-time updates via WM event streams

### Window Title

- Shows the title of the currently active window
- Automatically truncated if too long
- Real-time updates when switching windows

### Status Bar Components

- **WiFi**: Shows current connection status with auto-updates
- **Volume**: Click to open pavucontrol, displays current volume level
- **Time**: Current time display with hover for calendar popup
- **System Tray**: Shows system tray icons for running applications

## File Structure

```
~/.config/eww/
├── eww.yuck                 # Main configuration
├── eww.scss                 # Styling
├── launch_bar.sh           # Auto-detection launcher
├── launch_hyprland.sh      # Hyprland launcher
├── launch_scroll.sh        # Scroll/Sway launcher
└── widgets/
    ├── hyprland/           # Hyprland-specific widgets
    ├── scroll/             # Scroll/Sway-specific widgets  
    ├── date/               # Date/time widget
    ├── pulseaudio/         # Audio volume widget
    └── wifi/               # WiFi status widget
```

## Customization

### Adding New Window Managers

1. Create a new widget file in `widgets/<wm>/`
2. Add the widget includes to `eww.yuck`
3. Define a new window in `eww.yuck`
4. Create a launch script
5. Update this README

### Styling

Edit `eww.scss` to customize the appearance. Each bar has specific CSS classes:

- `.hyprland-workspaces` - Hyprland workspace styling
- `.scroll-workspaces` - Scroll workspace styling  
- `.window-info` - Window title styling
- `.status-item` - Status widget styling

## Troubleshooting

### Bar not appearing

1. Check if eww daemon is running: `ps aux | grep eww`
2. Check eww logs: `eww logs`
3. Verify window manager is detected: `pgrep -x <wm_name>`

### Workspace switching not working

1. Ensure the WM command tools are available:
   - Hyprland: `hyprctl`
   - Scroll: `scrollmsg`  
   - Sway: `swaymsg`

### Real-time updates not working

1. Check if socat is installed: `which socat`
2. Verify socket paths are correct for your WM
3. Check script permissions: `ls -la widgets/*/get_*`
