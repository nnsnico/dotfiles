local M = {}

function M.get_current_filename()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

---@param table table
function M.is_empty(table)
  return table == nil or #table == 0
end

---@param table table
---@param value any
---@return boolean
function M.contains(table, value)
  for _, v in ipairs(table) do
    if v == value then
      return true
    else
      return false
    end
  end
end

return M
