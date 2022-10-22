local heirline = {}

heirline.config = function()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')
  local components = require('packer.config.heirline.components')

  -- init theme
  require('packer.config.heirline.theme').init()

  ------------------------------------- ViMode -----------------------------------

  local ViMode = components.vimode
  ViMode = utils.insert(ViMode,
    {
      provider = ' ',
      hl = function(self)
        return { fg = self.bg_color, bg = 'skk_bg' }
      end,
    }
  )

  ----------------------------------- SkkStatus ---------------------------------

  local SkkStatus = components.skk_status
  SkkStatus = utils.insert(SkkStatus,
    {
      provider = ' ',
      hl = function()
        return { fg = 'skk_bg', bg = utils.get_highlight("StatusLine").bg }
      end,
    }
  )

  ---------------------------------- FileType ----------------------------------

  local FileType = components.filetype
  local FileTypePL = utils.insert(
    {
      provider = ' ',
      hl = {
        fg = 'filetype_bg',
        bg = 'diag_err_bg',
      },
    },
    FileType
  )

  local FileEncodeType = components.file_encode_type
  FileEncodeType = utils.insert(
    {
      provider = ' ',
      hl = {
        fg = 'fileencode_bg',
        bg = 'filetype_bg',
      },
    },
    FileEncodeType
  )

  ---------------------------------- Line status --------------------------------

  local LineStatus = components.line_status
  LineStatus = {
    {
      provider = ' ',
      hl = {
        fg = 'linestatus_bg',
        bg = 'fileencode_bg',
      }
    },
    LineStatus
  }

  ----------------------------------- Diagnostic ---------------------------------

  local diagnostic = components.diagnostics

  -- Warn
  local DiagnosticWarn = diagnostic.warn
  DiagnosticWarn = utils.insert(
    {
      provider = ' ',
      hl = {
        fg = 'diag_warn_bg',
        bg = utils.get_highlight("StatusLine").bg,
      }
    },
    DiagnosticWarn
  )

  -- Error status
  local DiagnosticError = diagnostic.error
  DiagnosticError = {
    {
      provider = ' ',
      hl = {
        fg = 'diag_err_bg',
        bg = 'diag_warn_bg',
      }
    },
    DiagnosticError
  }

  -------------------------------- Code Context --------------------------------

  local CodeContext = components.code_context('\u{E0BF} ')
  CodeContext = utils.surround(
    { "", "\u{E0B9} " },
    ---@diagnostic disable-next-line: param-type-mismatch
    nil,
    {
      CodeContext
    }
  )

  ----------------------------------- Winbar -----------------------------------

  local WinBars = components.winbars

  local DefaultStatusline = {
    ViMode,
    SkkStatus,
    CodeContext,
    { provider = "%=" },
    DiagnosticWarn,
    DiagnosticError,
    FileTypePL,
    FileEncodeType,
    LineStatus,
  }

  local Statuslines = {
    hl = function()
      if conditions.is_active() then
        return {
          fg = utils.get_highlight("StatusLine").fg,
          bg = utils.get_highlight("StatusLine").bg,
        }
      else
        return {
          fg = utils.get_highlight("StatusLineNC").fg,
          bg = utils.get_highlight("StatusLineNC").bg,
        }
      end
    end,
    fallthrough = false,
    DefaultStatusline
  }

  require('heirline').setup(Statuslines, WinBars)
end

return heirline
