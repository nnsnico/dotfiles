if exists('g:vv')
  VVset fontfamily="HackNerdFontComplete-Regular"
endif

" for glacambre/firenvim
if exists('g:started_by_firenvim')
  set guifont=JetBrainsMono\ Nerd\ Font:h9
  set laststatus=0
  set wrap
  au BufEnter github.com_*.txt set ft=markdown
endif
