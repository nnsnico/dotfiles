local M = {}
local utils = require('luafunction.utils')
local auto_window_splitter = require('luafunction.auto-window-splitter')

---@param response table Location or Location[] or LocationLink[] (e.g, responsed value from "textDocument/definition")
---@return table quickfix quickfix list
function M.map_to_qflist_from_location(response)

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
    return vim.fn.map(
      response,
      function(_, v)
        return create_qfitem(v)
      end
    )
  else
    return {
      create_qfitem(response)
    }
  end
end

function M.handle_qflist(qflist)
  if #qflist == 1 then
    if qflist[1].filename == utils.get_current_filename() then
      auto_window_splitter.move_cursor(0, qflist[1].lnum, qflist[1].col)
    else
      local jumpable_windows = auto_window_splitter.get_jumpable_windows(qflist[1].filename)
      if not utils.is_empty(jumpable_windows) then
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
