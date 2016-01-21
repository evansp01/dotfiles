# unpack defalt configurations
./dotfiles.sh unpack
# install oh my zsh and zsh
sudo apt-get install vim zsh python3-pip tmux vim-gnome
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ./extra/esp.zsh-theme ~/.oh-my-zsh/themes
# install vundle and vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# setup you complete me
sudo apt-get install build-essential cmake
sudo apt-get install python-dev
#cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
# install syntastic linters
sudo apt-get install npm
sudo pip3 install flake8
sudo npm install -g jshint
# install autojump
sudo apt-get install autojump
# install patched font for vim airline
wget https://github.com/abertsch/Menlo-for-Powerline/raw/master/Menlo%20for%20Powerline.ttf
mkdir -p ~/.fonts
mv "Menlo for Powerline.ttf" ~/.fonts
fc-cache -vf ~/.fonts
