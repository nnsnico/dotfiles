local function auto_jump()
  local auto_window_splitter = require('functions.auto-window-splitter')

  local current_qf_item, close_fn = vim.fn.getloclist(0)[vim.fn.line('.')], 'lclose'
  if not current_qf_item then
    current_qf_item, close_fn = vim.fn.getqflist()[vim.fn.line('.')], 'cclose'
  end
  if not current_qf_item then
    vim.cmd('close')
    return
  end

  local current_bufnr = current_qf_item.bufnr

  local current_buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_bufnr), ':p')
  local current_buf_lnum = current_qf_item.lnum
  local current_buf_col  = current_qf_item.col

  vim.cmd(close_fn)

  auto_window_splitter.auto_jump(
    current_buf_name,
    current_buf_lnum,
    current_buf_col
  )
end

-- override `open` and `openc` command
vim.keymap.set('n', 'o', auto_jump, { buffer = true, silent = true })
vim.keymap.set('n', '<CR>', auto_jump, { buffer = true, silent = true })
