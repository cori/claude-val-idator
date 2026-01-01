#!/bin/bash
# Sync devcontainer config from claude-val-idator template to another repo
# Usage: ./sync-devcontainer.sh /path/to/target/repo

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/target/repo"
  exit 1
fi

TARGET_REPO="$1"

if [ ! -d "$TARGET_REPO/.git" ]; then
  echo "Error: $TARGET_REPO is not a git repository"
  exit 1
fi

echo "🔄 Syncing devcontainer config to $TARGET_REPO..."

# Create .devcontainer directory if it doesn't exist
mkdir -p "$TARGET_REPO/.devcontainer"

# Copy devcontainer files
echo "📦 Copying .devcontainer files..."
cp .devcontainer/devcontainer.json "$TARGET_REPO/.devcontainer/"
cp .devcontainer/setup.sh "$TARGET_REPO/.devcontainer/"
chmod +x "$TARGET_REPO/.devcontainer/setup.sh"

# Copy .env.example if it doesn't exist
if [ ! -f "$TARGET_REPO/.env.example" ]; then
  echo "📝 Copying .env.example..."
  cp .env.example "$TARGET_REPO/"
fi

# Update .gitignore to include .env if not already there
if [ -f "$TARGET_REPO/.gitignore" ]; then
  if ! grep -q "^\.env$" "$TARGET_REPO/.gitignore"; then
    echo "📝 Adding .env to .gitignore..."
    echo "" >> "$TARGET_REPO/.gitignore"
    echo "# Environment variables" >> "$TARGET_REPO/.gitignore"
    echo ".env" >> "$TARGET_REPO/.gitignore"
  fi
fi

echo "✅ Devcontainer config synced successfully!"
echo ""
echo "Next steps:"
echo "  1. Review the changes in $TARGET_REPO"
echo "  2. Commit the changes: cd $TARGET_REPO && git add .devcontainer .env.example .gitignore"
echo "  3. Rebuild your devcontainer"
