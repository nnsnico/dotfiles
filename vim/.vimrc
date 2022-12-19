scriptencoding utf8

" Installation
" exec installer script(/install/vim_installer.sh)
"
" Optional
" Please install `nerd fonts` if you show mini icon in nerdtree
" https://github.com/ryanoasis/nerd-fonts

" TODO: put dotfiles dir (absolute path)
let s:dotfiles_dir = '~/dotfiles'
  " \ 'dein/installation.vim',
let s:vim_files = [
  \ 'visual.vim',
  \ 'search.vim',
  \ 'autocmd.vim',
  \ 'other.vim',
  \ 'functions/trimming_spaces.vim',
  \ 'functions/converter.vim',
  \ ]

for files in s:vim_files
  let fullpath = expand(s:dotfiles_dir . '/vim/vimrcs/' . files)
  exec 'source ' . fullpath
endfor

let s:basic = expand('~/dotfiles/vim/vimrcs/basic.lua')
exec 'luafile ' .. s:basic

" If you use Vim, comment out it (this not work)
if has('nvim')
lua <<EOF
  require('packer.plugins').startup()
EOF
endif
