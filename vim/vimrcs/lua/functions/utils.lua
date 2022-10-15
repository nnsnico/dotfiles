local M = {}

---@return string 'current file name'
function M.get_current_filename()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

---@param method function
function M.call_safe(method)
  local ok, err = pcall(method)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

return M
