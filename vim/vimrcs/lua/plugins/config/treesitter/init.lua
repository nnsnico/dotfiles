local M = {}

function M.config()
  require('nvim-treesitter.configs').setup({
    modules = {},
    ignore_install = {},
    auto_install = true,
    ensure_installed = {
      'lua',
      'json',
      'dart',
      'markdown',
      'markdown_inline',
    },
    sync_install = true,
    markdown = {
      enable = true,
      mappings = {
        inline_surround_toggle      = false,
        inline_surround_toggle_line = false,
        inline_surround_delete      = false,
        inline_surround_change      = false,
        link_add                    = false,
        link_follow                 = false,
      },
    },
    highlight = {
      enable = true,
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
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
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
