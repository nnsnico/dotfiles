scriptencoding utf8
" Installation
" exec installer script(/install/vim_installer.sh)
"
" Optional
" Please install `nerd fonts` if you show mini icon in nerdtree
" https://github.com/ryanoasis/nerd-fonts

" TODO: put dotfiles dir (absolute path)
let s:dotfiles_dir = '~/dotfiles'
let s:vim_files = [
  \ 'dein/installation.vim',
  \ 'basic.vim',
  \ 'visual.vim',
  \ 'search.vim',
  \ 'autocmd.vim',
  \ 'other.vim',
  \ 'functions/trimming_spaces.vim',
  \ 'functions/converter.vim',
  \ 'functions/auto_window_splitter.vim',
  \ ]

for files in s:vim_files
  let fullpath = expand(s:dotfiles_dir . '/vim/vimrcs/' . files)
  exec 'source ' . fullpath
endfor
