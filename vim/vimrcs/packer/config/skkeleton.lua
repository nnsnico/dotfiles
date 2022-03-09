local skkeleton = {}

skkeleton.setup = function()
  vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-toggle)', {})
  vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-toggle)', {})

  vim.cmd([[
    function! s:skkeleton_init() abort
      call skkeleton#config({
            \   'eggLikeNewline': v:true,
            \   'globalJisyo': expand('~/jisyo/SKK-JISYO.L'),
            \   'registerConvertResult': v:true,
            \ })
      call skkeleton#register_kanatable('rom', {
            \   "z\<Space>": ["\u3000", ''],
            \ })
    endfunction

    augroup skkeleton-coc
      autocmd!
      autocmd User skkeleton-initialize-pre call s:skkeleton_init()
      " autocmd User skkeleton-enable-pre let b:coc_suggest_disable = v:true
      " autocmd User skkeleton-disable-pre let b:coc_suggest_disable = v:false
    augroup END
  ]])
end

return skkeleton
