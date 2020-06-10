" Split window to longer side(height or width)

if exists('g:auto_window_spliter')
    finish
endif
let g:auto_window_spliter = 1

function! s:auto_split_for_coc(cursor, name) abort
    if a:name == @%
        execute('edit ' . a:name)
    else
        let splitable = s:calc_splitable()
        execute(splitable . a:name)
    endif
    execute(a:cursor)
endfunction

function! s:auto_split_str(args) abort
    let cmd = [s:calc_splitable()]

    if !empty(a:args)
        echomsg join(a:args)
        call extend(cmd, a:args)
    endif

    return join(cmd)
endfunction

function! s:auto_split(...) abort
    let spliter = s:auto_split_str(a:000)
    execute(spliter)
endfunction

function! s:calc_splitable() abort
    " Getting actual visible window size is not supoprted
    let current_width_ratio = winwidth(0) / str2float(&columns)
    let current_height_ratio = winheight(0) / str2float(&lines)

    if (current_width_ratio > current_height_ratio)
        return "vsplit "
    else
        return "split "
    endif
endfunction

command! -nargs=* AutoSplit call s:auto_split(<f-args>)
command! AutoSplitStr call s:auto_split_str()
" For coc-nvim. try to put in coc-settings.json
" example: coc.preferences.jumpCommand: CocAutoSplit
command! -nargs=+ CocAutoSplit call s:auto_split_for_coc(<f-args>)

nnoremap <silent> <Leader>w :<C-u>call <SID>auto_split()<CR>

" vim: set ts=4 sw=4 sts=4 et :
