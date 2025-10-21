#!/bin/bash

# Pull Positron settings from backup location

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/settings"

# Positron settings directory
POSITRON_SETTINGS_DIR="$HOME/Library/Application Support/Positron/User"

echo -e "${YELLOW}Pulling Positron settings...${NC}"

# Check if backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}Error: No backup found at $BACKUP_DIR${NC}"
    echo "Run push-from-positron.sh first to create a backup."
    exit 1
fi

# Create Positron settings directory if it doesn't exist
mkdir -p "$POSITRON_SETTINGS_DIR"

# Restore settings.json
if [ -f "$BACKUP_DIR/settings.json" ]; then
    cp "$BACKUP_DIR/settings.json" "$POSITRON_SETTINGS_DIR/settings.json"
    echo -e "${GREEN}✓ Restored settings.json${NC}"
else
    echo -e "${YELLOW}Warning: settings.json not found in backup${NC}"
fi

# Restore keybindings.json if it exists
if [ -f "$BACKUP_DIR/keybindings.json" ]; then
    cp "$BACKUP_DIR/keybindings.json" "$POSITRON_SETTINGS_DIR/keybindings.json"
    echo -e "${GREEN}✓ Restored keybindings.json${NC}"
fi

# Restore snippets directory if it exists
if [ -d "$BACKUP_DIR/snippets" ]; then
    cp -r "$BACKUP_DIR/snippets" "$POSITRON_SETTINGS_DIR/"
    echo -e "${GREEN}✓ Restored snippets directory${NC}"
fi

# Install extensions if list exists
if [ -f "$BACKUP_DIR/extensions.txt" ] && command -v positron &> /dev/null; then
    echo -e "${YELLOW}Installing extensions...${NC}"
    while IFS= read -r extension; do
        positron --install-extension "$extension" 2>/dev/null || echo -e "${YELLOW}Failed to install: $extension${NC}"
    done < "$BACKUP_DIR/extensions.txt"
    echo -e "${GREEN}✓ Extensions installation completed${NC}"
else
    echo -e "${YELLOW}Warning: Extensions list not found or Positron CLI not available${NC}"
fi

echo -e "${GREEN}Positron settings pull completed!${NC}"
echo -e "${YELLOW}Note: Restart Positron for all changes to take effect${NC}"
