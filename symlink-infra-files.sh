#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX=".backup.$(date +%Y%m%d-%H%M%S)"

echo "Linking dotfiles from $DOTFILES_DIR -> $HOME"

link_path() {
  local source_rel="$1"
  local target_rel="$2"
  local source="$DOTFILES_DIR/$source_rel"
  local target="$HOME/$target_rel"

  if [ ! -e "$source" ]; then
    echo "Skipping $target_rel (not found in dotfiles repo)"
    return
  fi

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    local current_target
    current_target="$(readlink "$target")"

    if [ "$current_target" = "$source" ]; then
      echo "Already linked: $target_rel"
      return
    fi

    echo "Replacing existing symlink: $target_rel"
    rm "$target"
  elif [ -e "$target" ]; then
    echo "Backing up existing file: $target -> $target$BACKUP_SUFFIX"
    mv "$target" "$target$BACKUP_SUFFIX"
  fi

  echo "Linking $target_rel"
  ln -s "$source" "$target"
}

# Shell
link_path ".zshrc" ".zshrc"
link_path ".zprofile" ".zprofile"
link_path ".zshenv" ".zshenv"

# Terminal
link_path ".wezterm.lua" ".wezterm.lua"

# Git
link_path ".gitconfig" ".gitconfig"

# Starship
link_path ".config/starship.toml" ".config/starship.toml"

# OpenCode
link_path "opencode/opencode.json" ".config/opencode/opencode.json"
link_path "opencode/opencode-mem.jsonc" ".config/opencode/opencode-mem.jsonc"
link_path "opencode/commands" ".config/opencode/commands"
link_path "opencode/agent" ".config/opencode/agent"
link_path "opencode/skills" ".config/opencode/skills"
link_path "opencode/bin" ".config/opencode/bin"

echo "Done"
