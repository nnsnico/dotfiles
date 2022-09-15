local M = {}

function M.get_current_filename()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

  end
end

return M
