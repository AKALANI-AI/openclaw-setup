#!/bin/bash
set -e
echo "📦 Installing qmd..."

# Install
npm install -g @tobilu/qmd
echo "✅ qmd $(qmd --version) installed"

# Add memory backend to openclaw.json
OPENCLAW_CONFIG="$HOME/.openclaw/openclaw.json"
python3 - <<EOF
import json
with open('$OPENCLAW_CONFIG', 'r') as f:
    config = json.load(f)
if 'memory' not in config:
    config['memory'] = {"backend": "qmd", "citations": "auto"}
    with open('$OPENCLAW_CONFIG', 'w') as f:
        json.dump(config, f, indent=2)
    print("✅ Added memory backend to openclaw.json")
else:
    print("ℹ️  memory config already present, skipping")
EOF

# Setup collections
WORKSPACE="$HOME/.openclaw/workspace"
mkdir -p "$WORKSPACE/memory"

qmd collection add "$WORKSPACE/memory" --name memory 2>/dev/null || echo "ℹ️  memory collection already exists"
qmd collection add "$WORKSPACE" --name workspace --mask "**/*.md" 2>/dev/null || echo "ℹ️  workspace collection already exists"

qmd context add qmd://memory "Agent daily memory notes and logs" 2>/dev/null || true
qmd context add qmd://workspace "Agent workspace files, MEMORY.md, AGENTS.md, project docs" 2>/dev/null || true

echo "⏳ Generating embeddings (this takes 5-10 min on first run, models download ~333MB)..."
qmd embed

echo "✅ qmd setup complete"
