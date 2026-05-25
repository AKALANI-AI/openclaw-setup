# OpenClaw Setup

Automated setup scripts for OpenClaw agents. One command to install and configure everything.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/AKALANI-AI/openclaw-setup/main/install.sh | bash
```

## Prerequisites

Before running, ensure you have:

- **Node.js 22+** — [nodejs.org](https://nodejs.org)
- **OpenClaw** — Install with `npm install -g openclaw`

Check with:
```bash
node --version   # v22.0.0+
openclaw --version
```

## What Gets Installed

| Tool | Purpose |
|------|---------|
| **qmd** | Local semantic search for agent memory — find anything the agent has ever seen |
| **lossless-claw** | Lossless context management — the agent never forgets a conversation |

## What Gets Configured

- `~/.openclaw/workspace/` — Standard agent workspace structure
- `~/.openclaw/workspace/memory/` — Daily memory notes directory
- `~/.openclaw/openclaw.json` — Memory backend set to `qmd`
- qmd collections: `memory` + `workspace`
- lossless-claw plugin enabled

## Remote VPS Deploy (via SSH)

Run the setup directly on a remote server over SSH:

```bash
ssh user@your-vps "curl -fsSL https://raw.githubusercontent.com/AKALANI-AI/openclaw-setup/main/install.sh | bash"
```

For servers where `curl` may not be available:

```bash
ssh user@your-vps "wget -qO- https://raw.githubusercontent.com/AKALANI-AI/openclaw-setup/main/install.sh | bash"
```

## Remote VPS Deploy (via OpenClaw Sub-Agent)

You can also deploy to a remote VPS using OpenClaw's sub-agent system. Ask your OpenClaw agent:

```
Deploy openclaw setup to my VPS at user@your-vps
```

The agent will SSH in, run the install script, and report back.

Or directly instruct it:

```
SSH into user@your-vps, download and run https://raw.githubusercontent.com/AKALANI-AI/openclaw-setup/main/install.sh, then verify everything is working.
```

## Scripts

| Script | Purpose |
|--------|---------|
| `install.sh` | Master installer — run this |
| `setup-workspace.sh` | Creates workspace directory structure |
| `setup-qmd.sh` | Installs & configures qmd |
| `setup-lossless-claw.sh` | Installs & configures lossless-claw |
| `verify.sh` | Verifies everything is working |

## Running Individual Scripts

```bash
# Just verify your existing setup
bash verify.sh

# Just set up workspace structure
bash setup-workspace.sh

# Reinstall/reconfigure qmd only
bash setup-qmd.sh
```

## After Installation

Restart the OpenClaw gateway to activate all plugins:

```bash
openclaw gateway restart
```

Then verify:
```bash
bash verify.sh
```

## Troubleshooting

**qmd status check fails**: Run `qmd embed` to generate embeddings. First run downloads ~333MB of models and takes 5-10 minutes.

**lossless-claw not found**: Ensure OpenClaw version is 2026.5.12+. Run `npm update -g openclaw` then reinstall.

**memory backend check fails**: Run `setup-qmd.sh` again — it patches `openclaw.json` idempotently.

## License

MIT
