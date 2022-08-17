local M = {}

function M.get_current_filename()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

---@param table table
function M.is_empty(table)
  return table == nil or #table == 0
end

return M
