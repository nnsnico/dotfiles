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
