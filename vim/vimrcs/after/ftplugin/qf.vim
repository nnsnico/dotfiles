function! s:auto_jump() abort
  let s:current_qf_item = getqflist()[line('.') - 1]
  let s:current_bufnr = s:current_qf_item.bufnr

  let g:current_buf_name = fnamemodify(bufname(s:current_bufnr), ':p')
  let g:current_buf_lnum = s:current_qf_item.lnum
  let g:current_buf_col = s:current_qf_item.col

  execute('cclose')

lua <<EOF
  local auto_window_splitter = require('functions.auto-window-splitter')

  auto_window_splitter.auto_jump(
    vim.g.current_buf_name,
    vim.g.current_buf_lnum,
    vim.g.current_buf_col
  )

  vim.api.nvim_del_var('current_buf_name')
  vim.api.nvim_del_var('current_buf_lnum')
  vim.api.nvim_del_var('current_buf_col')
EOF
endfunction

nnoremap <Plug>QfAutoJump :<C-u>call <SID>auto_jump()<CR>

map <buffer> o    <Plug>QfAutoJump
map <buffer> <CR> <Plug>QfAutoJump
