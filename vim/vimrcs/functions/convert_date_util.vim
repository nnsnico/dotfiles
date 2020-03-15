" Convert unix time to utc

if exists('g:convert_date_util')
    finish
endif
let g:convert_date_util = 1

function! s:convert_unix_to_utc(...) abort
    let V = vital#of('vital')
    let DateTime = V.import('DateTime')
    let converted_date = DateTime.from_unix_time(a:1)
    let converted_str = converted_date.to_string()
    " copy to clipboard
    call setreg('*', converted_str, getregtype('*'))
    echo converted_str
endfunction

function! s:convert_to_unix_from_date(...) abort
    if len(a:000) == 6
        let V = vital#of('vital')
        let DateTime = V.import('DateTime')
        let converted_date = DateTime.from_date(a:1, a:2, a:3, a:4, a:5, a:6, '+09:00')
        let converted_unix_time = converted_date.unix_time()
        " copy to clipboard
        call setreg('*', converted_unix_time, getregtype('*'))
        echo converted_unix_time
    else
        echo 'arguments not equals 6'
    endif
endfunction

command! -nargs=1 ConvertUnixToUTC call s:convert_unix_to_utc(<f-args>)
command! -nargs=* ConvertToUnixFromDate call s:convert_to_unix_from_date(<f-args>)

" vim: set ts=4 sw=4 sts=4 et :
