---@see vim/vimrcs/syntax/qf.vim

local M = {}
local const = require('constants')

M.config = function()
  -- Adapt fzf's delimiter in nvim-bqf
  require('bqf').setup({
    func_map = {
      open = '',
      openc = '',
    },
    filter = {
      fzf = {
        extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' }
      }
    }
  })
end

M.setup = function()
  local fn = vim.fn

  ---@param str string type of quickfix
  ---@return string 'diagnostic sign icon'
  local function diagnostic_type(str)
    if str == 'E' then
      return const.diagnostic_icons.error
    elseif str == 'W' then
      return const.diagnostic_icons.warn
    elseif str == 'I' then
      return const.diagnostic_icons.info
    elseif str == 'N' then
      return const.diagnostic_icons.hint
    else
      return ''
    end
  end

  function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
      items = fn.getqflist({ id = info.id, items = 0 }).items
    else
      items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
      local e = items[i]
      local fname = ''
      local str
      if e.valid == 1 then
        if e.bufnr > 0 then
          fname = fn.bufname(e.bufnr)
          if fname == '' then
            fname = '[No Name]'
          else
            fname = fname:gsub('^' .. vim.env.HOME, '~')
          end
          -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
          if #fname <= limit then
            fname = fnameFmt1:format(fname)
          else
            fname = fnameFmt2:format(fname:sub(1 - limit))
          end
        end
        local lnum = e.lnum > 99999 and -1 or e.lnum
        local col = e.col > 999 and -1 or e.col
        local qtype = e.type == '' and '' or ' ' .. diagnostic_type(e.type:sub(1, 1):upper())
        str = validFmt:format(fname, lnum, col, qtype, e.text)
      else
        str = e.text
      end
      table.insert(ret, str)
    end
    return ret
  end

  vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
end

return M
