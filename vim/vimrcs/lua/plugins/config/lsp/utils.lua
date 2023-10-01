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

---@alias Response (lsp.Location | lsp.Location[] | lsp.LocationLink[])?

---@param location lsp.Location
---@return QfItem quickfix_item quickfix item
local function qfitem_from_location(location)
  ---@param uri string
  ---@return string file name in project path
  local function decode_filename(uri)
    local fname = vim.uri_to_fname(uri)
    return vim.fn.fnamemodify(fname, ':.')
  end

  ---@param range lsp.Range
  ---@return number, number (line, character)
  local function decode_range(range)
    ---@type lsp.Position
    local position = range.start
    return position.line + 1, position.character + 1
  end

  ---@param filepath string
  ---@return number bufnr: buffer number
  local function create_buffer(filepath)
    local bufnr = vim.fn.bufexists(vim.fn.bufnr(filepath)) > 0 and vim.fn.bufnr(filepath) or vim.fn.bufadd(filepath)
    vim.fn.bufload(bufnr)
    return bufnr
  end

  local project_filepath = decode_filename(location.uri)
  local bufnr = create_buffer(project_filepath)
  local lnum, col = decode_range(location.range)
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
  if response and vim.tbl_islist(response) then -- is `Location[] | LocationLink[]`
    return vim.lsp.util.locations_to_items(response, 'utf-8')
  else -- is `Location`
    return {
      ---@cast response lsp.Location
      qfitem_from_location(response),
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
      auto_window_splitter.auto_jump(full_path, qflist[1].lnum, qflist[1].col)
    end
  else
    vim.fn.setloclist(0, qflist)
    vim.cmd('lopen')
  end
end

return M
