#!/bin/bash
WORKSPACE="$HOME/.openclaw/workspace"
mkdir -p "$WORKSPACE/memory"
mkdir -p "$WORKSPACE/skills"
mkdir -p "$WORKSPACE/scripts"

echo "🏗️  Setting up workspace structure..."

# Create MEMORY.md if missing
if [ ! -f "$WORKSPACE/MEMORY.md" ]; then
cat > "$WORKSPACE/MEMORY.md" <<MEMEOF
# MEMORY.md - Agent Long-Term Memory

## About This Agent
- Set up: $(date +%Y-%m-%d)
- Tools: qmd (semantic search), lossless-claw (lossless context)

## Tools & Integrations
### qmd
- Collections: memory + workspace
- Re-index: \`qmd embed\`
- Search: \`qmd search "query"\`

### lossless-claw
- Commands: /lcm, /lcm backup, /lcm rotate, /lcm doctor
- Purpose: Never lose conversation context — full lossless history
MEMEOF
echo "✅ Created MEMORY.md"
else
echo "ℹ️  MEMORY.md already exists, skipping"
fi

# Create heartbeat-state.json if missing
if [ ! -f "$WORKSPACE/memory/heartbeat-state.json" ]; then
cat > "$WORKSPACE/memory/heartbeat-state.json" <<'EOF'
{
  "lastChecks": {
    "email": null,
    "calendar": null,
    "weather": null
  }
}
EOF
echo "✅ Created heartbeat-state.json"
else
echo "ℹ️  heartbeat-state.json already exists, skipping"
fi

echo "✅ Workspace setup complete"
