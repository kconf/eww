# Hyprland Widget Documentation

## Overview
The Hyprland widget provides workspace and window information for the Hyprland wayland compositor, following the same pattern as the scroll widget.

## Components

### Scripts
- `get_hyprland_workspaces` - Retrieves workspace information
- `get_hyprland_window_title` - Retrieves focused window title

### Widget Configuration
- `hyprland.yuck` - Widget definitions

## Workspace JSON Structure

The workspace script returns an array of workspace objects:

```json
[
  {
    "name": "1",
    "id": 1,
    "focused": true,
    "windows": 2
  },
  {
    "name": "2", 
    "id": 2,
    "focused": false,
    "windows": 0
  }
]
```

### Fields
- `name`: Workspace name (usually the ID as string)
- `id`: Workspace ID number
- `focused`: Boolean indicating if this workspace is currently focused
- `windows`: Number of windows in this workspace

## Available Widgets

### Main Widgets
- `hyprland-workspaces`: Clickable workspace buttons with window count tooltips
- `hyprland-window-info`: Display focused window title
- `hyprland-bar`: Combined workspace and window info widget

### Alternative Layouts
- `hyprland-workspaces-simple`: Simple workspace indicators
- `hyprland-workspaces-dots`: Dot-style workspace indicators

## Features

### Workspace Features
- **Click to Switch**: Click workspace buttons to switch workspaces
- **Visual States**: Different styles for focused/unfocused and occupied/empty workspaces
- **Window Count**: Tooltips show number of windows in each workspace
- **Real-time Updates**: Uses Hyprland's event system for instant updates

### Window Title Features
- **Length Limiting**: Truncates long titles to 50 characters
- **Fallback**: Shows "Desktop" when no window is focused
- **Real-time Updates**: Updates immediately when window focus changes

## CSS Classes

### Workspace Classes
- `.workspaces.hyprland-workspaces`: Main workspace container
- `.workspace`: Individual workspace button
- `.workspace.focused`: Currently focused workspace
- `.workspace.occupied`: Workspace with windows
- `.workspace.empty`: Workspace without windows

### Window Info Classes
- `.window-info.hyprland-window-info`: Window info container
- `.window-title`: Window title label

### Alternative Widget Classes
- `.workspaces-simple`: Simple workspace container
- `.workspace-indicator`: Simple workspace indicator
- `.workspaces-dots`: Dot-style workspace container
- `.workspace-dot`: Individual workspace dot

## Usage Examples

### Basic Usage
```yuck
;; Include the widget
(include "widgets/hyprland/hyprland.yuck")

;; Use in a bar
(defwidget bar []
  (box :class "bar"
    (hyprland-workspaces)
    (hyprland-window-info)))
```

### Combined Widget
```yuck
(defwidget my-bar []
  (hyprland-bar))  ; Includes both workspaces and window info
```

### Custom Workspace Widget
```yuck
(defwidget custom-workspaces []
  (box :class "my-workspaces"
    (for ws in hyprland-workspaces
      (button :onclick `hyprctl dispatch workspace ${ws.id}`
              :class "my-workspace ${ws.focused ? "active" : ""}"
              :tooltip "${ws.name}: ${ws.windows} windows"
        (label :text "${ws.name}")))))
```

## Event Monitoring

The scripts use Hyprland's built-in event system via Unix sockets:

### Workspace Events
- `workspace`: Workspace switch
- `focusedmon`: Monitor focus change  
- `createworkspace`: New workspace created
- `destroyworkspace`: Workspace destroyed

### Window Events
- `activewindow`: Window focus change
- `openwindow`: New window opened
- `closewindow`: Window closed
- `windowtitle`: Window title change

### Fallback
If `socat` is not available, the scripts fall back to polling every 2 seconds.

## Dependencies

### Required
- `hyprctl` - Hyprland control utility (part of Hyprland)
- `jq` - JSON processor

### Optional
- `socat` - For real-time event monitoring (recommended)

### Installation
```bash
# On Arch Linux
sudo pacman -S hyprland jq socat

# On Ubuntu/Debian  
sudo apt install jq socat
# (Hyprland needs to be installed separately)
```

## Hyprland Configuration

To use workspace switching, you may want to configure Hyprland keybindings:

```conf
# In ~/.config/hypr/hyprland.conf
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
# ... etc
```

## Performance
- **Event-driven updates**: Instant response to changes (with socat)
- **Minimal resource usage**: Single JSON query per update
- **Efficient parsing**: Uses jq for fast JSON processing

## Comparison with Scroll Widget

| Feature | Scroll | Hyprland |
|---------|---------|----------|
| Command | `scrollmsg` | `hyprctl` |
| Event System | sway-style | Hyprland socket |
| JSON Output | ✅ | ✅ |
| Window Count | ❌ | ✅ |
| Real-time Updates | ✅ | ✅ |
| Workspace IDs | Names only | Both ID and name |

## Troubleshooting

### No Output
- Ensure Hyprland is running
- Check if `hyprctl` command works: `hyprctl workspaces`

### No Real-time Updates
- Install `socat`: Scripts will fall back to polling
- Check if event socket exists: `/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock`

### Permission Issues
- Ensure scripts have execute permissions: `chmod +x get_hyprland_*`
