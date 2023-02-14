return {
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
