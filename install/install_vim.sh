#!/bin/bash
# install vim

# 1. link .vimrc
ln -s ~/dotfiles/.vimrc ~/

# 2. get 'dein.vim' installer, and install in '~/.vim/bundles'
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_vim_installer.sh
sh ./dein_vim_installer.sh ~/.vim/bundles
rm -f dein_vim_installer.sh

# 3. install vim plugins
vim +":call dein#install()" +:q

