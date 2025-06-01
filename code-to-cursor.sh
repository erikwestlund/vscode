#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Define directories
CURSOR_USER_DIR=~/Library/Application\ Support/Cursor/User
VSCODE_USER_DIR=~/Library/Application\ Support/Code/User

# Create Cursor user directory if it doesn't exist
mkdir -p "$CURSOR_USER_DIR"

# Copy settings from VS Code to Cursor
echo "Copying settings from VS Code to Cursor..."
cp "$VSCODE_USER_DIR/settings.json" "$CURSOR_USER_DIR/"
cp "$VSCODE_USER_DIR/keybindings.json" "$CURSOR_USER_DIR/"
cp "$VSCODE_USER_DIR/launch.json" "$CURSOR_USER_DIR/"

# Create snippets directory if it doesn't exist
mkdir -p "$CURSOR_USER_DIR/snippets"

# Copy all code snippets
echo "Copying code snippets..."
cp "$VSCODE_USER_DIR/snippets/"*.code-snippets "$CURSOR_USER_DIR/snippets/" 2>/dev/null || true

echo "Sync complete! Please restart Cursor for changes to take effect." 