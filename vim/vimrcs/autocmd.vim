" highlight comment
augroup mygroup
  autocmd!
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

" sort by line number in quickfix window
augroup QuickfixSortStrategy
  autocmd!

  function! s:SortQuickfix() abort
    let sortedList = sort(getqflist(), 's:SortByLine')
    echom sortedList
    call setqflist(sortedList)
  endfunction

  function! s:SortByLine(e1, e2) abort
    let [t1, t2] = [a:e1.lnum, a:e2.lnum]
    return (t1 == t2 ? 0 : (t1 < t2 ? -1 : 1))
  endfunction

  autocmd QuickFixCmdPost * call s:SortQuickfix()
  autocmd FileType qf nnoremap <buffer>p <CR>zz<C-w>p
augroup end

augroup CocConfigGroup
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " set filetype `jsonc` in tsconfig.json only
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup end

