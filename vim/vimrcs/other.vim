" ----------------------------------- for vv -----------------------------------

if exists('g:vv')
  VVset fontfamily="HackNerdFontComplete-Regular"
endif

" --------------------------- for glacambre/firenvim ---------------------------

if exists('g:started_by_firenvim')
  nnoremap <silent> <C-e> :<C-u>call firenvim#hide_frame()<CR>
  set guifont=JetBrainsMono\ Nerd\ Font:h9
  set laststatus=0
  set wrap
  au BufEnter github.com_*.txt set ft=markdown
endif
