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
  })

  -- enable zsh syntax using as bash
  vim.treesitter.language.register('bash', 'zsh')
end

return M
