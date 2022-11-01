#!/bin/bash
# install vim

cd "$(dirname "$0")" || exit 1

# 1. add vim synbolic link
echo "Add symbolic link of .vimrc..."
ln -s ~/dotfiles/vim/.vimrc ~/

if [ ! -d "$HOME/.vim" ]; then
  echo "vim dir is not found. Create dir automatically..."
  mkdir "$HOME"/.vim
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  echo "nvim dir is not found. Create dir automatically..."
  mkdir -p "$HOME"/.config/nvim

  echo "Add symbolic link of init.vim..."
  ln -s ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim
fi

echo "Add symbolic link of .gvimrc..."
ln -s ~/dotfiles/vim/.gvimrc ~/

echo "Add symbolic link of .ideavimrc..."
ln -s ~/dotfiles/vim/.ideavimrc ~/

# 2. get 'packer.nvim' installer, and install in '~/.local/share/nvim/site/pack/packer/start/packer.nvim'
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

ln -s ~/dotfiles/vim/vimrcs/lua/ ~/.config/nvim/

# 3. install vim plugins
nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
