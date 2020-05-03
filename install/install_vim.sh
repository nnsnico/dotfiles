#!/bin/bash
# install vim

cur_path=$(pwd)/$(dirname $0)

# 1. add vim synbolic link
echo "Add symbolic link of .vimrc..."
ln -s ~/dotfiles/vim/.vimrc ~/

if [ ! -d "$HOME/.vim" ]; then
  echo "vim dir is not found. Create dir automatically..."
  mkdir $HOME/.vim

  echo "Add symbolic link of coc-settings.json in vim dir..."
  ln -s ~/dotfiles/vim/packageconfig/coc-settings.json ~/.vim/coc-settings.json
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  echo "nvim dir is not found. Create dir automatically..."
  mkdir $HOME/.config/nvim

  echo "Add symbolic link of init.vim..."
  ln -s ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim
  echo "Add symbolic link of coc-settings.json in nvim dir..."
  ln -s ~/dotfiles/vim/packageconfig/coc-settings.json ~/.config/nvim/coc-settings.json
fi

echo "Add symbolic link of .gvimrc..."
ln -s ~/dotfiles/vim/.gvimrc ~/

echo "Add symbolic link of .ideavimrc..."
ln -s ~/dotfiles/vim/.ideavimrc ~/

# 2. get 'dein.vim' installer, and install in '~/.vim/bundles'
echo "Installing dein.vim..."
curl -s https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_vim_installer.sh
sh ./dein_vim_installer.sh ~/.cache/dein
rm -f dein_vim_installer.sh

# 3. install vim plugins
vim +":call dein#install() | q"

# TODO: 4. install coc.nvim extensions
vim +":source $cur_path/install_coc_extensions.vim | q"
