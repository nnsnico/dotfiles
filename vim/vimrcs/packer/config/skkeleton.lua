local skkeleton = {}

skkeleton.setup = function()
  vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-toggle)', {})
  vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-toggle)', {})

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

  local augroup = vim.api.nvim_create_augroup('skkeleton-coc', {})
  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'skkeleton-initialize-pre',
    callback = skkeleton_init,
  })
  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'skkeleton-enable-pre',
    callback = function()
      vim.b.coc_suggest_disable = true
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    group = augroup,
    pattern = 'skkeleton-disable-pre',
    callback = function()
      vim.b.coc_suggest_disable = false
    end,
  })
end

return skkeleton
