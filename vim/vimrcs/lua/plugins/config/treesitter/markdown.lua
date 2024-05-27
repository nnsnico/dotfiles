local M = {}

M.config = function()
  require('markdown').setup({
      mappings = {
        inline_surround_toggle      = false,
        inline_surround_toggle_line = false,
        inline_surround_delete      = false,
        inline_surround_change      = false,
        link_add                    = false,
        link_follow                 = false,
      },
  })
end

return M
