" simple trim white spaces

if exists('g:loaded_trimming_spaces')
    finish
endif
let g:loaded_trimming_spaces = 1

function! s:trimming_spaces_one_line(trim_flag, ...) abort
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
        call s:trimming_spaces_one_line('end', line)
    endfor
endfunction

function! s:join_line_without_spaces() abort
    call s:trimming_spaces_one_line('start', line('.') + 1)
    normal! gJ
    silent! call repeat#set("\<Plug>JoinLineWithoutSpaces", v:count1)
endfunction

function! s:is_ignore_filetype() abort
    let ignore_list = ["mason", "fzf", "minimap", "TelescopePrompt", ""]
    if index(ignore_list, &filetype) >= 0
        return 1
    else
        return 0
    endif
endfunction

command! -nargs=+ TrimSpaces call s:trimming_spaces_one_line(<f-args>)
command! TrailingSpacesAll call s:trailing_spaces_all_line()

highlight TrailingSpaces term=underline guibg=HotPink ctermbg=205

augroup HighlightTrailingSpaces
    autocmd!
    autocmd ColorScheme             * highlight TrailingSpaces term=underline guibg=HotPink ctermbg=205
    autocmd BufRead,BufNew,FileType * if s:is_ignore_filetype() | match TrailingSpaces /^^/ | else | match TrailingSpaces /\v((\s|　)+$)|(　)/ | endif
    autocmd InsertLeave             * if !s:is_ignore_filetype() | match TrailingSpaces /\v((\s|　)+$)|(　)/ | endif
    autocmd InsertEnter             * if !s:is_ignore_filetype() | match TrailingSpaces /\v((\s|　)+$)|(　)/ | endif
augroup END

nnoremap <silent><Plug>JoinLineWithoutSpaces :<C-u>call <SID>join_line_without_spaces()<CR>
nmap     gJ                                  <Plug>JoinLineWithoutSpaces
nnoremap <silent><space>t                    :<C-u>TrailingSpacesAll<CR>

" vim: set ts=4 sw=4 sts=4 et :
