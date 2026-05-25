#!/bin/bash
set -e

echo "🎵 BotMarley OpenClaw Setup"
echo "============================"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Step 1: Check prerequisites
echo "📋 Checking prerequisites..."
node --version || { echo "❌ Node.js not found. Install Node.js 22+ first."; exit 1; }
npm --version || { echo "❌ npm not found."; exit 1; }
openclaw --version || { echo "❌ OpenClaw not found. Install OpenClaw first."; exit 1; }
echo "✅ Prerequisites OK"

# Step 2: Setup workspace
bash "$SCRIPT_DIR/setup-workspace.sh"

# Step 3: Install qmd
bash "$SCRIPT_DIR/setup-qmd.sh"

# Step 4: Install lossless-claw
bash "$SCRIPT_DIR/setup-lossless-claw.sh"

# Step 5: Verify
bash "$SCRIPT_DIR/verify.sh"

echo ""
echo "🎉 Setup complete! Restart your OpenClaw gateway to activate all changes."
echo "   openclaw gateway restart"
