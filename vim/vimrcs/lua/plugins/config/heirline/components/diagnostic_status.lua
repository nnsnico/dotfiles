local M = {}

local conditions = require('heirline.conditions')

M.warn = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN] .. " "
    local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.line = not vim.tbl_isempty(warn) and warn[1].lnum + 1 or 0
  end,
  provider = function(self)
    return self.line ~= 0 and " " .. self.warn_icon .. self.line .. " " or ""
  end,
  hl = {
    fg = 'diag_warn_fg',
    bg = 'diag_warn_bg',
  }
}

M.error = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR] .. " "
    local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.line = not vim.tbl_isempty(error) and error[1].lnum + 1 or 0
  end,
  provider = function(self)
    return self.line ~= 0 and " " .. self.error_icon .. self.line .. " " or ""
  end,
  hl = {
    fg = 'diag_err_fg',
    bg = 'diag_err_bg',
  }
}

return M
