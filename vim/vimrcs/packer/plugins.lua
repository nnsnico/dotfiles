vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function(use)

------------------------------------- Basic ------------------------------------

  use 'wbthomason/packer.nvim'
  use 'vim-jp/vital.vim'

-------------------------------------- LSP -------------------------------------

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
    setup = require('packer.config.coc').setup(),
  }

---------------------------------- fuzzy finder --------------------------------

  use {
    'liuchengxu/vim-clap',
    run = ':Clap install-binary',
    setup = require('packer.config.clap').setup(),
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    }
  }

------------------------------------- filer ------------------------------------

  use {
    'kyazdani42/nvim-tree.lua',
    setup = require('packer.config.nvim-tree').setup(),
    config = require('packer.config.nvim-tree').config(),
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    }
  }

----------------------------- manipulation utility -----------------------------

  use 'jiangmiao/auto-pairs'
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
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'mg979/vim-visual-multi'
  use {
    'junegunn/vim-easy-align',
    keys = { '<Plug>(EasyAlign)' },
    setup = function()
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
    end,
  }
  use {
    'phaazon/hop.nvim',
    tag = 'v1',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.api.nvim_set_keymap('n', '<Leader>s', "<cmd>lua require'hop'.hint_char1()<CR>", {})
    end,
  }
  use 'psliwka/vim-smoothie'
  use {
    'vim-skk/skkeleton',
    setup = require('packer.config.skkeleton').setup(),
    requires = {
      {"vim-denops/denops.vim"}
    }
  }
  use {
    'Shougo/ddc.vim',
    config = require('packer.config.ddc').config(),
    requires = {
      {"vim-denops/denops.vim"},
      {"Shougo/ddc-matcher_head"},
      {"Shougo/ddc-sorter_rank"},
    }
  }
  use {
    'AndrewRadev/tagalong.vim',
    ft = { 'html', 'javascriptreact', 'jsx', 'php', 'typescriptreact', 'xml', 'markdown' },
    setup = function()
      vim.g.tagalong_additional_filetypes = { 'markdown' }
    end
  }

-------------------------------- visual utility --------------------------------

  use {
    'rebelot/heirline.nvim',
    config = require('packer.config.heirline').config(),
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = 1},
      {'vim-skk/skkeleton'},
    },
  }
  use {
    'Yggdroot/indentLine',
    setup = function()
      vim.g.indentLine_char_list = {'|', '¦'}
      vim.g.indentLine_setColors = 1
    end
  }
  use {
    'gelguy/wilder.nvim',
    config = require('packer.config.wilder').config(),
    requires = {'romgrk/fzy-lua-native', 'kyazdani42/nvim-web-devicons'}
  }

------------------------------------- VCS --------------------------------------

  use 'tpope/vim-fugitive'
  use {
    'airblade/vim-gitgutter',
    setup = function()
      vim.api.nvim_set_keymap('n', '<Space>hp', '<Plug>(GitGutterPreviewHunk)', { silent = true })
      vim.api.nvim_set_keymap('n', '<Space>ha', '<Plug>(GitGutterStageHunk)',   { silent = true })
      vim.api.nvim_set_keymap('n', '<Space>hr', '<Plug>(GitGutterUndoHunk)',    { silent = true })
      vim.api.nvim_set_keymap('n', ']c',        ':<C-u>GitGutterNextHunk<CR>',  { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[c',        ':<C-u>GitGutterPrevHunk<CR>',  { noremap = true, silent = true })
      vim.g.gitgutter_preview_win_floating    = 1
      vim.g.gitgutter_sign_removed            = '-'
      vim.g.gitgutter_sign_removed_first_line = '-'
      vim.g.gitgutter_highlight_linenrs = 1
    end
  }
  use {
    'APZelos/blamer.nvim',
    setup = function()
      vim.g.blamer_delay = 100
      vim.api.nvim_set_keymap('n', '<Space>b', ':<C-u>BlamerToggle<CR>', { noremap = true, silent = true })
    end,
  }
  use {
    'rhysd/git-messenger.vim',
    setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>b', '<Plug>(git-messenger)', { silent = true })
    end
  }

------------------------------------- Other ------------------------------------

  use {
    'tyru/open-browser.vim',
    setup = function()
      vim.api.nvim_set_keymap('o', '<Leader>o', '<Plug>(openbrowser-open)', {})
    end,
  }
  use 'editorconfig/editorconfig-vim'
  use {
    'voldikss/vim-translator',
    setup = function()
      vim.g.translator_target_lang = 'ja'
      vim.g.translator_source_lang = 'en'
      vim.api.nvim_set_keymap('n', '<Leader>t', '<Plug>TranslateW',  { silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>t', '<Plug>TranslateWV', { silent = true })
    end,
  }
  use {
    'nnsnico/sepcomment.vim',
    cmd = 'SepComment',
    setup = function() vim.g['sepcomment#length'] = 78 end
  }
  use {
    'glacambre/firenvim',
    tag = 'v0.2.12',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
    setup = function()
      vim.g.firenvim_config = {
        globalSettings = {
          alt = 'all',
        },
        localSettings = {
          ['.*'] = {
            cmdline  = 'neovim',
            content  = 'text',
            priority = 0,
            selector = 'textarea',
            takeover = 'always',
          },
          -- www.google.com以外無効化する(検索結果上の翻訳とかは使いたい)
          ['https?://[^/www]+\\.google\\.com\\/'] = {
            takeover = 'never'
          }
        }
      }
    end
  }

-------------------------------- syntax highlight ------------------------------

  use { 'rust-lang/rust.vim',           ft = 'rust', setup = function() vim.g.rustfmt_autosave = 1 end }
  use { 'elzr/vim-json',                ft = 'json', setup = function() vim.g.vim_json_syntax_conceal = 0 end }
  use { 'neoclide/jsonc.vim',           ft = 'jsonc' }
  use { 'HerringtonDarkholme/yats.vim', ft = { 'typescript', 'typescriptreact' } }
  use {
    'plasticboy/vim-markdown',
    ft = 'markdown' ,
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
