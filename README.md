# NVim Workflow / Personal Development Environment

## Contents

- **[Unified Key Bindings](UNIFIED_KEY_BINDINGS.md)** - Space as the command key for both tmux and nvim
- [Tmux + Nvim Navigation](TMUX_NVIM_NAVIGATION.md) - Seamless navigation between tmux panes and nvim splits
- [OpenCodeAI Dual-Mode Setup](OPENCODE_WORKFLOW.md) - Multi-project and single-project AI assistant configuration

## Core Philosophy

**Backslash (`\`)** is the command key for both tools:
- **Tmux prefix**: `\` + command
- **Nvim leader**: `\` + command

This creates a unified mental model that reduces cognitive load while avoiding conflicts with shell typing.

## Quick Start

### OpenCodeAI Modes

This setup supports two modes of operation:

**Global Mode** (Multi-project):
```bash
opencode-global  # Launch in tmux AI window
```
Then in nvim: `<leader>og` to switch to global mode

**Local Mode** (Project-specific):
```bash
cd /path/to/project
opencode-local   # Launch in tmux AI window
```
Then in nvim: `<leader>ol` to switch to local mode

**Check Status**:
```bash
opencode-status  # See running instances
```

See [OPENCODE_WORKFLOW.md](OPENCODE_WORKFLOW.md) for detailed documentation.
