local M = {}

function M.config()
  local ensure_installed = { 'lua', 'json', 'dart' }

  require('nvim-treesitter.configs').setup({
    ensure_installed = ensure_installed,
    sync_install = true,
    highlight = {
      enable = true,
      disable = { "markdown" },
      additional_vim_regex_highlighting = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable    = true,
        lockahead = true,
        keymaps   = {
          ['af']  = '@function.outer',
          ['if']  = '@function.inner',
          ['ac']  = '@class.outer',
          ['ic']  = '@class.inner',
          ['ai']  = '@conditional.outer',
          ['ii']  = '@conditional.inner',
          ['al']  = '@loop.outer',
          ['il']  = '@loop.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      }
    }
  })
end

return M
