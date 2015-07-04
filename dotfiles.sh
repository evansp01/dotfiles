#!/bin/bash

backup_dir="."

config_files=(
    .zshrc
    .zsh_aliases
    .vimrc
    .bashrc
    .bash_aliases
    .tmux.conf
    .editorconfig
)


run_backup() {

    mkdir -p $backup_dir

    for file in "${config_files[@]}"; do
        save_name=$(echo "$file" | sed -E 's/^\.(.*)/\1/')
        cp "$HOME/$file" "$backup_dir/$save_name"
    done

}

run_unpack() {

    for file in "${config_files[@]}"; do
        save_name=$(echo "$file" | sed -E 's/^\.(.*)/\1/')
        cp "$backup_dir/$save_name" "$HOME/$file"
    done

}

case $1 in

    backup)
        run_backup
        ;;
    unpack)
        run_unpack
        ;;
    *)
        echo "unknown option"
        exit
        ;;
esac
