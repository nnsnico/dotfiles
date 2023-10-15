local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
      require('plugins.config.treesitter').config()
    end,
    dependencies = {
      'HiPhish/rainbow-delimiters.nvim',
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup({
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            zindex = 20,
            mode = 'cursor',
          })
        end,
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    }
  },
  -------------------------------- fuzzy finder --------------------------------
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    keys = require('plugins.config.telescope').setup(),
    config = function()
      require('plugins.config.telescope').config()
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
    event = 'VeryLazy',
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
          require('plugins.config.null-ls').config()
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
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
      },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'f3fora/cmp-spell' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'uga-rosa/cmp-skkeleton' },
      { 'onsails/lspkind.nvim' },
    },
    config = function()
      require('plugins.config.nvim-cmp').config()
    end,
  },
  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    init = function()
      vim.keymap.set('n', '<Space>s', '<cmd>AerialToggle<CR>',  {})
      vim.keymap.set('n', '<Space>S', '<cmd>AerialToggle!<CR>', {})
    end,
    config = function()
      require('aerial').setup()
    end
  },
  {
    'akinsho/flutter-tools.nvim',
    event = 'VeryLazy',
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
    event = 'VeryLazy',
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
        pattern = { 'scala', 'sbt', 'sc', 'java' },
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
    event = 'VeryLazy',
    config = function()
      require('plugins.config.heirline').config()
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
      require('plugins.config.indent-blankline').config()
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    init = function()
      require('plugins.config.nvim-bqf').setup()
    end,
    config = function()
      require('plugins.config.nvim-bqf').config()
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
    'vigoux/notifier.nvim',
    event = 'VeryLazy',
    config = function()
      require('notifier').setup()
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.config.dressing').config()
    end
  },
  {
    'anuvyklack/windows.nvim',
    event = { 'BufReadPost' },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    }
  },
  {
    'luukvbaal/statuscol.nvim',
    event = 'VeryLazy',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        segments = {
          {
            sign = {
              name     = { 'Diagnostic' },
              maxwidth = 2,
              auto     = true
            },
            click = 'v:lua.ScSa',
          },
          {
            text = { builtin.lnumfunc },
            click = 'v:lua.ScLa',
          },
          {
            sign = { namespace = { 'gitsign*' } },
            click = 'v:lua.ScSa',
          },
        }
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
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end,
    lazy = false,
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
    ---@deprecated: no longer maintained. Use instead leap.nvim
    'phaazon/hop.nvim',
    enabled = false,
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
    'ggandor/leap.nvim',
    keys = {
      {
        '<Leader>\\',
        function()
          require('leap').leap({ target_windows = { vim.fn.win_getid() } })
        end,
        { 'n', 'x', 'o' },
      }
    },
  },
  {
    's1n7ax/nvim-window-picker',
    version = 'v1.*',
    keys = require('plugins.config.window-picker').setup(),
    config = function()
      require('plugins.config.window-picker').config()
    end,
    dependencies = { 'nvim-tree.lua' }
  },
  {
    'karb94/neoscroll.nvim',
    event = { 'BufReadPost', 'BufWinEnter' },
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
      require('plugins.config.nvim-tree').setup()
    end,
    config = function()
      require('plugins.config.nvim-tree').config()
    end,
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },
  ------------------------------------ VCS -------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    event = { 'FocusLost', 'CursorHold' },
    config = function()
      require('plugins.config.gitsigns').config()
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
      require('plugins.config.firenvim').init()
    end
  },
  {
    'wakatime/vim-wakatime'
  },
  {
    'powerman/vim-plugin-AnsiEsc',
    cmd = 'AnsiEsc',
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
