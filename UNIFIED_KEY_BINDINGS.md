# Unified Key Bindings: Backslash as the Command Key

## Philosophy

**One Mental Model, Two Tools**

Both tmux and nvim use **backslash (`\`)** as the "command" key:
- **Tmux prefix**: `\`
- **Nvim leader**: `\`

This creates a unified mental model where backslash always means "I'm about to issue a command" while avoiding conflicts with shell typing (unlike Space).

## Benefits

✅ **Reduced cognitive load** - Same key for both tools
✅ **No shell conflicts** - Unlike Space, doesn't interfere with typing commands
✅ **Vim standard** - Backslash is the traditional vim leader key
✅ **Muscle memory** - One pattern to learn across both tools

## Quick Reference

### Tmux Commands (\ + key)

| Binding | Action | Mnemonics |
|---------|--------|-----------|
| `\` `\|` | Split horizontal | Visual: vertical line |
| `\` `-` | Split vertical | Visual: horizontal line |
| `\` `h/j/k/l` | Navigate panes | Vim navigation |
| `\` `H/J/K/L` | Resize panes | Shift = bigger action |
| `\` `c` | New window | **C**reate |
| `\` `n` | Next window | **N**ext |
| `\` `p` | Previous window | **P**revious |
| `\` `w` | Choose window | **W**indow list |
| `\` `q` | Kill pane | **Q**uit |
| `\` `Q` | Kill window | Shift-Q = bigger quit |
| `\` `s` | Choose session | **S**ession |
| `\` `d` | Detach | **D**etach |
| `\` `z` | Zoom pane | **Z**oom |
| `\` `r` | Reload config | **R**eload |
| `\` `:` | Command prompt | Like vim |
| `\` `[` | Copy mode | Like vim |

### Nvim Commands (\ + key)

**OpenCodeAI:**
| Binding | Action | Mnemonics |
|---------|--------|-----------|
| `\` `o` `g` | Global mode | **O**pencode **G**lobal |
| `\` `o` `l` | Local mode | **O**pencode **L**ocal |
| `\` `o` `m` | Show mode | **O**pencode **M**ode |
| `\` `o` `a` | Ask OpenCode | **O**pencode **A**sk |
| `\` `o` `t` | Toggle terminal | **O**pencode **T**oggle |
| `\` `o` `e` | Explain code | **O**pencode **E**xplain |
| `\` `o` `n` | New session | **O**pencode **N**ew |
| `\` `o` `s` | Select prompt | **O**pencode **S**elect |
| `\` `o` `+` | Add to prompt | Add more context |

**Navigation:**
| Binding | Action | Notes |
|---------|--------|-------|
| `Ctrl` `h/j/k/l` | Navigate splits/panes | Seamless nvim ↔ tmux |
| `\` `e` | File explorer | **E**xplore |

## The Pattern

### Two-Level Commands

Both tools use a **prefix + action** pattern:

```
\ → [category/action] → [specific command]
```

**Examples:**

**Tmux:**
- `\` + `c` = Create window
- `\` + `h` = Navigate left
- `\` + `:` = Command mode

**Nvim:**
- `\` + `o` + `g` = OpenCode Global mode
- `\` + `o` + `a` = OpenCode Ask
- `\` + `e` = Explore files

### Direct Navigation (No \ needed)

For frequently used navigation, use **Ctrl + h/j/k/l** which works seamlessly across both nvim splits and tmux panes.

## Comparison with Common Alternatives

| Prefix | Pros | Cons | Our Choice |
|--------|------|------|------------|
| `Ctrl-a` | Traditional | Conflicts with readline, requires two-key combo | ❌ |
| `Ctrl-b` | Tmux default | Hard to reach, requires two-key combo | ❌ |
| Backtick `` ` `` | Single key | Can conflict with shell/markdown | ❌ |
| `\` (backslash) | Vim default leader | Hard to reach, escape character issues | ❌ |
| **`\`** | **Easy, fast, comfortable** | **Losing Space in normal mode** | **✅** |

**Note**: In nvim normal mode, Space no longer moves cursor right (default behavior). This is a worthwhile trade-off since:
- `l` (lowercase L) moves right just as easily
- Space as leader is vastly more valuable
- Consistent with tmux creates unified experience

## Migration Tips

If you're used to different prefixes:

### From `Ctrl-a` (tmux)

The commands are the same, just replace `Ctrl-a` with `\`:
- Old: `Ctrl-a` `c` → New: `\` `c`
- Old: `Ctrl-a` `h` → New: `\` `h`

### From `\` (nvim default leader)

Your existing keymaps automatically work with Space:
- Old: `\` `o` `g` → New: `\` `o` `g`
- Old: `\` `e` → New: `\` `e`

## Testing the New Setup

### 1. Reload Configurations

```bash
# Reload tmux config (from tmux)
Space r

# Or from shell
tmux source-file ~/.tmux.conf

# Reload nvim config (from nvim)
:source $MYVIMRC
# Or restart nvim
```

### 2. Test Tmux

```bash
# Launch tmux
tmux

# Try commands:
Space c         # Create new window
Space |         # Split horizontal
Space h         # Navigate left
Space :         # Command prompt (type "display-message 'It works!'")
```

### 3. Test Nvim

```bash
nvim

# Try commands:
Space e         # Open file explorer
Space o m       # Show OpenCode mode
Space o a       # Ask OpenCode
```

## Troubleshooting

### Space not working in tmux

**Symptom**: Nothing happens when you press Space

**Fix**: 
```bash
# Reload tmux configuration
tmux source-file ~/.tmux.conf

# Or restart tmux
tmux kill-server
tmux
```

### Leader not working in nvim

**Symptom**: Old `\` keymaps still work but Space doesn't

**Fix**:
```vim
" In nvim, verify leader is set:
:echo mapleader
" Should output: <Space> (shown as a space character)

" Reload config:
:source ~/.config/nvim/init.lua
```

### Space types a space in nvim

**Symptom**: Pressing Space in normal mode inserts a space

**Fix**: Make sure you're in normal mode (press `Esc` first) and that leader is properly set in `options.lua`.

## Advanced: Visual Reminder

You can add a visual indicator in your tmux status bar:

```tmux
# Add to .tmux.conf status-left
set -g status-left '#[fg=colour233,bg=colour245,bold] ␣ '  # ␣ is the space symbol
```

This reminds you that Space is your command key!

## See Also

- [Tmux + Nvim Navigation](TMUX_NVIM_NAVIGATION.md) - Seamless Ctrl+h/j/k/l navigation
- [OpenCodeAI Dual-Mode](OPENCODE_WORKFLOW.md) - OpenCodeAI configuration
- [Tmux Config](.tmux.conf) - Full tmux configuration
- [Nvim Options](nvim/lua/config/options.lua) - Full nvim options
