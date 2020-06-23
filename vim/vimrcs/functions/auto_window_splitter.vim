" Split window to longer side(height or width)

if exists('g:auto_window_splitter')
    finish
endif
let g:auto_window_splitter = 1

function! s:auto_split_for_coc(cursor, jumpfile) abort
    echomsg 'cursor: ' . a:cursor
    echomsg 'jumpfile: ' . a:jumpfile
    if expand(a:jumpfile) == @%
        execute('edit ' . a:jumpfile)
        execute(a:cursor)
    else
        let V = vital#vital#new()
        let Dict = V.import('Data.Dict')
        " make window buffer list other than current that
        " [[123, 'hoge'], [456, 'fuga']] -> { 123: 'hoge', 456: 'fuga' }
        let winlist =
            \ Dict.from_list(
            \     map(
            \         range(1, winnr('$')),
            \         { _, val ->
            \             [bufwinid(bufname(winbufnr(val))), bufname(winbufnr(val))]
            \         }
            \     )
            \ )
        let jumpablelist = filter(winlist, { _, val -> val == expand(a:jumpfile) && val != @% })

        if !empty(jumpablelist)
            for [id, wname] in items(jumpablelist)
                call win_gotoid(str2nr(id))
                execute(a:cursor)
                " exit block as soon as jumped to file
                return
            endfor
        else
            let splittable = s:calc_splittable()
            execute(splittable . a:jumpfile)
            execute(a:cursor)
        endif
    endif
endfunction

function! s:auto_split_str(args) abort
    let cmd = [s:calc_splittable()]

    if !empty(a:args)
        call extend(cmd, a:args)
    endif

    return join(cmd)
endfunction

function! s:auto_split(...) abort
    let splitter = s:auto_split_str(a:000)
    execute(splitter)
endfunction

function! s:calc_splittable() abort
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

nnoremap <silent> <Space>w :<C-u>call <SID>auto_split()<CR>

" vim: set ts=4 sw=4 sts=4 et :
