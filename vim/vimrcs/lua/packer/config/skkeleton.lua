local skkeleton = {}

skkeleton.setup = function()
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-toggle)')
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-toggle)')

  local skkeleton_init = function()
    vim.fn['skkeleton#config']({
      eggLikeNewline        = true,
      globalJisyo           = vim.fn.expand('~/jisyo/SKK-JISYO.L'),
      registerConvertResult = true,
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

  -- Toggle use of skkeleton (with ddc) and nvim-cmp
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-enable-pre',
    callback = function()
      require('cmp').setup.buffer({ enabled = function() return false end })
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-disable-pre',
    callback = function()
      require('cmp').setup.buffer({ enabled = function() return true end })
    end
  })
end

return skkeleton
