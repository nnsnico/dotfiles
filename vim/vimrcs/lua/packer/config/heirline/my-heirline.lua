local heirline = {}

heirline.config = function()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')
  local luafunctions = require('functions.utils')

  -- init theme
  require('packer.config.heirline.theme').init()

  ------------------------------------- ViMode -----------------------------------

  local ViMode = {
    init = function(self)
      self.mode = vim.fn.mode(1)

      if not self.once then
        vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:*o",
          command = 'redrawstatus'
        })
        self.once = true
      end
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
        n       = 'vimode_normal',
        i       = 'vimode_insert',
        v       = 'vimode_visual',
        V       = 'vimode_visual',
        ["\22"] = 'vimode_visual',
        c       = 'vimode_commandline',
        s       = 'vimode_select',
        S       = 'vimode_select',
        ["\19"] = 'vimode_select',
        R       = 'vimode_replace',
        r       = 'vimode_replace',
        ["!"]   = 'vimode_term',
        t       = 'vimode_term',
      }
    },
    provider = function(self)
      return "  %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      self.bg_color = self.mode_colors[mode]
      return {
        fg = 'vimode_fg',
        bg = self.mode_colors[mode],
        bold = true,
      }
    end,
    update = {
      "ModeChanged"
    }
  }

  ViMode = utils.insert(ViMode,
    {
      provider = ' ',
      hl = function(self)
        return { fg = self.bg_color, bg = 'skk_bg' }
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
      return " " .. self.mode .. " "
    end,
    hl = function()
      return {
        fg = 'skk_fg',
        bg = 'skk_bg',
      }
    end,
  }

  SkkStatus = utils.insert(SkkStatus,
    {
      provider = ' ',
      hl = function()
        return { fg = 'skk_bg', bg = utils.get_highlight("StatusLine").bg }
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
      return " " .. self.ft .. " "
    end,
    hl = {
      fg = 'filetype_fg',
      bg = 'filetype_bg',
    }
  }

  FileTypePL = utils.insert(
    {
      provider = ' ',
      hl = {
        fg = 'filetype_bg',
        bg = 'diag_err_bg',
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
      return " " .. self.fenc .. "[" .. self.ff .. "]" .. " "
    end,
    hl = {
      fg = 'fileencode_fg',
      bg = 'fileencode_bg',
    },
  }

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

  local LineStatus = {
    static = {
      sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local percentage = math.floor((curr_line / lines) * 100)
      local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
      return " " .. percentage .. "%%" .. " " .. string.rep(self.sbar[i], 2) .. " "
    end,
    hl = {
      fg = 'linestatus_fg',
      bg = 'linestatus_bg',
    }
  }

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
      fg = 'diag_warn_fg',
      bg = 'diag_warn_bg',
    }
  }

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
      fg = 'diag_err_fg',
      bg = 'diag_err_bg',
    }
  }

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
      return self.icon and (self.icon .. " ")
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
    hl = { fg = 'filename_fg' },
  }

  local FileNameModifier = {
    hl = function()
      if vim.bo.modified then
        return { fg = 'filename_modifier', bold = true, force = true }
      end
    end,
  }

  FileNameBlock = utils.insert(FileNameBlock,
    { provider = " " },
    FileIcon,
    utils.insert(FileNameModifier, FileName),
    { provider = '%<' },
    { provider = " " }
  )

  ----------------------------------- Winbar -----------------------------------

  vim.api.nvim_create_autocmd("User", {
    pattern = 'HeirlineInitWinbar',
    callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains(
        { "prompt", "nofile", "help", "quickfix" },
        vim.bo[buf].buftype
      )
      local filetype = vim.tbl_contains({ "gitcommit", "fugitive" }, vim.bo[buf].filetype)
      if buftype or filetype then
        vim.opt_local.winbar = nil
      end
    end,
  })

  local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      return "\u{f489} " .. tname
    end,
    hl = { fg = 'winbar_term_fg', bold = true },
  }

  local WinBars = {
    fallthrough = false,
    { -- Hide the winbar for special buffers
      condition = function()
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "^git.*", "fugitive" },
        })
      end,
      init = function()
        vim.opt_local.winbar = nil
      end
    },
    { -- A special winbar for terminals
      condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
      end,
      utils.surround({ "", "\u{e0bc}" }, 'winbar_term_bg', {
        FileType,
        { provider = "%=" },
        TerminalName,
      }),
    },
    { -- An inactive winbar for regular files
      condition = function()
        return not conditions.is_active()
      end,
      utils.surround(
        { "", "\u{e0bd}" },
        'winbar_inactive_fg',
        { hl = { fg = 'winbar_inactive_text', bg = 'winbar_inactive_bg', force = true }, FileNameBlock }
      ),
    },
    -- A winbar for regular files
    utils.surround(
      { "", "\u{e0bc}" },
      'winbar_active_fg',
      { hl = { fg = 'winbar_active_text', force = true }, FileNameBlock }
    ),
  }

  ------------------------------------ Main ------------------------------------

  local DefaultStatusline = {
    ViMode,
    SkkStatus,
    { provider = "%=" },
    DiagnosticWarn,
    DiagnosticError,
    FileTypePL,
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
    fallthrough = false,
    InactiveStatusline, DefaultStatusline
  }

  require('heirline').setup(Statuslines, WinBars)
end

return heirline
