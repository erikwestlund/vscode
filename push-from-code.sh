#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Define VS Code directory
VSCODE_USER_DIR=~/Library/Application\ Support/Code/User

# Copy VS Code settings to repo
echo "Copying VS Code settings to repo..."
cp "$VSCODE_USER_DIR/settings.json" .
cp "$VSCODE_USER_DIR/keybindings.json" .
cp "$VSCODE_USER_DIR/launch.json" .

# Create snippets directory if it doesn't exist
mkdir -p snippets

# Copy all code snippets
echo "Copying code snippets..."
cp "$VSCODE_USER_DIR/snippets/"*.code-snippets snippets/ 2>/dev/null || true

# Git operations
echo "Committing changes..."
git add .
git commit -m "Sync VS Code settings: $(date +%Y-%m-%d\ %H:%M:%S)"
git push

echo "Sync complete! Settings have been pushed to GitHub." 