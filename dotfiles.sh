#!/bin/bash

backup_dir="$HOME/git/dotfiles"
common_prefix="$backup_dir/common"
osx_prefix="$backup_dir/osx"
linux_prefix="$backup_dir/linux"
md5=""
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
        md5="md5sum"
    elif [[ $(uname) == 'Darwin' ]]; then
        if (( verbose > 0 )); then
            echo "Running on osx"
        fi
        os_prefix=$osx_prefix
        os_config_files=(${osx_config_files[@]})
        md5="md5 -r"
    else
        echo "Could not determine platform"
        exit
    fi
}

confirm_move_file() {
    from=$1; shift
    to=$1; shift
    from_hash=$($md5 $from | cut -d' ' -f 1)
    to_hash=$($md5 $to | cut -d' ' -f 1)
    if [ "$from_hash" = "$to_hash" ]; then
        if (( verbose > 0 )); then
            echo "No updates to $to (md5 same)"
        fi
        return
    fi
    git diff $to $from
    read -r -p "Do you want to update $to to $from? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            if (( verbose > 0 )); then
                echo "$from -> $to"
            fi
            cp $from $to
            ;;
        *)
            if (( verbose > 0 )); then
                echo "Skipping $from"
            fi
            ;;
    esac
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
        confirm_move_file "$file_dir/$save_name" "$HOME/$file" $verbose
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
