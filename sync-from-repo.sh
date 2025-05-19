#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Pull latest changes
echo "Pulling latest changes..."
git pull

# Create VS Code user directory if it doesn't exist
VSCODE_USER_DIR=~/Library/Application\ Support/Code/User
mkdir -p "$VSCODE_USER_DIR"

# Copy settings to VS Code user directory
echo "Copying settings to VS Code..."
cp settings.json "$VSCODE_USER_DIR/"
cp keybindings.json "$VSCODE_USER_DIR/"
cp launch.json "$VSCODE_USER_DIR/"

# Create snippets directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR/snippets"

# Copy all code snippets
echo "Copying code snippets..."
cp snippets/*.code-snippets "$VSCODE_USER_DIR/snippets/" 2>/dev/null || true

echo "Sync complete! Please restart VS Code for changes to take effect." 