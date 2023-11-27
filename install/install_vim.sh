#!/bin/bash -e
#
# Setup Vim configurations
#

# ------------------------------ Utility functions -----------------------------

output() {
	local message=$1
	printf '%b\n' "\e[1;34m${message}\e[0m"
}

success() {
	local message=$1
	printf '%b\n' "\e[32m${message}\e[0m"
}

error() {
	local message=$1
	printf '%b\n' "\e[31m${message}\e[0m" 1>&2
}

exec_step() {
	local message=$1
	shift
	local exec_cmds=("$@")
	local index=1

	output "$message"
	output "All Steps: ${#exec_cmds[@]}"
	for cmd in "${exec_cmds[@]}"; do
		if [ -n "$message" ] && [ -n "$cmd" ]; then
			echo "$index> $cmd"
			sleep 2
			bash -c "$cmd"
			success "Success!"
			echo
		else
			error "Can't execute command."
			exit 1
		fi
		((index++))
	done
}

cd "$(dirname "$0")" || exit 1

# ------------------------ Make symbolic link for vimrc ------------------------

exec_step "Add symbolic link of .vimrc..." "ln -s $HOME/dotfiles/vim/.vimrc $HOME/"

if [ ! -d "$HOME/.vim" ]; then
	exec_step \
		"Vim config directory is not found. Create dir automatically..." \
		"mkdir $HOME/.vim"
fi

# ------------------ Make symbolic link for Vim configurations -----------------

if [ ! -d "$HOME/.config/nvim" ]; then
	# create config directory
	exec_step \
		"nvim dir is not found. Create dir automatically..." \
		"mkdir -p $HOME/.config/nvim"
	# make symbolic link for nvim
	exec_step \
		"Add symbolic link of init.vim..." \
		"ln -s $HOME/dotfiles/vim/.vimrc $HOME/.config/nvim/init.vim"
fi

# make symbolic link for configurations
exec_step \
	"Add symbolic link of neovim configs..." \
	"ln -s $HOME/dotfiles/vim/vimrcs/after/ $HOME/.config/nvim/" \
	"ln -s $HOME/dotfiles/vim/vimrcs/syntax/ $HOME/.config/nvim/" \
	"ln -s $HOME/dotfiles/vim/vimrcs/lua/ $HOME/.config/nvim/"

# --------------------- Make symbolic link for GVim system ---------------------

exec_step \
	"Add symbolic link of .gvimrc..." \
	"ln -s $HOME/dotfiles/vim/.gvimrc $HOME/"

exec_step \
	"Add symbolic link of .ideavimrc..." \
	"ln -s $HOME/dotfiles/vim/.ideavimrc $HOME/"
