local utils = require('heirline.utils')

local FileIcon = require('plugins.config.heirline.components.file_icon')

local base = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local file_name = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then self.lfilename = "[No Name]" end
  end,
  hl = { fg = 'filename_fg' },
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end
  },
  {
    provider = function(self)
      return vim.fn.fnamemodify(self.lfilename, ':t')
    end,
  }
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "file_flags_changed" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "\u{E0A2}",
    hl = { fg = "file_flags_readonly" },
  }
}

local modifier_highlight = {
  hl = function()
    if vim.bo.modified then
      return { fg = 'filename_modifier', bold = true, force = true }
    end
  end,
}

return utils.insert(base,
  { provider = " " },
  FileIcon,
  utils.insert(modifier_highlight, file_name),
  unpack(FileFlags),
  { provider = '%<' },
  { provider = " " }
)
