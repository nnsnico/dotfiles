" simple trim white spaces

if exists('g:loaded_triming_spaces')
    finish
endif
let g:loaded_triming_spaces = 1

function! s:triming_spaces_one_line(trim_flag, ...) abort
    if a:trim_flag == 'start'
        let trim_regex = '\v(^(\s|　)+)'
    elseif a:trim_flag == 'end'
        let trim_regex = '\v(\s|　)+$'
    endif

    if a:0 >= 1
        let pos = a:1
    else
        let pos = '.'
    endif

    let line = getline(pos)
    let trimed_line = substitute(line, trim_regex, '', '')
    call setline(pos, trimed_line)
endfunction

function! s:trailing_spaces_all_line() abort
    let line_num = range(0, line('$'))
    for line in line_num
        call s:triming_spaces_one_line('end', line)
    endfor
endfunction

function! s:join_line_without_spaces() abort
    call s:triming_spaces_one_line('start', line('.') + 1)
    normal! gJ
endfunction

command! -nargs=+ TrimSpaces call s:triming_spaces_one_line(<f-args>)
command! TrailingSpacesAll call s:trailing_spaces_all_line()
command! JoinLineWithoutSpaces call s:join_line_without_spaces()

augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=HotPink ctermbg=205
    autocmd VimEnter,WinEnter * match TrailingSpaces /\v((\s|　)+$)|(　)/
augroup END

nnoremap <silent> gJ :<C-u>JoinLineWithoutSpaces<CR>
nnoremap <silent> <space>t :<C-u>TrailingSpacesAll<CR>

" vim: set ts=4 sw=4 sts=4 et :
