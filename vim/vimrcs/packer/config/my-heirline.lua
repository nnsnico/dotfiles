local heirline = {}

heirline.config = function()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')
    local luafunctions = require('luafunction.utils')

    -- import to dart theme of fancomi.vim
    local general_colors = {
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

    local colors = {
      diag_warn = {
        fg = general_colors.black,
        bg = utils.get_highlight("DiagnosticWarn").fg,
      },

      diag_err = {
        fg = general_colors.black,
        bg = utils.get_highlight("DiagnosticError").fg,
      },

      git = {
        del    = "#801D75",
        add    = "#9BD330",
        change = "#3555D4",
      },

      skk = {
        fg = general_colors.black,
        bg = general_colors.gray,
      },

      filetype = {
        fg = general_colors.black,
        bg = general_colors.sky_blue,
      },

      fileencode = {
        fg = general_colors.black,
        bg = general_colors.cyan,
      },

      linestatus = {
        fg = general_colors.black,
        bg = general_colors.blue,
      },
    }

------------------------------------- ViMode -----------------------------------

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,
      static = {
        mode_names = {
          n         = "NORMAL",
          no        = "NORMAL",
          nov       = "NORMAL",
          noV       = "NORMAL",
          ["no\22"] = "NORMAL",
          niI       = "NORMAL",
          niR       = "NORMAL",
          niV       = "NORMAL",
          nt        = "TERMINAL",
          v         = "VISUAL",
          vs        = "VISUAL",
          V         = "V-LINE",
          Vs        = "V-LINE",
          ["\22"]   = "V-BLOCK",
          ["\22s"]  = "V-BLOCK",
          s         = "SELECT",
          S         = "SELECT",
          ["\19"]   = "SELECT",
          i         = "INSERT",
          ic        = "INSERT",
          ix        = "INSERT",
          R         = "REPLACE",
          Rc        = "REPLACE",
          Rx        = "REPLACE",
          Rv        = "V-REPLACE",
          Rvc       = "V-REPLACE",
          Rvx       = "V-REPLACE",
          c         = "COMMAND",
          cv        = "EX",
          r         = "...",
          rm        = "MORE",
          ["r?"]    = "?",
          ["!"]     = "!",
          t         = "TERMINAL ACTIVE",
        },
        mode_colors = {
          n       = general_colors.blue ,
          i       = general_colors.green,
          v       = general_colors.yellow,
          V       = general_colors.yellow,
          ["\22"] = general_colors.yellow,
          c       = general_colors.orange,
          s       = general_colors.green_light,
          S       = general_colors.green_light,
          ["\19"] = general_colors.green_light,
          R       = general_colors.red_light,
          r       = general_colors.red_light,
          ["!"]   = general_colors.red,
          t       = general_colors.red,
        }
      },
      provider = function(self)
        return "  %2("..self.mode_names[self.mode].."%) "
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        self.bg_color = self.mode_colors[mode]
        return {
          fg = general_colors.black,
          bg = self.mode_colors[mode],
          bold = true,
        }
      end,
    }

    ViMode = utils.insert(ViMode,
      {
        provider = ' ',
        hl = function(self)
          return { fg = self.bg_color, bg = colors.skk.bg }
        end,
      }
    )

----------------------------------- SkkStatus ---------------------------------

    SkkStatus = {
      init = function(self)
        local mode = vim.fn['skkeleton#mode']()
        if mode == '' then
          self.mode = 'A'
        elseif mode == 'kata' then
          self.mode = 'ア'
        elseif mode == 'hira' then
          self.mode = 'あ'
        else
          self.mode = ''
        end
      end,
      provider = function(self)
        return " "..self.mode.." "
      end,
      hl = function()
        return {
          fg = colors.skk.fg,
          bg = colors.skk.bg,
        }
      end,
    }

    SkkStatus = utils.insert(SkkStatus,
      {
        provider = ' ',
        hl = function()
          return { fg = colors.skk.bg, bg = utils.get_highlight("StatusLine").bg }
        end,
      }
    )

    -- FileType

    local FileType = {
      condition = function(self)
        self.ft = vim.bo.filetype
        return self.ft ~= ""
      end,
      provider = function(self)
        return " "..self.ft.." "
      end,
      hl = {
        fg = colors.filetype.fg,
        bg = colors.filetype.bg,
      }
    }

    FileType = utils.insert(
      {
        provider = ' ',
        hl = {
          fg = colors.filetype.bg,
          bg = colors.diag_err.bg,
        },
      },
      FileType
    )

    -- File encode type

    local FileEncodeType = {
      init = function(self)
        self.fenc = vim.bo.fileencoding
        self.ff = vim.bo.fileformat
      end,
      provider = function(self)
        return " "..self.fenc.."["..self.ff.."]".." "
      end,
      hl = {
        fg = colors.fileencode.fg,
        bg = colors.fileencode.bg,
      },
    }

    FileEncodeType = utils.insert(
      {
        provider = ' ',
        hl = {
          fg = colors.fileencode.bg,
          bg = colors.filetype.bg,
        },
      },
      FileEncodeType
    )

