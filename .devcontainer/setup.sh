#!/bin/bash

set -e

echo "🚀 Setting up Val.town development environment..."

# Install Deno (non-interactive)
echo "📦 Installing Deno..."
export DENO_INSTALL="/home/node/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
curl -fsSL https://deno.land/install.sh | sh -s -- -y

# Add Deno to PATH permanently
echo 'export DENO_INSTALL="/home/node/.deno"' >> ~/.bashrc
echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

# Install Val CLI (vt) via Deno
echo "📦 Installing Val CLI (vt)..."
deno install --global --force --reload --allow-read --allow-write --allow-env --allow-net jsr:@valtown/vt

# Install Claude Code CLI
echo "📦 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# Verify installations
echo ""
echo "✅ Installation complete!"
echo ""
echo "Installed versions:"
echo "  - Deno: $(deno --version | head -n 1)"
echo "  - Val CLI: $(vt --version 2>/dev/null || echo 'installed')"
echo "  - GitHub CLI: $(gh --version | head -n 1)"
echo "  - Claude Code: $(claude-code --version 2>/dev/null || echo 'installed')"
echo ""
echo "🎉 Ready to build Val.town vals with Claude Code!"
echo ""
echo "Next steps:"
echo "  1. Authenticate with Val.town: vt login"
echo "  2. Authenticate with GitHub: gh auth login"
echo "  3. Start building!"
