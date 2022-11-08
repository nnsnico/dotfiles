local M = {}

---Calculate to split in direction of a wide window.
---@return string execute_command command in string `vsplit ` or `split `
local function calc_split_direction()
  local current_width_ratio = vim.fn.winwidth(0) / vim.fn.str2float(vim.o.columns)
  local current_height_ratio = vim.fn.winheight(0) / vim.fn.str2float(vim.o.lines)

  if current_width_ratio > current_height_ratio then
    return "vsplit "
  else
    return "split "
  end
end

---@param bufname string
---@return string command string of actual command to be execute
local function auto_split_str(bufname)
  local cmd = calc_split_direction()
  return cmd .. bufname
end

---@param winid number window id. if 0, current window
---@param line number line number
---@param character number column number
function M.move_cursor(winid, line, character)
  vim.api.nvim_win_set_cursor(winid, { line, character - 1 })
end

---@param filename string file name in project path or full path
function M.auto_split(filename)
  local splitter = auto_split_str(filename)

  vim.fn.execute(splitter)
end

---@param target_bufname string
---@return { winid: number, bufname: string }[] windows Currently windows that able to be jump
function M.get_jumpable_windows(target_bufname)
  local win_list = vim.tbl_map(
    function(v)
      return {
        winid = vim.fn.bufwinid(vim.fn.bufname(vim.fn.winbufnr(v))),
        bufname = vim.fn.bufname(vim.fn.winbufnr(v)),
      }
    end,
    vim.fn.range(1, vim.fn.winnr('$'))
  )
  local jumpable_files = vim.tbl_filter(
    function(v) return v.bufname == target_bufname end,
    win_list
  )

  return jumpable_files
end

return M
