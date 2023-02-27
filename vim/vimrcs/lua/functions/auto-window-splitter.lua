local M = {}

---@class AutoWinSplit.Windows
---@field winid integer
---@field bufname string

---Calculate to split in direction of a wide window.
---@return string execute_command command in string `vsplit ` or `split `
local function calc_split_direction()
  local width_ratio = vim.fn.winwidth(0) * 0.549
  local height_ratio = vim.fn.winheight(0) * 1.125

  if width_ratio > height_ratio then
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
    function(a, b) return a.area > b.area end
  )
  vim.fn.win_gotoid(window_size_list[1].winid)

  local splitter = auto_split_str(filename)
  vim.cmd(splitter)
end

---@param winid number window id. if 0, current window
---@param row number line number
---@param col number column number
function M.move_cursor(winid, row, col)
  col = col <= 0 and 1 or col
  vim.api.nvim_win_set_cursor(winid, { row, col - 1 })
end

---@param filename string
---@param lnum integer
---@param col integer
function M.auto_jump(filename, lnum, col)
  ---@type AutoWinSplit.Windows[]
  local win_buf_list = vim.tbl_map(
  ---@param winid integer
    function(winid)
      return {
        winid = winid,
        bufname = vim.fn.fnamemodify(vim.fn.bufname(vim.fn.winbufnr(winid)), ':p'),
      }
    end,
    vim.api.nvim_list_wins()
  )
  local jumpable_windows = vim.tbl_filter(
    ---@param v AutoWinSplit.Windows
    function(v) return v.bufname == filename end,
    win_buf_list
  )

  if not vim.tbl_isempty(jumpable_windows) then
    -- only cursor moving
    for _, v in pairs(jumpable_windows) do
      vim.fn.win_gotoid(v.winid)
      M.move_cursor(v.winid, lnum, col)
      return
    end
  else
    -- split window and move cursor
    local current_tabpage_wins = vim.tbl_filter(
    ---@param win AutoWinSplit.Windows
      function(win)
        return vim.tbl_contains(vim.api.nvim_tabpage_list_wins(0), win.winid)
      end,
      win_buf_list
    )
    auto_split(filename, current_tabpage_wins)
    M.move_cursor(0, lnum, col)
  end
end

return M
