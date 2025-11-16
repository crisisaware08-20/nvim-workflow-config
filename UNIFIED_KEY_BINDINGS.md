# Unified Key Bindings: Backslash as the Command Key

## Philosophy

**One Mental Model, Two Tools**

- **Tmux prefix**: `\`
- **Nvim leader**: `<space>`

This creates a unified mental model where backslash always means "I'm about to issue a command" while avoiding conflicts with shell typing (unlike Space).

## Benefits

✅ **Reduced cognitive load** - Same key for both tools
✅ **No shell conflicts** - Unlike Space, doesn't interfere with typing commands
✅ **Vim standard** - Backslash is the traditional vim leader key
✅ **Muscle memory** - One pattern to learn across both tools


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
