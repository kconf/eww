# WiFi Widget Documentation

## Overview
The WiFi widget provides comprehensive wireless network information through a JSON object that updates every 5 seconds.

## JSON Structure

The `wifi-poll` variable contains the following fields:

### Connection Status
- `status`: Connection status ("connected", "disconnected", "no_interface", "no_network")
- `connected`: Boolean indicating if WiFi is connected
- `status_text`: Human-readable status text

### Network Information
- `ssid`: Network name (SSID)
- `security`: Security type (e.g., "WPA2-Personal", "WPA3-Personal")
- `frequency`: WiFi frequency in MHz

### Signal Information
- `signal_strength_dbm`: Signal strength in dBm (e.g., -45)
- `signal_strength_percent`: Signal strength as percentage (0-100)
- `signal_icon`: Unicode icon representing signal strength
  - `󰤨` Full signal (75-100%)
  - `󰤥` Good signal (50-74%)
  - `󰤢` Weak signal (25-49%)
  - `󰤯` Very weak signal (0-24%)
  - `󰤭` Disconnected/No signal

### Hardware Information
- `interface`: WiFi interface name (e.g., "wlan0")
- `ip_address`: Current IP address
- `mac_address`: MAC address of the WiFi interface

## Sample JSON Output

### Connected State
```json
{
  "status": "connected",
  "connected": true,
  "ssid": "MyWiFiNetwork",
  "signal_strength_dbm": -45,
  "signal_strength_percent": 75,
  "signal_icon": "󰤥",
  "interface": "wlan0",
  "security": "WPA2-Personal",
  "frequency": "5785",
  "ip_address": "192.168.1.100",
  "mac_address": "aa:bb:cc:dd:ee:ff",
  "status_text": "MyWiFiNetwork (75%)"
}
```

### Disconnected State
```json
{
  "status": "disconnected",
  "connected": false,
  "ssid": "",
  "signal_strength_dbm": 0,
  "signal_strength_percent": 0,
  "signal_icon": "󰤭",
  "interface": "wlan0",
  "security": "",
  "frequency": "",
  "ip_address": "",
  "mac_address": "",
  "status_text": "Disconnected"
}
```

## Usage Examples

### Basic WiFi Display
```yuck
(label :text "${wifi-poll.signal_icon} ${wifi-poll.status_text}")
```

### Signal Strength Only
```yuck
(label :text "${wifi-poll.signal_icon} ${wifi-poll.signal_strength_percent}%")
```

### Connection Status Check
```yuck
(label :text "${wifi-poll.connected ? wifi-poll.ssid : 'Disconnected'}")
```

### Detailed Tooltip
```yuck
(box :tooltip "${wifi-poll.ssid} - ${wifi-poll.signal_strength_percent}% (${wifi-poll.signal_strength_dbm}dBm)"
     (label :text "${wifi-poll.signal_icon}"))
```

## Available Widgets

### Core Widget
- `wifi`: Main WiFi widget with icon, status text, and detailed tooltip

### Additional Widgets
- `wifi-simple`: Just the signal icon
- `wifi-detailed`: SSID and signal strength in vertical layout
- `wifi-compact`: Icon and percentage
- `wifi-status`: Icon and connection status
- `wifi-info-panel`: Comprehensive information panel

## Example Usage in Bar

```yuck
(defwidget bar []
  (box :class "bar"
       :orientation "h"
    (wifi)           ;; Main WiFi widget
    (wifi-simple)    ;; Just the icon
    (wifi-compact))) ;; Icon with percentage
```

## Styling Classes

The widgets use these CSS classes for styling:
- `.wifi-item`: Main WiFi widget
- `.wifi-simple`: Simple icon widget
- `.wifi-detailed`: Detailed widget container
- `.wifi-compact`: Compact widget
- `.wifi-status`: Status widget
- `.wifi-info-panel`: Information panel
- `.wifi-icon`, `.wifi-icon-large`: Signal icons
- `.wifi-ssid`, `.wifi-ssid-large`: Network names
- `.wifi-signal`: Signal strength text
- `.wifi-details`: Details container

## Signal Strength Interpretation

The signal strength is converted from dBm to percentage using these ranges:
- **Excellent (100%)**: ≥ -50 dBm
- **Good (75%)**: -60 to -51 dBm  
- **Fair (50%)**: -70 to -61 dBm
- **Poor (25%)**: -80 to -71 dBm
- **Very Poor (0%)**: < -80 dBm

## Dependencies

The script requires:
- `networkctl` (systemd-networkd)
- `iwctl` (iwd - iNet Wireless Daemon)
- `ip` command for network information
