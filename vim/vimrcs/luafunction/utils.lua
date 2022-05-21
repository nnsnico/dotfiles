local M = {}

M.get_current_filename = function()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

---@param table table
M.is_empty = function(table)
  return #table == 0
end

return M
