#!/usr/bin/env bash

nvim_dir="$HOME/.config/nvim"
tmux_dir="$HOME/.config/tmux"
lazygit_dir="$HOME/.config/lazygit"
scripts_dir="$HOME/.local/bin/scripts"
sessions_file="$HOME/.config/sessions.json"

if [ "$1" == "new" ]; then
    sudo apt install curl wget tmux jq fzf fd-find python3-pip python3-venv
    sudo apt-get install ninja-build gettext cmake build-essential
    ./installers/install_nvim.sh
    ./installers/install_lazygit.sh
    rm -rf "$nvim_dir" 2> /dev/null
    rm -rf "$tmux_dir" 2> /dev/null 
    rm -rf "$lazygit_dir" 2> /dev/null 
    rm -rf "$sessions_file" 2> /dev/null 
    cp -r "./nvim" "$nvim_dir"
    cp -r "./tmux" "$tmux_dir"
    cp -r "./lazygit" "$lazygit_dir"
    cp "./sessions.json" "$sessions_file"
    if [[ -z "$scripts_dir" ]]; then
        mkdir -p "$scripts_dir"
        cp -r "./scripts" "$scripts_dir"
    fi
fi

check_deps() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 is not installed"
        exit 1
    fi
}
