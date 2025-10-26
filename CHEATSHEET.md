# Quick Reference Cheat Sheet

> **Backslash (`\`) is your command key everywhere!**

## Navigation (No Space needed)

| Key | Action | Where |
|-----|--------|-------|
| `Ctrl` `h` | Left | tmux panes ↔ nvim splits |
| `Ctrl` `j` | Down | tmux panes ↔ nvim splits |
| `Ctrl` `k` | Up | tmux panes ↔ nvim splits |
| `Ctrl` `l` | Right | tmux panes ↔ nvim splits |

## Tmux Commands

### Panes
| Command | Action |
|---------|--------|
| `\` `\|` | Split horizontal |
| `\` `-` | Split vertical |
| `\` `h/j/k/l` | Navigate panes |
| `\` `H/J/K/L` | Resize panes |
| `\` `z` | Zoom/unzoom pane |
| `\` `q` | Kill pane |

### Windows
| Command | Action |
|---------|--------|
| `\` `c` | New window |
| `\` `n` | Next window |
| `\` `p` | Previous window |
| `\` `w` | List windows |
| `\` `Q` | Kill window |

### Sessions
| Command | Action |
|---------|--------|
| `\` `s` | List sessions |
| `\` `d` | Detach |

### Other
| Command | Action |
|---------|--------|
| `\` `:` | Command prompt |
| `\` `[` | Copy mode |
| `\` `r` | Reload config |

## Nvim Commands

### OpenCodeAI
| Command | Action | Context |
|---------|--------|---------|
| `\` `o` `g` | Global mode | Multi-project |
| `\` `o` `l` | Local mode | Single project |
| `\` `o` `m` | Show current mode | |
| `\` `o` `a` | Ask question | Cursor/selection |
| `\` `o` `t` | Toggle terminal | |
| `\` `o` `e` | Explain code | |
| `\` `o` `n` | New session | |
| `\` `o` `s` | Select prompt | |

### Files
| Command | Action |
|---------|--------|
| `\` `e` | File explorer |

## Quick Patterns

### Common Workflows

**Split and navigate:**
```
Space |    # Split horizontal
Ctrl l     # Move right
Space -    # Split vertical
Ctrl k     # Move up
```

**OpenCode multi-project:**
```
# In shell (tmux AI window)
opencode-global

# In nvim
Space o g       # Switch to global mode
Space o a       # Ask about code
```

**OpenCode single project:**
```
# In shell (tmux AI window)
cd ~/project && opencode-local

# In nvim (same directory)
Space o l       # Switch to local mode
Space o a       # Ask about code
```

## Tips

1. **Backslash (`\`) is always the "command" key** - both in tmux and nvim
2. **Ctrl+hjkl is for navigation** - works seamlessly across both
3. **Uppercase = bigger action** - e.g., `q` kills pane, `Q` kills window
4. **Double-tap `\` in tmux** - sends literal backslash to the terminal

## Emergency

| Issue | Solution |
|-------|----------|
| Tmux not responding | `Ctrl` `b` then try command (fallback prefix) |
| Exit tmux | `exit` or `\` `d` |
| Exit nvim | `:q` or `ZZ` |
| Kill tmux | `tmux kill-server` (from outside tmux) |

## See Full Documentation

- [UNIFIED_KEY_BINDINGS.md](UNIFIED_KEY_BINDINGS.md) - Complete guide
- [TMUX_NVIM_NAVIGATION.md](TMUX_NVIM_NAVIGATION.md) - Navigation details
- [OPENCODE_WORKFLOW.md](OPENCODE_WORKFLOW.md) - OpenCodeAI setup
