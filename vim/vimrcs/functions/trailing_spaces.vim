" simple trailing white spaces

if exists('g:loaded_trailing_spaces')
    finish
endif
let g:loaded_trailing_spaces = 1

function! s:trailing_spaces_one_line(...) abort
    if a:0 >= 1
        let pos = a:1
    else
        let pos = '.'
    endif
    let line = getline(pos)
    let trailed_line = substitute(line, '\s\+$', '', '')
    call setline(pos, trailed_line)
endfunction

function! s:trailing_spaces_all_line() abort
    let line_num = range(0, line('$'))
    for line in line_num
        call s:trailing_spaces_one_line(line)
    endfor
endfunction

command! -nargs=? TrailingSpaces call s:trailing_spaces_one_line(<f-args>)
command! TrailingSpacesAll call s:trailing_spaces_all_line()

nnoremap <silent> <space>t :<C-u>TrailingSpacesAll<CR>

" vim: set ts=4 sw=4 sts=4 et :
