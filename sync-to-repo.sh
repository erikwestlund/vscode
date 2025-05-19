#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Copy VS Code settings from user directory
echo "Copying VS Code settings..."
cp ~/Library/Application\ Support/Code/User/settings.json .
cp ~/Library/Application\ Support/Code/User/keybindings.json .
cp ~/Library/Application\ Support/Code/User/launch.json .

# Create snippets directory if it doesn't exist
mkdir -p snippets

# Copy all code snippets
echo "Copying code snippets..."
cp ~/Library/Application\ Support/Code/User/snippets/*.code-snippets snippets/ 2>/dev/null || true

# Git operations
echo "Committing changes..."
git add .
git commit -m "Sync VS Code settings: $(date +%Y-%m-%d\ %H:%M:%S)"
git push

echo "Sync complete!" 