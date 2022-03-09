vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    setup = {
      require('packer.config.nvim-tree').setup()
    },
    config = function()
      require('packer.config.nvim-tree').config()
    end,
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    }
  }

  use {
    'liuchengxu/vim-clap',
    run = ':Clap install-binary',
    setup = function()
      require('packer.config.clap').setup()
    end,
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    }
  }

  use {
    'rebelot/heirline.nvim',
    config = function()
      require('packer.config.heirline').config()
    end,
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = 1},
      {'vim-skk/skkeleton'},
    },
  }

  use {
    'vim-skk/skkeleton',
    setup = function()
      require('packer.config.skkeleton').setup()
    end,
    requires = {
      {"vim-denops/denops.vim"}
    }
  }

  use {
    'Shougo/ddc.vim',
    config = function()
      require('packer.config.ddc').config()
    end,
    requires = {
      {"vim-denops/denops.vim"},
      {"Shougo/ddc-matcher_head"},
      {"Shougo/ddc-sorter_rank"},
    }
  }

  use {
    'phaazon/hop.nvim',
    tag = 'v1',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.api.nvim_set_keymap('n', '<Leader>s', "<cmd>lua require'hop'.hint_char1()<CR>", {})
    end,
  }

  use {
    'gelguy/wilder.nvim',
    run = ':UpdateRemotePlugins',
    config = function()
      require('packer.config.wilder').config()
    end
  }

  require('packer.config.coc').setup(use)
  -- use {
  --   'neoclide/coc.nvim',
  --   ft = {
  --     'c',
  --     'dart',
  --     'elm',
  --     'eruby',
  --     'go',
  --     'haskell',
  --     'hs',
  --     'javascript',
  --     'javascriptreact',
  --     'json',
  --     'lhs',
  --     'lua',
  --     'markdown',
  --     'purescript',
  --     'python',
  --     'rust',
  --     'sbt',
  --     'scala',
  --     'sh',
  --     'typescript',
  --     'typescriptreact',
  --     'vim',
  --     'yaml',
  --     'zsh',
  --   },
  --   tag = 'release',
  --   setup = function()
  --     vim.o.updatetime = 300
  --     vim.o.shortmess = vim.o.shortmess .. 'c'
  --     vim.o.signcolumn = 'yes'

  --     vim.cmd([[
  --       autocmd CursorHold *.scala,*.ts,*.tsx,*.dart silent call CocActionAsync('highlight')
  --     ]])

  --     vim.api.nvim_set_keymap('n', '<C-j>', 'coc#float#has_float() ? coc#float#scroll(1) : "<C-j>"', { noremap = true, expr = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<C-k>', 'coc#float#has_float() ? coc#float#scroll(0) : "<C-k>"', { noremap = true, expr = true, silent = true })

  --     vim.api.nvim_set_keymap('n', '[e',         '<Plug>(coc-diagnostic-prev)',                                                     { silent = true })
  --     vim.api.nvim_set_keymap('n', ']e',         '<Plug>(coc-diagnostic-next)',                                                     { silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>q',   ':<C-u>CocFix<CR>',                                                                { silent = true })
  --     vim.api.nvim_set_keymap('v', '<Space>q',   '<Plug>(coc-codeaction-selected)',                                                 { silent = true })
  --     vim.api.nvim_set_keymap('n', 'gd',         '<Plug>(coc-definition)',                                                          { silent = true })
  --     vim.api.nvim_set_keymap('n', 'gy',         '<Plug>(coc-type-definition)',                                                     { silent = true })
  --     vim.api.nvim_set_keymap('n', 'gi',         '<Plug>(coc-implementation)',                                                      { silent = true })
  --     vim.api.nvim_set_keymap('n', 'gr',         '<Plug>(coc-references)',                                                          { silent = true })
  --     vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)',                                                              { silent = true })
  --     vim.api.nvim_set_keymap('n', 'K',          ':call CocAction("doHover")<CR>',                                                  { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>c',   ':CocCommand<CR>',                                                                 { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>f',   ':call CocAction("format")<CR>',                                                   { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>i',   ':CocCommand editor.action.organizeImport<CR>',                                    { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>a',   ':<C-u>CocList diagnostics<CR>',                                                   { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>o',   ':<C-u>CocList outline<CR>',                                                       { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>s',   ':<C-u>CocList -I symbols<CR>',                                                    { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>j',   ':<C-u>CocNext<CR>',                                                               { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>k',   ':<C-u>CocPrev<CR>',                                                               { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<Space>p',   ':<C-u>CocListResume<CR>',                                                         { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('i', '<CR>',       'pumvisible() ? coc#_select_confirm(): "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { noremap = true, expr = true, silent = true })

  --     -- for flutter
  --     vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>CocCommand flutter.toggleOutline<CR>', { noremap = true, silent = true })
  --   end,
  -- }

  use {
    'voldikss/vim-translator',
    setup = function()
      vim.g.translator_target_lang = 'ja'
      vim.g.translator_source_lang = 'en'

      vim.api.nvim_set_keymap('n', '<Leader>t', '<Plug>TranslateW',  { silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>t', '<Plug>TranslateWV', { silent = true })
    end,
  }

  use 'jiangmiao/auto-pairs'

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'mg979/vim-visual-multi'

  use 'psliwka/vim-smoothie'

  use {
    'nnsnico/sepcomment.vim',
    cmd = 'SepComment',
    setup = function()
      vim.g['sepcomment#length'] = 78
    end
  }

  use {
    'junegunn/vim-easy-align',
    keys = { '<Plug>(EasyAlign)' },
    setup = function()
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
    end,
  }

  use {
    'luochen1990/rainbow',
    setup = function()
      vim.g.rainbow_active = 1
      vim.g.rainbow_conf = {
        separately = {
          nerdtree = 0
        }
      }
    end,
  }

  use {
    'Yggdroot/indentLine',
    setup = function()
      vim.g.indentLine_char_list = {'|', '¦'}
      vim.g.indentLine_setColors = 1
    end
  }

  use {
    'glacambre/firenvim',
    tag = 'v0.2.12',
    run = function()
      vim.fn['firenvim#install'](0)
    end
  }

  use {
    'tyru/open-browser.vim',
    setup = function()
      vim.api.nvim_set_keymap('o', '<Leader>o', '<Plug>(openbrowser-open)', {})
    end,
  }

  use {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
    setup = function()
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_folding_disabled        = 1
      vim.g.vim_markdown_conceal                 = 0
      vim.g.vim_markdown_conceal_code_blocks     = 0
    end
  }

  use {
    'godlygeek/tabular',
    ft = { 'markdown' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<Space>@', ':TableFormat<CR>', { noremap = true, silent = true })
    end
  }

end)
