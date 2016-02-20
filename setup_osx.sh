#!/usr/bin/env bash
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install useful brew pacakges for osx
brew install zsh python3 tmux vim cmake npm autojump wget
# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# copy my theme
cp ./extra/esp.zsh-theme ~/.oh-my-zsh/themes
# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# setup config files
./dotfiles.sh unpack
# setup vim
vim +PluginInstall +qall
# YouCompleteMe completion
~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
pip3 install flake8
pip3 install autopep8
npm install -g jshint
wget https://github.com/abertsch/Menlo-for-Powerline/raw/master/Menlo%20for%20Powerline.ttf
open "Menlo for Powerline.ttf"
rm "Menlo for Powerline.ttf"
