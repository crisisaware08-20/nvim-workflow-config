#!/bin/bash

# Get the absolute path of the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR"

# Function to create a symbolic link and remove existing link if it exists
create_link() {
  local source_file="$1"
  local target_file="$2"

  # Check if a symbolic link already exists, and remove it if it does
  if [ -L "$target_file" ]; then
    echo "Removing existing symbolic link: $target_file"
    rm "$target_file"
  fi

  # Create a symbolic link
  ln -s "$source_file" "$target_file"
  echo "Symbolic link created successfully: $target_file"
}

# Create symbolic links
create_link "$CONFIG_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
create_link "$CONFIG_DIR/nvim/lua" "$HOME/.config/nvim/lua"
create_link "$CONFIG_DIR/vim/.vimrc" "$HOME/.vimrc"