---------------------------------- Line status --------------------------------

    local LineStatus = {
      static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
      },
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local percentage = math.floor((curr_line / lines) * 100)
        local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
        return " "..percentage.."%%".." "..string.rep(self.sbar[i], 2).." "
      end,
      hl = {
        fg = colors.linestatus.fg,
        bg = colors.linestatus.bg,
      }
    }

    LineStatus = {
      {
        provider = ' ',
        hl = {
          fg = colors.linestatus.bg,
          bg = colors.fileencode.bg,
        }
      },
      LineStatus
    }

----------------------------------- Diagnostic ---------------------------------

    -- Warning status

    local DiagnosticWarn = {
      condition = conditions.has_diagnostics,
      init = function(self)
        self.warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text
        local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.line = not luafunctions.is_empty(warn) and warn[1].lnum + 1 or 0
      end,
      provider = function(self)
        return self.line ~= 0 and " " .. self.warn_icon .. "[" .. "L" .. self.line .. "]" .. " " or ""
      end,
      hl = {
        fg = colors.diag_warn.fg,
        bg = colors.diag_warn.bg,
      }
    }

    DiagnosticWarn = utils.insert(
      {
        provider = ' ',
        hl = {
          fg = colors.diag_warn.bg,
          bg = utils.get_highlight("StatusLine").bg,
        }
      },
      DiagnosticWarn
    )

    -- Error status

    local DiagnosticError = {
      condition = conditions.has_diagnostics,
      init = function(self)
        self.error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text
        local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.line = not luafunctions.is_empty(error) and error[1].lnum + 1 or 0
      end,
      provider = function(self)
        return self.line ~= 0 and " " .. self.error_icon .. "[" .. "L" .. self.line .. "]" .. " " or ""
      end,
      hl = {
        fg = colors.diag_err.fg,
        bg = colors.diag_err.bg,
      }
    }

    DiagnosticError = {
      {
        provider = ' ',
        hl = {
          fg = colors.diag_err.bg,
          bg = colors.diag_warn.bg,
        }
      },
      DiagnosticError
    }

----------------------------------- File name ---------------------------------

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
        return self.icon and (self.icon.." ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end,
    }

    local FileName = {
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then
              return "[No Name]"
            end
            if not conditions.width_percent_below(#filename, 0.25) then
              filename = vim.fn.pathshorten(filename)
            end
            return filename
        end,
        hl = { fg = general_colors.fg },
    }

    local FileNameModifier = {
        hl = function()
            if vim.bo.modified then
                return { fg = general_colors.cyan, bold = true, force = true }
            end
        end,
    }

    FileNameBlock = utils.insert(FileNameBlock,
      FileIcon,
      utils.insert(FileNameModifier, FileName),
      { provider = '%<' }
    )

-------------------------------------- Main ------------------------------------

    local DefaultStatusline = {
      ViMode,
      SkkStatus,
      { provider = "%=" },
      FileNameBlock,
      { provider = "%=" },
      DiagnosticWarn,
      DiagnosticError,
      FileType,
      FileEncodeType,
      LineStatus,
    }

    local InactiveStatusline = {
      condition = function()
        return not conditions.is_active()
      end,
      { provider = "%=" },
      FileNameBlock,
      { provider = "%=" }
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
      init = utils.pick_child_on_condition,
      InactiveStatusline, DefaultStatusline
    }

    require('heirline').setup(Statuslines)
end

return heirline
