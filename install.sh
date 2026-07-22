#!/usr/bin/env bash

set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_config() {
    name="$1"
    source="$DOTFILES_DIR/$name"
    target="$HOME/.config/$name"

    mkdir -p "$HOME/.config"

    if [ -L "$target" ]; then
        current="$(readlink "$target")"

        if [ "$current" = "$source" ]; then
            printf '%s already linked\n' "$name"
            return
        fi

        rm "$target"
    elif [ -e "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/$name"
        printf 'Backed up %s\n' "$target"
    fi

    ln -s "$source" "$target"
    printf 'Linked %s -> %s\n' "$target" "$source"
}

link_config nvim
link_config tmux

printf '\nDotfiles installed.\n'
