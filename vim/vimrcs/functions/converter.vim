" Convert various type from string

if exists('g:converter')
    finish
endif
let g:converter = 1

" ------------------------------- time converter -------------------------------

function! s:convert_unix_to_utc(...) abort
    let V = vital#vital#new()
    let DateTime = V.import('DateTime')
    let converted_date = DateTime.from_unix_time(a:1)
    let converted_str = converted_date.to_string()
    " copy to clipboard
    call setreg('*', converted_str, getregtype('*'))
    echo converted_str
endfunction

function! s:convert_to_unix_from_date(...) abort
    if len(a:000) == 6
        let V = vital#vital#new()
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

" ---------------------- converter for making identifier -----------------------

function! s:convert_to_md5_hash(...) abort
    let V = vital#vital#new()
    let Md5 = V.import('Hash.MD5')
    let converted_str = Md5.sum(a:1)
    " copy to clipboard
    call setreg('*', converted_str, getregtype('*'))
    echo converted_str
endfunction

function! s:convert_to_base64(...) abort
    let V = vital#vital#new()
    let Base64 = V.import('Data.Base64')
    let converted_str = Base64.encode(a:1)
    " copy to clipboard
    call setreg('*', converted_str, getregtype('*'))
    echo converted_str
endfunction

command! -nargs=1 ConvertUnixToUTC      call s:convert_unix_to_utc(<f-args>)
command! -nargs=* ConvertToUnixFromDate call s:convert_to_unix_from_date(<f-args>)
command! -nargs=1 ConvertMD5            call s:convert_to_md5_hash(<f-args>)

" vim: set ts=4 sw=4 sts=4 et :
