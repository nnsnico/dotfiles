local M = {}

---@return string 'current file name'
function M.get_current_filename()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

---@param cmd string shell command
---@return string command result
function M.call_process(cmd)
  local result = ""
  local process = io.popen(cmd)
  if process then
    result = process:read('*a')
    process:close()
  end
  return result
end

return M
