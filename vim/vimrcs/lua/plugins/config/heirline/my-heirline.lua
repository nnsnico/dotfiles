local heirline = {}

heirline.config = function()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')
  local components = require('plugins.config.heirline.components')

  -- init theme
  require('plugins.config.heirline.theme').init()

  ------------------------------------- ViMode -----------------------------------

  local ViMode = components.vimode
  ViMode = utils.insert(ViMode,
    {
      provider = '\u{E0B8} ',
      hl = function(self)
        return { fg = self.bg_color, bg = 'skk_bg' }
      end,
    }
  )

  ----------------------------------- SkkStatus ---------------------------------

  local SkkStatus = components.skk_status
  SkkStatus = utils.insert(SkkStatus,
    {
      provider = '\u{E0B8} ',
      hl = function()
        return { fg = 'skk_bg', bg = utils.get_highlight("StatusLine").bg }
      end,
    }
  )

  -------------------------------- Code Context --------------------------------

  local CodeContext = components.code_context('\u{E0BF} ')
  CodeContext = utils.insert(CodeContext,
    {
      provider = '\u{E0BF} ',
      hl = { fg = 'code_context_fg' }
    }
  )

  ---------------------------------- FileType ----------------------------------

  local FileType = components.filetype
  local FileTypePL = utils.insert(
    {
      provider = '\u{E0BE} ',
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
      provider = '\u{E0BE} ',
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
      provider = '\u{E0BE} ',
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
      provider = '\u{E0BE} ',
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
      provider = '\u{E0BE} ',
      hl = {
        fg = 'diag_err_bg',
        bg = 'diag_warn_bg',
      }
    },
    DiagnosticError
  }

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

  require('heirline').setup({
    statusline = Statuslines,
    winbar = WinBars
  })
end

return heirline
