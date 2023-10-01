local M = {}

---@class Ibl.Highlight
---@field name string
---@field colorCode string

M.config = function()
---@type Ibl.Highlight[]
  local highlight = {
    { name = "RainbowRed",    colorCode = "#E06C75" },
    { name = "RainbowYellow", colorCode = "#E5C07B" },
    { name = "RainbowBlue",   colorCode = "#61AFEF" },
    { name = "RainbowOrange", colorCode = "#D19A66" },
    { name = "RainbowGreen",  colorCode = "#98C379" },
    { name = "RainbowViolet", colorCode = "#C678DD" },
    { name = "RainbowCyan",   colorCode = "#56B6C2" },
  }
  local hooks = require('ibl.hooks')
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for _, value in pairs(highlight) do
      vim.api.nvim_set_hl(0, value.name, { fg = value.colorCode })
    end
  end)

  local highlightName = vim.tbl_map(
  ---@param value Ibl.Highlight
    function(value)
      return value.name
    end,
    highlight
  )

  vim.g.rainbow_delimiters = { highlight = highlightName }
  require('ibl').setup({ scope = { highlight = highlightName } })

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
