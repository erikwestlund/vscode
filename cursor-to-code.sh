#!/bin/bash

# Save the current directory
ORIGINAL_DIR=$(pwd)

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Define directories
CURSOR_USER_DIR=~/Library/Application\ Support/Cursor/User
VSCODE_USER_DIR=~/Library/Application\ Support/Code/User

# Create VS Code user directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR"

# Copy settings from Cursor to VS Code
echo "Copying settings from Cursor to VS Code..."
cp "$CURSOR_USER_DIR/settings.json" "$VSCODE_USER_DIR/"
cp "$CURSOR_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/"
cp "$CURSOR_USER_DIR/launch.json" "$VSCODE_USER_DIR/"

# Create snippets directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR/snippets"

# Copy all code snippets
echo "Copying code snippets..."
cp "$CURSOR_USER_DIR/snippets/"*.code-snippets "$VSCODE_USER_DIR/snippets/" 2>/dev/null || true

echo "Sync complete! Please restart VS Code for changes to take effect."

# Return to the original directory
cd "$ORIGINAL_DIR" 