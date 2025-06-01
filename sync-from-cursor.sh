#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Pull latest changes
echo "Pulling latest changes..."
git pull

# Define Cursor directory
CURSOR_USER_DIR=~/Library/Application\ Support/Cursor/User

# Create Cursor user directory if it doesn't exist
mkdir -p "$CURSOR_USER_DIR"

# Copy settings to Cursor user directory
echo "Copying settings to Cursor..."
cp settings.json "$CURSOR_USER_DIR/"
cp keybindings.json "$CURSOR_USER_DIR/"
cp launch.json "$CURSOR_USER_DIR/"

# Create snippets directory if it doesn't exist
mkdir -p "$CURSOR_USER_DIR/snippets"

# Copy all code snippets
echo "Copying code snippets..."
cp snippets/*.code-snippets "$CURSOR_USER_DIR/snippets/" 2>/dev/null || true

echo "Sync complete! Please restart Cursor for changes to take effect." 