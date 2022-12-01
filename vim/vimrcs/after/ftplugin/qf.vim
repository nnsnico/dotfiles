function! s:auto_jump() abort
lua <<EOF
  local auto_window_splitter = require('functions.auto-window-splitter')

  local current_qf_item = vim.fn.getloclist(0)[vim.fn.line('.')]
  local current_bufnr = current_qf_item.bufnr

  local current_buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_bufnr), ':p')
  local current_buf_lnum = current_qf_item.lnum
  local current_buf_col  = current_qf_item.col

  vim.cmd('lclose')

  auto_window_splitter.auto_jump(
    current_buf_name,
    current_buf_lnum,
    current_buf_col
  )
EOF
endfunction

nnoremap <Plug>QfAutoJump :<C-u>call <SID>auto_jump()<CR>

map <buffer> o    <Plug>QfAutoJump
map <buffer> <CR> <Plug>QfAutoJump
