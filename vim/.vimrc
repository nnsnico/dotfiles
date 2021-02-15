scriptencoding utf8
" Installation
" exec installer script(/install/vim_installer.sh)
"
" Optional
" Please install `nerd fonts` if you show mini icon in nerdtree
" https://github.com/ryanoasis/nerd-fonts
"

exec 'source ' . expand('~/dotfiles/vim/vimrcs/dein/installation.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/basic.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/visual.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/search.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/autocmd.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/other.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/functions/trimming_spaces.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/functions/converter.vim')
exec 'source ' . expand('~/dotfiles/vim/vimrcs/functions/auto_window_splitter.vim')
