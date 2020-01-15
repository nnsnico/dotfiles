#!/bin/bash
# install vim

# 1. add vim synbolic link
ln -s ~/dotfiles/vim/.vimrc ~/
ln -s ~/dotfiles/vim/coc-settings.json ~/.vim/coc-settings.json
ln -s ~/dotfiles/vim/.gvimrc ~/
ln -s ~/dotfiles/vim/.ideavimrc ~/

# (optional) add neovim synbolic link
ln -s ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

# 2. get 'dein.vim' installer, and install in '~/.vim/bundles'
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_vim_installer.sh
sh ./dein_vim_installer.sh ~/.cache/dein
rm -f dein_vim_installer.sh

# 3. install vim plugins
vim +":call dein#install()" +:q

