augroup mygroup
  autocmd!
  " set filetype to conf
  autocmd BufNewFile,BufRead *.conf set filetype=conf
augroup end

" sort quickfix window in line number
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
