local coc = {}

coc.setup = function(use)
  use {
    'neoclide/coc.nvim',
    ft = {
      'c',
      'dart',
      'elm',
      'eruby',
      'go',
      'haskell',
      'hs',
      'javascript',
      'javascriptreact',
      'json',
      'lhs',
      'lua',
      'markdown',
      'purescript',
      'python',
      'rust',
      'sbt',
      'scala',
      'sh',
      'typescript',
      'typescriptreact',
      'vim',
      'yaml',
      'zsh',
    },
    tag = 'release',
    setup = function()
      vim.o.updatetime = 300
      vim.o.shortmess = vim.o.shortmess .. 'c'
      vim.o.signcolumn = 'yes'

      vim.cmd([[
        autocmd CursorHold *.scala,*.ts,*.tsx,*.dart silent call CocActionAsync('highlight')
      ]])

      vim.api.nvim_set_keymap('n', '<C-j>', 'coc#float#has_float() ? coc#float#scroll(1) : "<C-j>"', { noremap = true, expr = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-k>', 'coc#float#has_float() ? coc#float#scroll(0) : "<C-k>"', { noremap = true, expr = true, silent = true })

      vim.api.nvim_set_keymap('n', '[e',         '<Plug>(coc-diagnostic-prev)',                                                     { silent = true })
      vim.api.nvim_set_keymap('n', ']e',         '<Plug>(coc-diagnostic-next)',                                                     { silent = true })
      vim.api.nvim_set_keymap('n', '<Space>q',   ':<C-u>CocFix<CR>',                                                                { silent = true })
      vim.api.nvim_set_keymap('v', '<Space>q',   '<Plug>(coc-codeaction-selected)',                                                 { silent = true })
      vim.api.nvim_set_keymap('n', 'gd',         '<Plug>(coc-definition)',                                                          { silent = true })
      vim.api.nvim_set_keymap('n', 'gy',         '<Plug>(coc-type-definition)',                                                     { silent = true })
      vim.api.nvim_set_keymap('n', 'gi',         '<Plug>(coc-implementation)',                                                      { silent = true })
      vim.api.nvim_set_keymap('n', 'gr',         '<Plug>(coc-references)',                                                          { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)',                                                              { silent = true })
      vim.api.nvim_set_keymap('n', 'K',          ':call CocAction("doHover")<CR>',                                                  { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>c',   ':CocCommand<CR>',                                                                 { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>f',   ':call CocAction("format")<CR>',                                                   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>i',   ':CocCommand editor.action.organizeImport<CR>',                                    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>a',   ':<C-u>CocList diagnostics<CR>',                                                   { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>o',   ':<C-u>CocList outline<CR>',                                                       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>s',   ':<C-u>CocList -I symbols<CR>',                                                    { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>j',   ':<C-u>CocNext<CR>',                                                               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>k',   ':<C-u>CocPrev<CR>',                                                               { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>p',   ':<C-u>CocListResume<CR>',                                                         { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', '<CR>',       'pumvisible() ? coc#_select_confirm(): "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { noremap = true, expr = true, silent = true })

      -- for flutter
      vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>CocCommand flutter.toggleOutline<CR>', { noremap = true, silent = true })
    end,
  }
end

return coc
