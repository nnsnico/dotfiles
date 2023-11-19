local skkeleton = {}

skkeleton.setup = function()
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-enable)')
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-toggle)')

  local skkeleton_init = function()
    ---@type table?
    local azik_rule_path = vim.fn.exists('mac') and
    {
      {
        vim.fn.expand('~/dotfiles/dict/azik_us.rule'),
        'euc-jp'
      }
    } or nil

    -- custom configurations
    vim.fn['skkeleton#config']({
      eggLikeNewline       = true,
      globalJisyo          = vim.fn.expand('~/dotfiles/dict/SKK-JISYO'),
      globalKanaTableFiles = azik_rule_path,
    })

    -- custom kana table
    vim.fn['skkeleton#register_kanatable']('rom', {
      ['z '] = { '\u{3000}', '' },
    })

    -- custom keymap in input kana
    vim.fn['skkeleton#register_keymap']('input', '-', 'katakana')
    vim.fn['skkeleton#register_keymap']('input', 'l', 'disable')
  end

  -- Setup user config before initializing skkeleton
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = skkeleton_init,
  })
end

return skkeleton
