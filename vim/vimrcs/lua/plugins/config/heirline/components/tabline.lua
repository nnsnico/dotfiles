local FileIcon = require('plugins.config.heirline.components.file_icon')
local utils = require('heirline.utils')

local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ':t')
    return filename
  end,
  hl = function(self)
    return {
      bold = self.is_active or self.is_visible,
      italic = true
    }
  end,
}

local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, 'modified')
    end,
    provider = '[+]',
    hl = { fg = 'tabline_active_fg' },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, 'modifiable')
          or vim.api.nvim_buf_get_option(self.bufnr, 'readonly')
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, 'buftype') == 'terminal' then
        return ' \u{f489} '
      else
        return ' \u{f023} '
      end
    end,
    hl = { fg = 'tabline_active_fg' },
  },
}

local TablineCloseButton = {
  condition = function(self)
    return not vim.api.nvim_buf_get_option(self.bufnr, 'modified')
  end,
  {
    provider = ' \u{EA76} ',
    hl = { fg = 'tabline_active_fg' },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_buf_delete(minwid, { force = false })
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}

local TablineFileNameBlock = {
  init = function(self)
    local win = vim.api.nvim_tabpage_list_wins(self.tabpage)[1]
    self.bufnr = vim.api.nvim_win_get_buf(win)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return {
        fg = 'tabline_active_fg',
        bg = 'tabline_active_bg',
        force = true,
      }
    else
      return {
        fg = 'tabline_inactive_fg',
        bg = 'tabline_inactive_bg',
        force = true,
      }
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if (button == 'm') then
        vim.api.nvim_buf_delete(minwid, { force = false })
      else
        vim.api.nvim_set_current_tabpage(minwid)
      end
    end,
    minwid = function(self)
      return self.tabpage
    end,
    name = 'heirline_tabline_buffer_callback',
  },
  { provider = ' ' },
  FileIcon,
  TablineFileName,
  TablineFileFlags,
  TablineCloseButton,
}

---@param left_div string
---@param right_div string
---@return table component
local TablineBufferBlock = function(left_div, right_div)
  return utils.surround(
    { left_div, right_div },
    function(self)
      if self.is_active then
        return 'tabline_active_bg'
      else
        return 'tabline_inactive_bg'
      end
    end,
    { TablineFileNameBlock }
  )
end

---@param left_div string
---@param right_div string
---@return table component
return function(left_div, right_div)
  return {
    condition = function()
      return #vim.api.nvim_list_tabpages() >= 2
    end,
    utils.make_tablist(TablineBufferBlock(left_div, right_div))
  }
end
