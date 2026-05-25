#!/bin/bash
set -e
echo "📦 Installing lossless-claw..."

# Check OpenClaw version - need 2026.5.12+
OC_VERSION=$(openclaw --version 2>&1 | grep -oP '20\d\d\.\d+\.\d+' | head -1)
echo "OpenClaw version: $OC_VERSION"

# Update OpenClaw if needed
REQUIRED="2026.5.12"
if [[ "$OC_VERSION" < "$REQUIRED" ]]; then
    echo "⬆️  Updating OpenClaw to latest (required: $REQUIRED+)..."
    npm update -g openclaw
    echo "✅ OpenClaw updated: $(openclaw --version)"
fi

# Install plugin
openclaw plugins install @martian-engineering/lossless-claw
echo "✅ lossless-claw installed"

echo "✅ lossless-claw setup complete"
