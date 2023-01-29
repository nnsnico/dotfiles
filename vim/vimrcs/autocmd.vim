augroup mygroup
  autocmd!
  " set filetype to conf
  autocmd BufNewFile,BufRead *.conf set filetype=conf
  " enable spell checker
  autocmd FileType markdown,txt setlocal spell | setlocal spelllang=en,cjk | xnoremap <buffer> <leader>g y:spellgood <C-r>=@<CR><CR>
augroup end
