# OpenCodeAI Dual-Mode Configuration

## Overview

This configuration enables flexible use of OpenCodeAI across your projects, supporting both multi-project and single-project workflows through two operational modes.

## Modes

### Global Mode (Multi-project)
- **Description**: Single OpenCodeAI instance running on fixed port 12345
- **Accessibility**: Works from nvim in ANY project directory
- **Context**: Shared context across all projects
- **File paths**: Absolute paths (e.g., `/Users/you/project/file.ts`)
- **Best for**: Working across multiple projects simultaneously
- **Use case**: When you need to reference code/context from multiple projects in the same conversation

### Auto-discover Mode (Project-specific)
- **Description**: OpenCodeAI runs in specific project directory
- **Discovery**: Automatically found by matching CWD between nvim and opencode process
- **Context**: Isolated context per project
- **File paths**: Relative to nvim's CWD
- **Best for**: Focused work on a single project with dedicated context
- **Use case**: When you want project-specific conversations that don't mix contexts

## Usage

### Launching OpenCodeAI

**In your tmux AI window:**

```bash
# Launch in global mode (multi-project)
opencode-global

# Launch in local mode (project-specific)
cd /path/to/your/project
opencode-local

# Check running instances
opencode-status
```

The `opencode-status` command shows:
- Process ID (PID)
- Port number
- Current working directory (CWD)

### Switching Modes in Nvim

| Keymap | Action | Description |
|--------|--------|-------------|
| `<leader>og` | Switch to Global mode | Connect to port 12345 (multi-project) |
| `<leader>ol` | Switch to Local mode | Auto-discover based on CWD |
| `<leader>om` | Show current mode | Display active mode and configuration |

**Existing OpenCode keymaps still work:**
- `<leader>ot` - Toggle OpenCode terminal
- `<leader>oa` - OpenCode Ask
- `<leader>o+` - Add to prompt
- `<leader>oe` - Explain code
- `<leader>on` - New session
- `<leader>os` - Select prompt
- `<S-C-u>` / `<S-C-d>` - Scroll messages

## Recommended Workflows

### Multi-project Workflow

**Scenario**: You're working on a microservice that depends on shared libraries, and you need context from both.

1. Launch global OpenCodeAI:
   ```bash
   # In tmux AI window
   opencode-global
   ```

2. Configure nvim for global mode:
   - Open nvim in any project directory
   - Press `<leader>og` to switch to global mode
   - Verify with `<leader>om`

3. Work freely:
   - Navigate between different project directories
   - OpenCodeAI maintains shared context
   - All projects connect to the same instance

### Single-project Workflow

**Scenario**: Deep dive into a specific project with isolated context.

1. Navigate to your project:
   ```bash
   cd ~/projects/my-awesome-app
   ```

2. Launch local OpenCodeAI:
   ```bash
   # In tmux AI window
   opencode-local
   ```

3. Configure nvim for auto-discover mode:
   - Open nvim in the **same directory** (important!)
   - Press `<leader>ol` to switch to auto-discover mode
   - Verify with `<leader>om`

4. Work within the project:
   - OpenCodeAI context stays focused on this project
   - Won't mix with other project contexts

## Troubleshooting

### "Couldn't find an opencode process running inside Neovim's CWD"

**Problem**: Nvim can't find the OpenCodeAI instance in auto-discover mode.

**Solutions**:
1. Ensure OpenCodeAI was launched in the same directory as nvim's CWD
2. Check nvim's CWD with `:pwd` and compare with `opencode-status`
3. Switch to global mode: `<leader>og`
4. Or relaunch OpenCodeAI in the correct directory

### Multiple OpenCodeAI instances running

**Check instances**:
```bash
opencode-status
```

**Kill specific instance**:
```bash
kill <PID>
```

**Kill all OpenCodeAI instances**:
```bash
pkill -f opencode
```

### Port 12345 already in use

If port 12345 is occupied, you can:

1. Use a different port by modifying `nick_opencode.lua`:
   ```lua
   port = vim.g.opencode_mode == 'global' and 54321 or nil,  -- Changed from 12345
   ```

2. Update shell function in `.zshrc`:
   ```bash
   opencode-global() {
     echo "Starting OpenCodeAI in GLOBAL mode on port 54321..."
     cd ~ && opencode --port 54321
   }
   ```

## Architecture Notes

### How Auto-discovery Works

The `opencode.nvim` plugin uses `lsof` to:
1. Find all running `opencode` processes
2. Determine each process's CWD
3. Match opencode's CWD with nvim's CWD
4. Prioritize processes that are descendants of the nvim process

### Mode Switching Behavior

When you switch modes in nvim:
- `vim.g.opencode_mode` is updated
- `vim.g.opencode_opts.port` is set accordingly
- The plugin will look for the appropriate server on the next request
- **Note**: Existing connections are not immediately changed; new requests use the new mode

### File Path Resolution

The configuration automatically handles file paths differently based on the mode:

**Global Mode**:
- Uses **absolute paths** (e.g., `/Users/mihai/project/src/file.ts`)
- This allows OpenCodeAI to find files regardless of its CWD
- Essential for multi-project workflows where OpenCodeAI's CWD differs from your project directories

**Auto-discover Mode**:
- Uses **relative paths** (e.g., `src/file.ts`)
- Paths are relative to nvim's CWD
- Works because OpenCodeAI's CWD matches nvim's CWD

This is implemented through custom `@buffer`, `@cursor`, and `@selection` context functions that check `vim.g.opencode_mode` and adjust path resolution accordingly.

## Tips

1. **Default to auto-discover**: The configuration defaults to auto-discover mode, which works well for most single-project workflows.

2. **Use global for cross-project tasks**: Switch to global mode when working on issues that span multiple repositories.

3. **Check mode frequently**: Use `<leader>om` if you're unsure which mode you're in.

4. **Shell aliases**: Add shortcuts to your workflow:
   ```bash
   alias oc-g='opencode-global'
   alias oc-l='opencode-local'
   alias oc-s='opencode-status'
   ```

5. **Tmux integration**: Consider binding keys in your `.tmux.conf` to quickly switch between your AI window and editor window.

## Related Files

- Nvim config: `~/.config/nvim/lua/plugins/nick_opencode.lua`
- Shell functions: `~/.zshrc`
- OpenCodeAI plugin: `~/.local/share/nvim/site/pack/core/opt/opencode.nvim/`

## See Also

- [opencode.nvim documentation](https://github.com/NickvanDyke/opencode.nvim)
- [OpenCodeAI CLI documentation](https://opencode.ai/docs/cli)
- Your tmux navigation guide: `TMUX_NVIM_NAVIGATION.md`
