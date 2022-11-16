local M = {}
local utils = require('functions.utils')
local auto_window_splitter = require('functions.auto-window-splitter')

---@class lsp.Location
---@field uri string
---@field range lsp.Range

---@class lsp.LocationLink
---@field originSelectionRange? lsp.Range
---@field targetUri string
---@field targetRange lsp.Range
---@field targetSelectionRange lsp.Range

---@class QfItem
---@field bufnr number
---@field filename string?
---@field module string
---@field lnum number
---@field end_lnum number
---@field col number
---@field end_col number
---@field vcol number
---@field nr number
---@field pattern string
---@field text string
---@field type string
---@field valid number

---@alias Response (lsp.Location | lsp.Location[] | lsp.LocationLink)?

---@param value Response
---@return QfItem quickfix_item quickfix item
local function create_qfitem(value)
  ---@param resp Response
  ---@return string file name in project path
  local function decode_filename(resp)
    if resp then
      local fname = resp.uri ~= nil and vim.uri_to_fname(resp.uri) or vim.uri_to_fname(resp.targetUri)
      return vim.fn.fnamemodify(fname, ':.')
    end
    return ''
  end

  ---@param resp Response
  ---@return number, number (line, character)
  local function decode_range(resp)
    ---@type lsp.Position
    local position = { line = 0, character = 0 }
    if resp then
      if resp.range ~= nil then -- if type is lsp.Location
        position = resp.range['start']
      elseif resp.targetRange ~= nil then -- if type is lsp.LocationLink
        position = resp.targetRange['start']
      end
    end
    return position.line + 1, position.character + 1
  end

  ---@param filepath string
  ---@return number bufnr: buffer number
  local function create_buffer(filepath)
    local bufnr = vim.fn.bufexists(vim.fn.bufnr(filepath)) > 0 and vim.fn.bufnr(filepath) or vim.fn.bufadd(filepath)
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

---@param response Response: Location or Location[] or LocationLink[] (e.g, responsed value from "textDocument/definition")
---@return QfItem[] quickfix_list: Quickfix list
function M.map_to_qflist_from_location(response)
  -- check type `Location` or `Location[]`
  if response and type(response[1]) == 'table' then
    return vim.tbl_map(
      ---@param v Response
      function(v)
        return create_qfitem(v)
      end,
      response
    )
  else
    return {
      create_qfitem(response),
    }
  end
end

---@param qflist QfItem[]
function M.handle_qflist(qflist)
  if #qflist == 1 then
    if qflist[1].filename == utils.get_current_filename() then
      auto_window_splitter.move_cursor(0, qflist[1].lnum, qflist[1].col)
    else
      local full_path = vim.fn.fnamemodify(qflist[1].filename, ':p')
      local jumpable_windows = auto_window_splitter.get_jumpable_windows(full_path)
      if not vim.tbl_isempty(jumpable_windows) then
        for _, v in pairs(jumpable_windows) do
          vim.fn.win_gotoid(v.winid)
          auto_window_splitter.move_cursor(v.winid, qflist[1].lnum, qflist[1].col)
          return
        end
      else
        auto_window_splitter.auto_split(qflist[1].filename)
        auto_window_splitter.move_cursor(0, qflist[1].lnum, qflist[1].col)
      end
    end
  else
    vim.fn.setqflist(qflist)
    vim.cmd('copen')
  end
end

return M
