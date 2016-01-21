# unpack defalt configurations
./dotfiles unpack
# install oh my zsh and zsh
sudo apt-get install vim zsh python3-pip
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# install vundle and vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
# setup you complete me
sudo apt-get install build-essential cmake
sudo apt-get install python-dev
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
sudo apt-get install npm
sudo pip3 install flake8 
sudo npm install -g jshint
