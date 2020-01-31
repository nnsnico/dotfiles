" highlight comment
augroup mygroup
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd BufNewFile,BufRead *.conf set filetype=conf
  if has('nvim')
    function! OnUIEnter(event)
      let l:ui = nvim_get_chan_info(a:event.chan)
      if has_key(l:ui, 'client') && has_key(l:ui.client, 'name')
        if l:ui.client.name ==# 'Firenvim'
          set laststatus=0
          set guifont=HackNerdFontCompleteM-Regular:h9
        endif
      endif
    endfunction
  endif
  if has('nvim')
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
  endif
augroup end

