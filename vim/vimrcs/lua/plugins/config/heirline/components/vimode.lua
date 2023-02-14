return {
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
