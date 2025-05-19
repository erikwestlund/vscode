# VS Code / Cursor Settings Sync

This repository helps you maintain and sync your VS Code and Cursor editor settings across different macOS machines. It provides scripts to sync settings between the two editors and to/from GitHub.

## Repository Structure

- `settings.json` - Editor settings
- `keybindings.json` - Keyboard shortcuts
- `launch.json` - Debug configurations
- `snippets/` - Directory containing code snippets
- Various sync scripts (see below)

## Sync Scripts

### Push to GitHub
- `push-from-code.sh` - Push VS Code settings to GitHub
- `push-from-cursor.sh` - Push Cursor settings to GitHub

### Pull from GitHub
- `sync-from-code.sh` - Pull settings from GitHub to VS Code
- `sync-from-cursor.sh` - Pull settings from GitHub to Cursor

### Sync Between Editors
- `code-to-cursor.sh` - Copy VS Code settings to Cursor
- `cursor-to-code.sh` - Copy Cursor settings to VS Code

## Recommended Aliases

Add these to your `.aliases` file for easy access:

```bash
# Navigation
alias vscode='cd ~/code/vscode'

# Push to GitHub
alias vspush='cd ~/code/vscode && ./push-from-code.sh'
alias curpush='cd ~/code/vscode && ./push-from-cursor.sh'

# Pull from GitHub
alias vspull='cd ~/code/vscode && ./sync-from-code.sh'
alias curpull='cd ~/code/vscode && ./sync-from-cursor.sh'

# Sync between editors
alias vstocur='cd ~/code/vscode && ./code-to-cursor.sh'
alias curtovs='cd ~/code/vscode && ./cursor-to-code.sh'
```

## Usage Examples

1. Push your current VS Code settings to GitHub:
   ```bash
   vspush
   ```

2. Pull the latest settings from GitHub to Cursor:
   ```bash
   curpull
   ```

3. Copy your Cursor settings to VS Code:
   ```bash
   curtovs
   ```

## Requirements

- macOS (scripts use macOS-specific paths)
- Git
- VS Code and/or Cursor installed

## Note

After syncing settings, you may need to restart the respective editor for changes to take effect. 