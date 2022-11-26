local M = {}

---@class AutoWinSplit.Windows
---@field winid integer
---@field bufname string

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

---@param target_bufname string
---@return AutoWinSplit.Windows[] windows Currently windows that able to be jump
local function get_jumpable_windows(target_bufname)
  ---@type AutoWinSplit.Windows[]
  local win_list = vim.tbl_map(
  ---@param v integer
    function(v)
      return {
        winid = vim.fn.bufwinid(vim.fn.bufname(vim.fn.winbufnr(v))),
        bufname = vim.fn.fnamemodify(vim.fn.bufname(vim.fn.winbufnr(v)), ':p'),
      }
    end,
    vim.fn.range(1, vim.fn.winnr('$'))
  )
  local jumpable_files = vim.tbl_filter(
  ---@param v AutoWinSplit.Windows
    function(v) return v.bufname == target_bufname end,
    win_list
  )

  return jumpable_files
end

---@param filename string file name in project path or full path
local function auto_split(filename)
  local splitter = auto_split_str(filename)

  vim.fn.execute(splitter)
end

---@param winid number window id. if 0, current window
---@param line number line number
---@param character number column number
function M.move_cursor(winid, line, character)
  vim.api.nvim_win_set_cursor(winid, { line, character - 1 })
end

---@param filename string
---@param lnum integer
---@param col integer
function M.auto_jump(filename, lnum, col)
  local jumpable_windows = get_jumpable_windows(filename)
  if not vim.tbl_isempty(jumpable_windows) then
    for _, v in pairs(jumpable_windows) do
      vim.fn.win_gotoid(v.winid)
      M.move_cursor(v.winid, lnum, col)
      return
    end
  else
    auto_split(filename)
    M.move_cursor(0, lnum, col)
  end
end


return M
