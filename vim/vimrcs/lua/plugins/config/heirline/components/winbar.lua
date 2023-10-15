local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
local filetype = require('plugins.config.heirline.components.filetype')
local filename = require('plugins.config.heirline.components.file_name')

local terminal = {
  -- we could add a condition to check that buftype == 'terminal'
  -- or we could do that later (see #conditional-statuslines below)
  provider = function()
    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
    return " " .. "\u{f489} " .. tname .. " "
  end,
  hl = { fg = 'winbar_term_fg', bold = true },
}

return {
  fallthrough = false,
  { -- A special winbar for terminals
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    utils.surround(
      { "", "\u{E0BC} " },
      'winbar_term_bg',
      {
        filetype,
        terminal,
        { provider = "%=" },
      }
    ),
  },
  { -- An inactive winbar for regular files
    condition = function()
      return not conditions.is_active()
    end,
    utils.surround(
      { "", "\u{E0BD}" },
      'winbar_inactive_fg',
      {
        hl = {
          fg = 'winbar_inactive_text',
          bg = 'winbar_inactive_bg',
          force = true,
        },
        filename
      }
    ),
  },
  -- A winbar for regular files
  utils.surround(
    { "", "\u{e0bc}" },
    'winbar_active_fg',
    {
      hl = {
        fg = 'winbar_active_text',
        force = true,
      },
      filename
    }
  ),
}
