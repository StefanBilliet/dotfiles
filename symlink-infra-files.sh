#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="/Users/stefanbilliet/Workspace/dotfiles"
BACKUP_SUFFIX=".backup.$(date +%Y%m%d-%H%M%S)"

echo "Linking dotfiles from $DOTFILES_DIR -> $HOME"

link_file() {
  local rel_path="$1"
  local source="$DOTFILES_DIR/$rel_path"
  local target="$HOME/$rel_path"

  if [ ! -e "$source" ]; then
    echo "Skipping $rel_path (not found in dotfiles repo)"
    return
  fi

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    local current_target
    current_target="$(readlink "$target")"

    if [ "$current_target" = "$source" ]; then
      echo "Already linked: $rel_path"
      return
    fi

    echo "Replacing existing symlink: $rel_path"
    rm "$target"
  elif [ -e "$target" ]; then
    echo "Backing up existing file: $target -> $target$BACKUP_SUFFIX"
    mv "$target" "$target$BACKUP_SUFFIX"
  fi

  echo "Linking $rel_path"
  ln -s "$source" "$target"
}

# Shell
link_file ".zshrc"
link_file ".zprofile"
link_file ".zshenv"

# Terminal
link_file ".wezterm.lua"

# Git
link_file ".gitconfig"

# Starship
link_file ".config/starship.toml"

echo "Done"