local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local base = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local icon = {
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

local file_name = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then self.lfilename = "[No Name]" end
  end,
  hl = { fg = 'filename_fg' },
  utils.make_flexible_component(2, {
    provider = function(self)
      return self.lfilename
    end
  }, {
    provider = function(self)
      return vim.fn.fnamemodify(self.lfilename, ':t')
    end
  })
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
  icon,
  utils.insert(modifier_highlight, file_name),
  { provider = '%<' },
  { provider = " " }
)
