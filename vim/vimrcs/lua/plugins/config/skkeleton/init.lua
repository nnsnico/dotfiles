local skkeleton = {}
local azik_converter = require('plugins.config.skkeleton.convert_azik')

skkeleton.setup = function()
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-toggle)')
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-toggle)')

  local skkeleton_init = function()
    local google_ime_kanatable = vim.fn.expand('~/dotfiles/dict/google-ime/romantable.txt')
    azik_converter.register_azik_kanatable(google_ime_kanatable)

    -- custom configurations
    vim.fn['skkeleton#config']({
      eggLikeNewline     = true,
      globalDictionaries = { vim.fn.expand('~/dotfiles/dict/SKK-JISYO') },
      completionRankFile = vim.fn.expand('~/dotfiles/dict/rank.json'),
      kanaTable          = 'azik',
    })

    -- custom kana table
    vim.fn['skkeleton#register_kanatable']('azik', {
      ['z '] = { '\u{3000}', '' },
      ['('] = { '（', '' },
      [')'] = { '）', '' },
      ['?'] = { '？', '' },
      ['!'] = { '！', '' },
      [' '] = 'henkanFirst',
      ['_'] = 'hankatakana',
      [':'] = 'henkanPoint',
    })

    vim.cmd([[
      call add(g:skkeleton#mapped_keys, '<C-l>')
      call add(g:skkeleton#mapped_keys, '<C-d>')
    ]])

    -- custom keymap in input kana
    vim.fn['skkeleton#register_keymap']('input', '<C-d>', 'katakana')
    vim.fn['skkeleton#register_keymap']('input', '<C-l>', 'disable')
  end

  -- Setup user config before initializing skkeleton
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = skkeleton_init,
  })
end

return skkeleton
