local M = {}

---Convert AZIK kanatable from Google IME to skkeleton
---
---@param kanatable_path string Full path of AZIK kanatable for Google IME
---@return table? kanatable AZIK kanatable for skkeleton
local convert = function(kanatable_path)
  if vim.fn.filereadable(kanatable_path) == 1 then
    local process = io.open(kanatable_path, 'r')
    if process then
      local tbl = {}
      for line in process:lines() do
        local kv = vim.split(line, '\t')
        tbl[kv[1]] = { kv[2], '' }
      end
      return tbl
    else
      return nil
    end
  else
    vim.print('File not exists')
    return nil
  end
end

---@param gi_table_path string Full path of AZIK kanatable for Google IME
M.register_azik_kanatable = function(gi_table_path)
  local converted_kanatable = convert(gi_table_path)
  if converted_kanatable ~= nil then
    vim.fn['skkeleton#register_kanatable']('azik', converted_kanatable, true)
  end
end

return M
