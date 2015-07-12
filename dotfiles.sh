#!/bin/bash

backup_dir="$HOME/git/dotfiles"
common_prefix="$backup_dir/common"
osx_prefix="$backup_dir/osx"
linux_prefix="$backup_dir/linux"
verbose=1

config_files=(
    .vimrc
    .tmux.conf
    .editorconfig
)

osx_config_files=(
    .zshrc
    .bashrc
    .sh_aliases
)

linux_config_files=(
    .zshrc
    .bashrc
    .sh_aliases
    .conkyrc
)

usage(){
    echo "./dotfiles.sh [option]"
    echo "    backup - backup the curent config"
    echo "    unpack - restore backed up config"
}

determine_platform() {
    if [[ $(uname) == 'Linux' ]]; then
        if (( verbose > 0 )); then
            echo "Running on linux"
        fi
        os_prefix=$linux_prefix
        os_config_files=(${linux_config_files[@]})
    elif [[ $(uname) == 'Darwin' ]]; then
        if (( verbose > 0 )); then
            echo "Running on osx"
        fi
        os_prefix=$osx_prefix
        os_config_files=(${osx_config_files[@]})
    else
        echo "Could not determine platform"
        exit
    fi
}

run_backup() {
    file_dir=$1; shift
    mkdir -p $file_dir

    for file in "$@"; do
        if [ ! -f "$HOME/$file" ]; then
            continue
        fi
        save_name=$(echo "$file" | sed -E 's/^\.(.*)/\1/')
        if (( verbose > 0 )); then
            echo "$HOME/$file -> $file_dir/$save_name"
        fi
        cp "$HOME/$file" "$file_dir/$save_name"
    done
}

run_unpack() {
    file_dir=$1; shift

    for file in "$@"; do
        save_name=$(echo "$file" | sed -E 's/^\.(.*)/\1/')
        if [ ! -f "$file_dir/$save_name" ]; then
            continue
        fi
        if (( verbose > 0 )); then
            echo "$file_dir/$save_name -> $HOME/$file"
        fi
        cp "$file_dir/$save_name" "$HOME/$file"
    done
}

if (( $# < 1 )); then
    usage
    exit
fi

case $1 in
    backup)
        determine_platform
        run_backup $common_prefix ${config_files[@]}
        run_backup $os_prefix ${os_config_files[@]}

        ;;
    unpack)
        determine_platform
        run_unpack $common_prefix ${config_files[@]}
        run_unpack $os_prefix ${os_config_files[@]}
        ;;
    *)
        usage
        exit
        ;;
esac
