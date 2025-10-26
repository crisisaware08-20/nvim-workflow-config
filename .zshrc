eval "$(zoxide init zsh)"
eval "$(luarocks path --bin)"

# Zsh history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Append to history file instead of replacing
setopt SHARE_HISTORY           # Share history between sessions
setopt HIST_IGNORE_DUPS        # Don't save duplicate commands
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS       # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE       # Don't save commands starting with space
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt INC_APPEND_HISTORY      # Add commands immediately (not at shell exit)

# Set personal aliases
alias ,ez="nvim ~/.zshrc"
alias ,sz="source ~/.zshrc"
alias ,ev="nvim ~/.config/nvim/init.lua"

alias gb="git branch"
alias gc="git commit -m"
alias gch="git checkout"
alias gl="git log"
alias ga="git add"
alias gp="git pull"
alias gpu="git push"
alias gpu="git push --force"
alias gs="git status"


# Alacritty theme switcher
alatheme() {
    local theme_dir="$HOME/.config/alacritty/themes/alacritty-theme/themes"
    local theme=$(ls "$theme_dir" | sed 's/\.toml$//' | fzf --prompt="Alacritty Theme: " --height=40% --reverse)
    
    if [[ -n "$theme" ]]; then
        sed -i '' "s|\".*\.toml\"|\"~/.config/alacritty/themes/alacritty-theme/themes/$theme.toml\"|" "$HOME/.config/alacritty/alacritty.toml"
        echo "Switched to: $theme"
    fi
}

# opencode
#
export PATH=/Users/mihai.iurcomgmail.com/.opencode/bin:$PATH

# ═══════════════════════════════════════════════════════════
# OpenCodeAI Helper Functions - Dual-mode support
# ═══════════════════════════════════════════════════════════
# 
# Global mode: Single instance on port 12345, accessible from nvim anywhere
# Local mode: Project-specific instance, auto-discovered by CWD
#
# CLI Functions:
#   opencode-global          - Start global instance on port 12345
#   opencode-local           - Start local instance in current directory
#   opencode-status          - Show all running instances (marks global)
#   opencode-clean-sessions  - Remove all stored sessions
# ═══════════════════════════════════════════════════════════

# Launch OpenCodeAI in global mode (multi-project on port 12345)
opencode-global() {
  echo "Starting OpenCodeAI in GLOBAL mode on port 12345 from HOME directory..."
  cd ~ && opencode --port 12345
}

# Clean up old OpenCodeAI sessions
opencode-clean-sessions() {
  local session_dir="$HOME/.local/share/opencode/storage/session"
  if [ ! -d "$session_dir" ]; then
    echo "No session directory found"
    return 0
  fi
  
  local count=$(ls -1 "$session_dir" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -eq 0 ]; then
    echo "No sessions to clean"
    return 0
  fi
  
  echo "Found $count session(s). Delete all? [y/N]"
  read -r response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    rm -rf "$session_dir"/*
    echo "✅ All sessions deleted"
  else
    echo "Cancelled"
  fi
}

# Launch OpenCodeAI in local mode (project-specific, auto-discover)
opencode-local() {
  echo "Starting OpenCodeAI in LOCAL mode from current directory: $(pwd)"
  opencode
}

# Show which OpenCodeAI instances are running
opencode-status() {
  echo "Active OpenCodeAI instances:"
  echo "──────────────────────────────────────────────────────────"
  lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null | grep opencode | while read line; do
    local pid=$(echo "$line" | awk '{print $2}')
    local port=$(echo "$line" | awk '{print $9}' | cut -d: -f2)
    local cwd=$(lsof -a -p "$pid" -d cwd 2>/dev/null | tail -1 | awk '{print $NF}')
    
    # Mark global instance (port 12345)
    local marker=""
    if [ "$port" = "12345" ]; then
      marker=" 🌐 [GLOBAL]"
    fi
    
    echo "PID: $pid | Port: $port$marker | CWD: $cwd"
  done || echo "No OpenCodeAI instances found"
}

