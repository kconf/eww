# Multi-Window Manager Support Configuration

## Overview
This eww configuration supports multiple window managers with automatic detection and adaptation.

## Supported Window Managers

### ✅ Fully Supported
- **Hyprland** - Modern wayland compositor
- **Sway** - i3-compatible wayland compositor  
- **Scroll** - Sway fork with additional features
- **i3** - X11 tiling window manager

### 🔧 Auto-Detection Logic

The system detects the current WM using the following priority:

1. **Environment Variables**
   - `$HYPRLAND_INSTANCE_SIGNATURE` → Hyprland
   - `$SWAYSOCK` → Sway/Scroll
   - `$I3SOCK` → i3

2. **Command Availability**
   - `hyprctl` → Hyprland
   - `swaymsg` → Sway
   - `scrollmsg` → Scroll
   - `i3-msg` → i3

3. **Process Detection**
   - `pgrep hyprland` → Hyprland
   - `pgrep sway` → Sway
   - `pgrep i3` → i3

## Architecture

### Core Components

```
utils/
├── detect_wm              # WM detection script

widgets/
├── universal/             # Universal widgets
│   ├── universal.yuck     # Main universal config
│   ├── workspaces.yuck    # Universal workspaces
│   └── window-info.yuck   # Universal window info
├── hyprland/              # Hyprland-specific widgets
├── scroll/                # Scroll/Sway-specific widgets
├── wifi/                  # WiFi widget
├── pulseaudio/            # Audio widget
└── date/                  # Date/time widget
```

### Data Flow

1. `detect_wm` script identifies current WM
2. Universal widgets conditionally load WM-specific scripts
3. Workspace/window data flows through unified interface
4. CSS classes include WM-specific styling

## Usage

### Basic Usage
```yuck
;; Include universal widgets
(include "widgets/universal/universal.yuck")

;; Use in your bar
(defwidget my-bar []
  (box :class "bar"
    (universal-workspaces)    ;; Auto-adapts to current WM
    (universal-window-info))) ;; Auto-adapts to current WM
```

### Advanced Usage
```yuck
;; Include specific WM widgets for advanced features
(include "widgets/hyprland/hyprland.yuck")
(include "widgets/scroll/scroll.yuck")

;; Conditional usage
(defwidget advanced-bar []
  (box :class "bar"
    (if {current-wm == "hyprland"}
      (hyprland-workspaces)
      (universal-workspaces))))
```

## CSS Styling

### Universal Classes
```css
.workspaces.universal-workspaces { /* Universal workspace container */ }
.window-info.universal-window-info { /* Universal window info */ }
```

### WM-Specific Classes
```css
.workspace.wm-hyprland { /* Hyprland workspace styles */ }
.workspace.wm-scroll { /* Scroll workspace styles */ }
.workspace.wm-sway { /* Sway workspace styles */ }
.window-info.wm-hyprland { /* Hyprland window info */ }
```

### State Classes
```css
.workspace.focused { /* Focused workspace */ }
.workspace.occupied { /* Workspace with windows */ }
.workspace.empty { /* Empty workspace */ }
```

## Customization

### Adding New Window Managers

1. **Create WM-specific scripts**
   ```bash
   mkdir widgets/new-wm
   # Create get_workspaces and get_window_title scripts
   ```

2. **Update detection script**
   ```bash
   # Add detection logic in utils/detect_wm
   ```

3. **Update universal widgets**
   ```yuck
   ;; Add conditions in workspaces.yuck and window-info.yuck
   ```

### WM-Specific Features

Each WM may have unique features:

#### Hyprland
- Window count per workspace
- Workspace IDs and names
- Real-time event monitoring

#### Scroll/Sway
- Workspace names
- Tree-based window information
- Event subscription

#### i3
- Workspace names and numbers
- Window class information

## Performance Considerations

### Optimizations
- **Single Detection**: WM detected once every 10 seconds
- **Conditional Loading**: Only loads scripts for current WM
- **Event-Driven**: Uses real-time events when available
- **Fallback Polling**: Graceful degradation to polling

### Resource Usage
- **Hyprland**: ~5MB RAM, real-time events
- **Scroll/Sway**: ~4MB RAM, real-time events
- **Unknown WM**: <1MB RAM, no background processes

## Troubleshooting

### Common Issues

#### No Workspaces Shown
```bash
# Check WM detection
./utils/detect_wm

# Verify WM-specific commands
hyprctl workspaces  # For Hyprland
swaymsg -t get_workspaces  # For Sway
```

#### Wrong WM Detected
- Check environment variables
- Verify process names
- Update detection logic if needed

#### Performance Issues
- Ensure socat is installed for real-time events
- Check if fallback polling is being used
- Monitor script resource usage

### Debug Mode

Enable debug information:
```yuck
;; Show current WM
(wm-indicator)

;; Check detection
(label :text "WM: ${current-wm}")
```

## Migration from Single-WM Setup

### From Scroll-only
```yuck
;; Old
(workspaces :array workspacesArray)
(window-info)

;; New (automatic)
(universal-workspaces)
(universal-window-info)
```

### From Hyprland-only
```yuck
;; Old
(hyprland-workspaces)
(hyprland-window-info)

;; New (automatic)
(universal-workspaces)
(universal-window-info)
```

The universal widgets maintain backward compatibility while adding multi-WM support.
