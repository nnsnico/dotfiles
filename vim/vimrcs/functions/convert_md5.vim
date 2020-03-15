" Convert md5 hash command

if exists('g:convert_md5')
    finish
endif
let g:convert_md5 = 1

function! s:convert_to_md5_hash(...) abort
    let V = vital#of('vital')
    let Md5 = V.import('Hash.MD5')
    let converted_str = Md5.sum(a:1)
    " copy to clipboard
    call setreg('*', converted_str, getregtype('*'))
    echo converted_str
endfunction

command! -nargs=1 ConvertMD5 call s:convert_to_md5_hash(<f-args>)

" vim: set ts=4 sw=4 sts=4 et :
