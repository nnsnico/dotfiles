local M = {}

local utils = require('heirline.utils')

---@param prefix string
---@param tbl { fg: string, bg: string }
---@return { fg: string, bg: string }
local function merge_theme(prefix, tbl)
  return {
    [prefix .. '_fg'] = tbl.fg,
    [prefix .. '_bg'] = tbl.bg,
  }
end

-------------------------------- general colors --------------------------------

---@class GeneralColor
---@field fg string
---@field black string
---@field red string
---@field red_light string
---@field green string
---@field green_light string
---@field orange string
---@field yellow string
---@field blue string
---@field sky_blue string
---@field cyan string
---@field gray string
---@field none string
local general = {
  fg          = vim.g.terminal_color_15,
  black       = vim.g.terminal_color_0,
  red         = vim.g.terminal_color_1,
  red_light   = utils.get_highlight('IncSearch').bg,
  green       = vim.g.terminal_color_2,
  green_light = utils.get_highlight('String').fg,
  orange      = utils.get_highlight('Debug').fg,
  yellow      = vim.g.terminal_color_3,
  blue        = vim.g.terminal_color_4,
  sky_blue    = vim.g.terminal_color_5,
  cyan        = vim.g.terminal_color_6,
  gray        = utils.get_highlight('SpecialComment').fg,
  none        = 'NONE',
}

------------------------------- component colors -------------------------------

local vimode = {
  fg          = general.black,
  bg          = 'NONE',
  normal      = general.blue,
  insert      = general.green,
  visual      = general.yellow,
  commandline = general.orange,
  select      = general.green_light,
  replace     = general.red_light,
  term        = general.red,
}

local diag_warn = {
  fg = general.black,
  bg = utils.get_highlight("DiagnosticWarn").fg,
}

local diag_err = {
  fg = general.black,
  bg = utils.get_highlight("DiagnosticError").fg,
}

local git = {
  del    = "#801D75",
  add    = "#9BD330",
  change = "#3555D4",
}

local skk = {
  fg = general.black,
  bg = general.gray,
}

local filetype = {
  fg = general.black,
  bg = general.sky_blue,
}

local file_flags = {
  changed = general.green,
  readonly = general.yellow,
}

local fileencode = {
  fg = general.black,
  bg = general.cyan,
}

local linestatus = {
  fg = general.black,
  bg = general.blue,
}

local filename = {
  fg = general.fg,
  bg = 'NONE',
  modifier = general.cyan,
}

local code_context = {
  fg = general.fg,
  bg = general.green_light,
  text = general.fg,
}

local winbar = {
  term = {
    fg = general.black,
    bg = general.red,
  },
  inactive = {
    fg = general.blue,
    bg = general.black,
    text = general.fg,
  },
  active = {
    fg = general.blue,
    bg = general.none,
    text = general.black,
  }
}

local tabline = {
  inactive = {
    fg = general.blue,
    bg = general.black,
  },
  active = {
    fg = general.black,
    bg = general.cyan,
  }
}

------------------------------- extended pallet --------------------------------

local my_theme = vim.tbl_extend('error',
  merge_theme('vimode', vimode),
  {
    vimode_normal      = vimode.normal,
    vimode_insert      = vimode.insert,
    vimode_visual      = vimode.visual,
    vimode_commandline = vimode.commandline,
    vimode_select      = vimode.select,
    vimode_replace     = vimode.replace,
    vimode_term        = vimode.term,
  },
  merge_theme('diag_warn', diag_warn),
  merge_theme('diag_err', diag_err),
  {
    git_del    = git.del,
    git_add    = git.add,
    git_change = git.change,
  },
  merge_theme('skk', skk),
  merge_theme('filetype', filetype),
  {
    file_flags_chaged = file_flags.changed,
    file_flags_readonly = file_flags.readonly,
  },
  merge_theme('fileencode', fileencode),
  merge_theme('linestatus', linestatus),
  merge_theme('filename', filename),
  {
    filename_modifer = filename.modifier
  },
  merge_theme('code_context', code_context),
  {
    code_context_text = code_context.text
  },
  merge_theme('winbar_inactive', winbar.inactive),
  {
    winbar_inactive_text = winbar.inactive.text
  },
  merge_theme('winbar_active', winbar.active),
  {
    winbar_active_text = winbar.active.text
  },
  merge_theme('winbar_term', winbar.term),
  merge_theme('tabline_inactive', tabline.inactive),
  merge_theme('tabline_active', tabline.active)
)

------------------------------ initialize colors -------------------------------

function M.init()
  require('heirline').load_colors(my_theme)

  vim.api.nvim_create_augroup('Heirline', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      utils.on_colorscheme(my_theme)
    end,
    group = 'Heirline'
  })
end

return M
