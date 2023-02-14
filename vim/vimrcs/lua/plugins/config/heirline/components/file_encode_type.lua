return {
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
