local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
---@diagnostic disable: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -------------------------------- Treesitter ----------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('plugins.config.my-treesitter').config()
    end,
    dependencies = {
      'mrjones2014/nvim-ts-rainbow',
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup({
            enable = true
          })
        end,
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },
  -------------------------------- fuzzy finder --------------------------------
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    keys = require('plugins.config.my-telescope').setup(),
    config = function()
      require('plugins.config.my-telescope').config()
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'kyazdani42/nvim-web-devicons',
    }
  },
  ------------------------------------ LSP -------------------------------------
  {
    'williamboman/mason.nvim',
    ft = require('plugins.config.lsp.my-nvim-lsp-installer').filetypes(),
    cmd = 'Mason',
    config = function()
      require('plugins.config.lsp.my-nvim-lsp-installer').config()
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
      'ii14/emmylua-nvim',
      'SmiteshP/nvim-navic',
      'hrsh7th/cmp-nvim-lsp',
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('plugins.config.my-null-ls').config()
        end,
        dependencies = {
          { 'nvim-lua/plenary.nvim' },
        },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-cmdline' },
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'f3fora/cmp-spell' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'uga-rosa/cmp-skkeleton' },
      { 'onsails/lspkind.nvim' },
    },
    config = function()
      require('plugins.config.my-nvim-cmp').config()
    end,
  },
  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    init = function()
      vim.keymap.set('n', '<Space>s', '<cmd>AerialToggle!<CR>', {})
    end,
    config = function()
      require('aerial').setup()
    end
  },
  {
    'akinsho/flutter-tools.nvim',
    ft = 'dart',
    init = function()
    end,
    config = function()
      require('plugins.config.lsp.my-nvim-lspconfig').attach_lsp()

      vim.keymap.set('n', '<Space>o', ':<C-u>FlutterOutlineToggle<CR>', { silent = true, buffer = true })

      require('flutter-tools').setup({
        fvm = true,
        widget_guides = {
          enabled = true,
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'scalameta/nvim-metals',
    ft = { 'scala', 'sbt' },
    config = function()
      local metals_config = require('metals').bare_config()

      require('plugins.config.lsp.my-nvim-lspconfig').attach_lsp()

      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' }
      }
      metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'scala', 'sbt', 'java' },
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/cmp-nvim-lsp',
    }
  },
  ------------------------------- visual utility -------------------------------
  {
    'rebelot/heirline.nvim',
    config = function()
      require('plugins.config.heirline.my-heirline').config()
    end,
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'vim-skk/skkeleton',
      'SmiteshP/nvim-navic',
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost' },
    config = function()
      vim.g.indent_blankline_char_list = { '|', '¦' }
      vim.g.indent_blankline_use_treesitter = true
      require('indent_blankline').setup {
        space_char_blankline       = " ",
        show_current_context       = true,
        show_current_context_start = true,
      }
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    init = function()
      require('plugins.config.my-nvim-bqf').setup()
    end,
    config = function()
      require('plugins.config.my-nvim-bqf').config()
    end,
    dependencies = {
      {
        'junegunn/fzf',
        build = function()
          vim.fn['fzf#install']()
        end,
      },
    }
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.config.my-nvim-notify').config()
    end
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('dressing').setup({
        input = {
          insert_only = false,
          start_in_insert = false,
          mappings = {
            n = {
              ["<Esc><Esc>"] = "Close",
              ["<C-g>"]      = "Close",
              ["<CR>"]       = "Confirm",
            },
            i = {
              ["<Esc><Esc>"] = "Close",
              ["<C-g>"]      = "Close",
              ["<CR>"]       = "Confirm",
              ["<C-a>"]      = "<Home>",
              ["<C-e>"]      = "<End>",
            }
          },
        },
        select = {
          get_config = function(opts)
            if opts.kind == 'codeaction' then
              return {
                backend = 'builtin',
                builtin = {
                  relative = 'cursor',
                  min_height = 1,
                  mappings = {
                    ['<C-g>'] = 'Close'
                  }
                }
              }
            end
          end
        },
      })
    end
  },
  ---------------------------- manipulation utility ----------------------------
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'tpope/vim-commentary',
    keys = {
      'gc',
      'gcc',
      'gcu',
      { 'gc', mode = 'x' },
      { 'gc', mode = 'o' },
    }
  },
  {
    'tpope/vim-repeat',
  },
  {
    'tpope/vim-surround',
    keys = {
      'ds',
      'cs',
      'cS',
      'ys',
      'yS',
      'yss',
      'ySs',
      'ySS',
      { 'S', mode = 'x' },
      { 'gS', mode = 'x' },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'lua',
        callback = function()
          vim.b.surround_102 = 'function \1function name: \1() \r end'
        end
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'vim',
        callback = function()
          vim.b.surround_102 = 'function \1function name: \1() \r endfunction'
        end
      })
    end
  },
  {
    'mg979/vim-visual-multi',
    keys = {
      { '<C-n>',             mode = { 'n', 'v' } },
      { '<Leader><Leader>A', mode = { 'n', 'v' } },
      { '<Leader><Leader>c', mode = { 'n', 'v' } },
      '<Leader><Leader>/'
    },
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'x', 'n' } }
    }
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    keys = {
      { '<Leader>s' },
    },
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
      vim.keymap.set('n', '<Leader>s', require('hop').hint_char1)
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = 'v1.*',
    keys = require('plugins.config.my-window-picker').setup(),
    config = function()
      require('plugins.config.my-window-picker').config()
    end,
    dependencies = { 'nvim-tree.lua' }
  },
  {
    'karb94/neoscroll.nvim',
    event = { 'BufReadPost' },
    config = function()
      require('neoscroll').setup({
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zz', 'zt', 'zb' },
        easing_function = 'circular'
      })
    end
  },
  ----------------------------------- filer ------------------------------------
  {
    'kyazdani42/nvim-tree.lua',
    tag = 'nightly',
    cmd = {
      'NvimTreeOpen',
      'NvimTreeToggle',
      'NvimTreeFindFile',
      'NvimTreeRefresh',
    },
    init = function()
      require('plugins.config.my-nvim-tree').setup()
    end,
    config = function()
      require('plugins.config.my-nvim-tree').config()
    end,
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },
  ------------------------------------ VCS -------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    event = { 'FocusLost', 'CursorHold' },
    config = function()
      require('plugins.config.my-gitsigns').config()
    end,
  },
  {
    'iberianpig/tig-explorer.vim',
    keys = {
      { '<Leader>g', '<Cmd>TigOpenProjectRootDir<CR>', mode = 'n' }
    },
    dependencies = {
      { 'rbgrouleff/bclose.vim', cmd = 'Bclose' },
    }
  },
  ----------------------------------- Other ------------------------------------
  {
    'tyru/open-browser.vim',
    keys = {
      { '<Leader>o', '<Plug>(openbrowser-open)', mode = 'v' }
    },
    cmd = { 'OpenBrowser', 'OpenBrowserSearch' },
  },
  {
    'voldikss/vim-translator',
    keys = {
      { '<Leader>t', '<Plug>TranslateW', mode = 'n', silent = true },
      { '<Leader>t', '<Plug>TranslateWV', mode = 'v', silent = true },
    },
    cmd = { 'Translate' },
    init = function()
      vim.g.translator_target_lang = 'ja'
      vim.g.translator_source_lang = 'en'
    end,
  },
  {
    'vim-skk/skkeleton',
    init = function()
      require('plugins.config.skkeleton').setup()
    end,
    dependencies = {
      { "vim-denops/denops.vim" }
    },
  },
  {
    'nnsnico/sepcomment.vim',
    cmd = 'SepComment',
    init = function()
      vim.g['sepcomment#length'] = 78
    end,
  },
  {
    'glacambre/firenvim',
    build = function()
      vim.fn['firenvim#install'](0)
    end,
    cond = not not vim.g.started_by_firenvim,
    init = function()
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
          ['https://www\\.google\\.com/'] = {
            takeover = 'never',
            priority = 1,
          },
          ['https://mail\\.google\\.com/'] = {
            content  = 'html',
            priority = 1,
            selector = 'div[role="textbox"]',
            takeover = 'always',
          },
          ['https://github\\.com/.*blob.*'] = {
            takeover = 'never',
            priority = 1,
          },
          ['https://github\\.com/.*(issues|pull).*'] = {
            cmdline  = 'neovim',
            content  = 'text',
            priority = 1,
            selector = 'textarea',
            takeover = 'always',
            filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md',
          },
          ['https://blog\\.hatena\\.ne\\.jp/'] = {
            cmdline  = 'neovim',
            content  = 'text',
            priority = 1,
            selector = 'textarea',
            takeover = 'always',
            filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md',
          },
          ['https://play\\.kotlinlang\\.org'] = {
            cmdline  = 'neovim',
            content  = 'text',
            priority = 1,
            selector = 'textarea',
            takeover = 'always',
            filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.kt',
          },
          ['https://perf\\.hrmos\\.co/'] = {
            content  = 'html',
            priority = 1,
            selector = 'div[class="ql-editor"]',
            takeover = 'always',
          },
          ['https://.*\\.notion\\.so'] = {
            takeover = 'never',
            priority = 1,
          },
          ['https://.*\\.notion\\.site/'] = {
            takeover = 'never',
            priority = 1,
          },
        }
      }
      if vim.g.started_by_firenvim then
        vim.keymap.set('n', '<C-e>', '<Cmd>call firenvim#hide_frame()<CR>', { silent = true })
        vim.o.laststatus = 0
        vim.o.wrap = true
        vim.api.nvim_create_autocmd('BufEnter', {
          callback = function()
            if vim.o.lines < 20 then
              vim.o.lines = 20
            end
          end
        })
      end
      vim.cmd('hi link CmpItemAbbrDefault Pmenu')
      vim.cmd('hi link CmpItemAbbr Pmenu')
      vim.cmd('hi link CmpItemMenu Pmenu')
    end
  },
  {
    'wakatime/vim-wakatime'
  },
  --------------------------------- file type ----------------------------------
  -- markdown
  {
    'plasticboy/vim-markdown',
    ft = 'markdown',
    init = function()
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_folding_disabled        = 1
      vim.g.vim_markdown_conceal                 = 0
      vim.g.vim_markdown_conceal_code_blocks     = 0
    end,
  },
  {
    'godlygeek/tabular',
    ft = 'markdown',
    config = function()
      vim.keymap.set('n', '<Space>@', '<Cmd>TableFormat<CR>', { silent = true, buffer = true })
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = ':call mkdp#util#install()',
  },
  -------------------------------- color scheme --------------------------------
  {
    'ray-x/aurora',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_bold   = 1
      vim.g.aurora_darker = 1
      vim.cmd([[colorscheme aurora]])
    end
  }
}, {
    ui = {
      border = 'rounded'
    }
})
