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
---@param win_buf_list AutoWinSplit.Windows
---@return AutoWinSplit.Windows[] windows Currently windows that able to be jump
local function get_jumpable_windows(target_bufname, win_buf_list)
  ---@type AutoWinSplit.Windows[]vim.
  local jumpable_files = vim.tbl_filter(
  ---@param v AutoWinSplit.Windows
    function(v) return v.bufname == target_bufname end,
    win_buf_list
  )

  return jumpable_files
end

---@param filename string file name in project path or full path
---@param windows AutoWinSplit.Windows[]
-- Automatically splits a wide window to open a file
local function auto_split(filename, windows)
  ---@type { winid: integer, bufname: string, area: integer }[]
  local window_size_list = vim.tbl_map(
  ---@param v AutoWinSplit.Windows
    function(v)
      return vim.tbl_extend('force', v, {
        area = vim.api.nvim_win_get_width(v.winid) * vim.api.nvim_win_get_height(v.winid)
      })
    end,
    windows
  )
  table.sort(
    window_size_list,
    function (a, b) return a.area > b.area end
  )
  vim.fn.win_gotoid(window_size_list[1].winid)

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
  ---@type AutoWinSplit.Windows[]
  local windows = vim.tbl_map(
  ---@param win integer
    function(win)
      return {
        winid = win,
        bufname = vim.fn.fnamemodify(vim.fn.bufname(vim.fn.winbufnr(win)), ':p'),
      }
    end,
    vim.api.nvim_list_wins()
  )
  local jumpable_windows = get_jumpable_windows(filename, windows)
  if not vim.tbl_isempty(jumpable_windows) then
    for _, v in pairs(jumpable_windows) do
      vim.fn.win_gotoid(v.winid)
      M.move_cursor(v.winid, lnum, col)
      return
    end
  else
    auto_split(filename, windows)
    M.move_cursor(0, lnum, col)
  end
end

return M
