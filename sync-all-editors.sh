#!/bin/bash

# Sync settings from backup to all editors (VS Code, Positron)

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}Syncing VS Code/Positron settings${NC}"
echo -e "${BLUE}================================================================${NC}"
echo ""

# Track success/failure
synced=0
failed=0
skipped=0

# Sync to VS Code
if [ -d "$HOME/Library/Application Support/Code" ]; then
    echo -e "${YELLOW}→ Syncing to VS Code...${NC}"
    if "$SCRIPT_DIR/sync-from-code.sh" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ VS Code synced${NC}"
        ((synced++))
    else
        echo -e "${RED}✗ VS Code sync failed${NC}"
        ((failed++))
    fi
else
    echo -e "${YELLOW}⊘ VS Code not installed, skipping${NC}"
    ((skipped++))
fi

echo ""

# Sync to Positron
if [ -d "$HOME/Library/Application Support/Positron" ]; then
    echo -e "${YELLOW}→ Syncing to Positron...${NC}"
    if "$SCRIPT_DIR/sync-from-positron.sh" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Positron synced${NC}"
        ((synced++))
    else
        echo -e "${RED}✗ Positron sync failed${NC}"
        ((failed++))
    fi
else
    echo -e "${YELLOW}⊘ Positron not installed, skipping${NC}"
    ((skipped++))
fi

echo ""
echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}================================================================${NC}"
echo -e "${GREEN}Synced:  $synced${NC}"
echo -e "${RED}Failed:  $failed${NC}"
echo -e "${YELLOW}Skipped: $skipped${NC}"
echo ""

if [ $synced -gt 0 ]; then
    echo -e "${GREEN}Settings synced successfully!${NC}"
    echo -e "${YELLOW}Note: Restart your editors for all changes to take effect${NC}"
fi

# Exit with error if any sync failed
[ $failed -eq 0 ]
