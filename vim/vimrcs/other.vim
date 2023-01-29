" ----------------------------------- for vv -----------------------------------

if exists('g:vv')
  VVset fontfamily="HackNerdFontComplete-Regular"
endif

" --------------------------- for glacambre/firenvim ---------------------------

if exists('g:started_by_firenvim')
  nnoremap <silent> <C-e> :<C-u>call firenvim#hide_frame()<CR>
  set laststatus=0
  set wrap
  au BufEnter * if &lines < 20 | set lines=20 | endif
  au BufEnter github.com_*.txt set ft=markdown
  au BufEnter play.kotlinlang.org_*.c set ft=kotlin
  hi link CmpItemAbbrDefault Pmenu
  hi link CmpItemAbbr Pmenu
  hi link CmpItemMenu Pmenu
endif

" -------------------------------- for neovide ---------------------------------

if exists('g:neovide')
  set guifont=JetBrainsMono\ Nerd\ Font:h10
endif
