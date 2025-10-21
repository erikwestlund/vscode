#!/bin/bash

# Push Positron settings to backup location

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

echo -e "${YELLOW}Pushing Positron settings...${NC}"

# Check if Positron settings directory exists
if [ ! -d "$POSITRON_SETTINGS_DIR" ]; then
    echo -e "${RED}Error: Positron settings directory not found at $POSITRON_SETTINGS_DIR${NC}"
    echo "Make sure Positron is installed and has been run at least once."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy settings.json
if [ -f "$POSITRON_SETTINGS_DIR/settings.json" ]; then
    cp "$POSITRON_SETTINGS_DIR/settings.json" "$BACKUP_DIR/settings.json"
    echo -e "${GREEN}✓ Backed up settings.json${NC}"
else
    echo -e "${YELLOW}Warning: settings.json not found${NC}"
fi

# Copy keybindings.json if it exists
if [ -f "$POSITRON_SETTINGS_DIR/keybindings.json" ]; then
    cp "$POSITRON_SETTINGS_DIR/keybindings.json" "$BACKUP_DIR/keybindings.json"
    echo -e "${GREEN}✓ Backed up keybindings.json${NC}"
fi

# Copy snippets directory if it exists
if [ -d "$POSITRON_SETTINGS_DIR/snippets" ]; then
    cp -r "$POSITRON_SETTINGS_DIR/snippets" "$BACKUP_DIR/"
    echo -e "${GREEN}✓ Backed up snippets directory${NC}"
fi

# Copy extensions list
if command -v positron &> /dev/null; then
    positron --list-extensions > "$BACKUP_DIR/extensions.txt"
    echo -e "${GREEN}✓ Backed up extensions list${NC}"
else
    echo -e "${YELLOW}Warning: Positron CLI not found, skipping extensions backup${NC}"
fi

echo -e "${GREEN}Positron settings push completed!${NC}"
echo -e "Settings backed up to: $BACKUP_DIR"
