local M = {}

function M.config()
  require('nvim-treesitter.configs').setup({
    modules = {},
    ignore_install = {},
    auto_install = true,
    ensure_installed = { 'lua', 'json', 'dart' },
    sync_install = true,
    highlight = {
      enable = true,
      disable = { "markdown" },
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
    },
    -- nvim-treesitter-textobjects
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
    },
  })

  -- enable zsh syntax using as bash
  vim.treesitter.language.register('bash', 'zsh')
end

return M
