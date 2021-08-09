scriptencoding utf8
" Installation
" exec installer script(/install/vim_installer.sh)
"
" Optional
" Please install `nerd fonts` if you show mini icon in nerdtree
" https://github.com/ryanoasis/nerd-fonts

let s:vimrcs_dir = expand(expand('%:p:h') . '/vimrcs')

source expand(s:vimrcs_dir . /dein/installation.vim)
source expand(s:vimrcs_dir . /basic.vim)
source expand(s:vimrcs_dir . /visual.vim)
source expand(s:vimrcs_dir . /search.vim)
source expand(s:vimrcs_dir . /autocmd.vim)
source expand(s:vimrcs_dir . /other.vim)
source expand(s:vimrcs_dir . /functions/trimming_spaces.vim)
source expand(s:vimrcs_dir . /functions/converter.vim)
source expand(s:vimrcs_dir . /functions/auto_window_splitter.vim)
