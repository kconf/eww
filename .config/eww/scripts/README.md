# Scripts Directory

This directory contains utility scripts for the eww configuration:

## Available Scripts

### `switch_theme.sh`
Theme switching utility that allows you to change between available themes.

**Usage:**
```bash
./scripts/switch_theme.sh <theme-name>
```

**Available themes:**
- `gruvbox-dark`
- `catppuccin-mocha`

**Example:**
```bash
./scripts/switch_theme.sh catppuccin-mocha
```

### `test_functionality.sh`
Test script to verify that all eww components are working properly.

**Usage:**
```bash
./scripts/test_functionality.sh
```

### `test_multiwm.sh`
Test script for multi-window manager support.

**Usage:**
```bash
./scripts/test_multiwm.sh
```

## Notes

- All scripts should be run from the eww configuration root directory (`/home/hjw/.config/eww`)
- Make sure scripts are executable: `chmod +x scripts/*.sh`
