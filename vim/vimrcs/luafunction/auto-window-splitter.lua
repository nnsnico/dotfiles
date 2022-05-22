local M = {}
local utils = require('luafunction.utils')

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
local function move_cursor(winid, line, character)
  vim.api.nvim_win_set_cursor(winid, { line, character - 1 })
end

---@param filename string file name in project path or full path
local function auto_split(filename)
  local splitter = auto_split_str(filename)

  vim.fn.execute(splitter)
end

---@param response table responsed value from "textDocument/definition"
---@return table Quickfix list format
local function map_to_qflist(response)

  local function create_qfitem(value)

    ---@return string file name in project path
    local function decode_filename(resp)
      local fname = resp.uri ~= nil and
          vim.uri_to_fname(resp.uri) or
          vim.uri_to_fname(resp.targetUri)
      return vim.fn.fnamemodify(fname, ':.')
    end

    ---@return number, number (line, character)
    local function decode_range(resp)
      local range = resp.range ~= nil and
          resp.range['start'] or
          resp.targetRange['start']
      return range.line + 1, range.character + 1
    end

    ---@return number bufnr buffer number
    local function create_buffer(filepath)
      local bufnr = vim.fn.bufexists(vim.fn.bufnr(filepath)) > 0 and
          vim.fn.bufnr(filepath) or
          vim.fn.bufadd(filepath)
      vim.fn.bufload(bufnr)
      return bufnr
    end

    local project_filepath = decode_filename(value)
    local bufnr = create_buffer(project_filepath)
    local lnum, col = decode_range(value)
    return {
      bufnr = bufnr,
      filename = project_filepath,
      module = '',
      lnum = lnum,
      end_lnum = 0,
      pattern = '',
      col = col,
      vcol = 0,
      end_col = 0,
      nr = 0,
      text = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, true)[1],
      type = '',
      valid = 1,
    }
  end

  -- check type `Location` or `Location[]`
  if (type(response[1]) == "table") then
    print('create from Location[] or LocationLink[]')
    return vim.fn.map(
      response,
      function(_, v)
        return create_qfitem(v)
      end
    )
  else
    print('create from Location')
    return {
      create_qfitem(response)
    }
  end
end

---@param target_bufname string
---@return {{winid: number, bufname: string}, ...} windows Currently windows that able to be jump
local function get_jumpable_windows(target_bufname)
  local win_list = vim.fn.map(
    vim.fn.range(1, vim.fn.winnr('$')),
    function(_, v)
      return {
        winid = vim.fn.bufwinid(vim.fn.bufname(vim.fn.winbufnr(v))),
        bufname = vim.fn.bufname(vim.fn.winbufnr(v)),
      }
    end
  )
  local jumpable_files = vim.fn.filter(
    win_list,
    function(_, v) return v.bufname == target_bufname end
  )

  return jumpable_files
end

function M.auto_split_for_builtinlsp(response)
  if response == nil or utils.is_empty(response) then
    vim.notify('No definition', 'info')
    return
  end
  local qflist = map_to_qflist(response)

  if #qflist == 1 then
    if qflist[1].filename == utils.get_current_filename() then
      move_cursor(0, qflist[1].lnum, qflist[1].col)
    else
      local jumpable_windows = get_jumpable_windows(qflist[1].filename)
      if not utils.is_empty(jumpable_windows) then
        for _, v in pairs(jumpable_windows) do
          vim.fn.win_gotoid(v.winid)
          move_cursor(v.winid, qflist[1].lnum, qflist[1].col)
          return
        end
      else
        auto_split(qflist[1].filename)
        move_cursor(0, qflist[1].lnum, qflist[1].col)
      end
    end
  else
    vim.fn.setqflist(qflist)
    vim.cmd('copen')
  end
end

return M
