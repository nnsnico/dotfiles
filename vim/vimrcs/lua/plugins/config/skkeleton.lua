local skkeleton = {}

skkeleton.setup = function()
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-toggle)')
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-toggle)')

  local skkeleton_init = function()
    vim.fn['skkeleton#config']({
      eggLikeNewline        = true,
      globalJisyo           = vim.fn.expand('~/dotfiles/dict/SKK-JISYO'),
      markerHenkan          = '\u{F7BE} ',
      markerHenkanSelect    = '\u{F7BE} ',
    })
    vim.fn['skkeleton#register_kanatable']('rom', {
      ['z '] = { '\u{3000}', '' }
    })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = skkeleton_init,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-enable-post',
    callback = function()
      vim.keymap.del('l', '<CR>', { buffer = true })
    end,
  })

end

return skkeleton