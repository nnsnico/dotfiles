local M = {}

M.config = function()
  require('dressing').setup({
    input = {
      insert_only = false,
      start_in_insert = false,
      mappings = {
        n = {
          ["<Esc><Esc>"] = "Close",
          ["<C-g>"]      = "Close",
          ["<CR>"]       = "Confirm",
        },
        i = {
          ["<Esc><Esc>"] = "Close",
          ["<C-g>"]      = "Close",
          ["<CR>"]       = "Confirm",
          ["<C-a>"]      = "<Home>",
          ["<C-e>"]      = "<End>",
        }
      },
    },
    select = {
      get_config = function(opts)
        if opts.kind == 'codeaction' then
          return {
            backend = 'builtin',
            builtin = {
              relative = 'cursor',
              min_height = 1,
              mappings = {
                ['<C-g>'] = 'Close'
              }
            }
          }
        end
      end
    },
  })
end

return M
