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
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        config = function()
          require('plugins.config.treesitter.textobject').config()
        end,
      },
      'JoosepAlviste/nvim-ts-context-commentstring',
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
      {
        'numToStr/Comment.nvim',
        config = function()
          require('Comment').setup()
        end,
        lazy = false,
      },
    }
  },
  -------------------------------- fuzzy finder --------------------------------
  {
    'nvim-telescope/telescope.nvim',
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
    ft = require('plugins.config.lsp.my-nvim-lsp-installer').filetypes,
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
        'antosha417/nvim-lsp-file-operations',
        config = function()
          require('lsp-file-operations').setup()
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      {
        'nvimtools/none-ls.nvim',
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
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
      { '<leader>h', '<cmd>OutlineFocus<CR>' },
    },
    opts = {}
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
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart',
    config = function()
      local lspconfig = require('plugins.config.lsp.my-nvim-lspconfig')

      lspconfig.attach_lsp()

      vim.keymap.set('n', '<Space>o', '<cmd>FlutterOutlineToggle<CR>', { silent = true })

      require('flutter-tools').setup({
        fvm = true,
        widget_guides = {
          enabled = true,
        },
        lsp = {
          on_attach = lspconfig.on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities,
        }
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'scalameta/nvim-metals',
    ft = 'scala',
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

      vim.keymap.set('n', '<Space>i', '<Cmd>MetalsOrganizeImports<CR>')
    end,
    dependencies = {
      {
        'antosha417/nvim-lsp-file-operations',
        config = function()
          require('lsp-file-operations').setup()
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      'nvim-lua/plenary.nvim',
      'hrsh7th/cmp-nvim-lsp',
    }
  },
  ------------------------------- visual utility -------------------------------
  {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    config = function()
      require('nvim-web-devicons').setup({
        override_by_extension = {
          v = {
            icon = '',
            name = 'vlang'
          }
        }
      })
    end,
  },
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
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        window = {
          winblend = vim.o.winblend,
        },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    keys = function()
      local todo_comments = require('todo-comments')
      return {
        {
          ']t', function()
          todo_comments.jump_next()
        end,
          { desc = 'Next todo comment' }
        },
        {
          '[t', function()
          todo_comments.jump_prev()
        end,
          { desc = 'Previous todo comment' }
        }
      }
    end,
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
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
        ft_ignore = { 'NvimTree', 'aerial', 'Outline' },
        bt_ignore = { 'help', 'terminal', 'quickfix' },
        segments = {
          {
            sign = {
              namespace = { 'diagnostic' },
              maxwidth  = 2,
            },
            click = 'v:lua.ScSa',
          },
          {
            text = { builtin.lnumfunc, ' ' },
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
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      plugins = {
        tmux = {
          enabled = true,
        },
        wezterm = {
          enabled = true,
        }
      }
    },
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
    'smoka7/hop.nvim',
    version = '*',
    keys = { '<Leader>s' },
    config = function()
      local hop = require('hop')
      hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
      vim.keymap.set('n', '<Leader>s', hop.hint_patterns)
    end,
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
        easing_function = 'circular',
        hide_cursor = false,
      })
    end
  },
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>',  '<Plug>(dial-increment)',  mode = { 'n', 'v' }, noremap = false },
      { '<C-x>',  '<Plug>(dial-decrement)',  mode = { 'n', 'v' }, noremap = false },
      { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, noremap = false },
      { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, noremap = false },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.misc.alias.markdown_header,
          augend.constant.new({
            elements = { '[ ]', '[x]' },
            word = false,
            cyclic = true,
          }),
        }
      })
    end,
  },
  ----------------------------------- filer ------------------------------------
  {
    'nvim-tree/nvim-tree.lua',
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
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      {
        'antosha417/nvim-lsp-file-operations',
        config = function()
          require('lsp-file-operations').setup()
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
      }
    },
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
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local term = require('toggleterm.terminal').Terminal
      local tig = term:new({
        cmd = 'tig',
        hidden = true,
        direction = 'float',
        float_opts = {
          border = 'rounded',
        },
      })

      local function toggle_tig()
        tig:toggle()
      end

      vim.keymap.set('n', '<Leader>g', toggle_tig, { noremap = true, silent = true })
    end,
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
    'potamides/pantran.nvim',
    keys = function()
      local pantran = require('pantran')
      return {
        {
          '<Leader>t',
          pantran.motion_translate,
          mode = { 'n', 'x' },
          noremap = true,
          silent = true,
          expr = true,
        },
      }
    end,
    config = function()
      require('pantran').setup({
        default_engine = 'google',
        engines = {
          google = {
            fallback = {
              default_target = 'ja',
            }
          },
        },
      })
    end,
  },
  {
    'vim-skk/skkeleton',
    init = function()
      require('plugins.config.skkeleton').setup()
    end,
    dependencies = {
      { "vim-denops/denops.vim" },
      {
        "delphinus/skkeleton_indicator.nvim",
        config = function()
          require('skkeleton_indicator').setup({
            zindex = 9999,
          })
        end
      },
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
    'tadmccorkle/markdown.nvim',
    ft = 'markdown',
    config = function()
      require('plugins.config.treesitter.markdown').config()
    end,
  },
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    init = function()
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_folding_disabled        = 1
      vim.g.vim_markdown_conceal                 = 0
      vim.g.vim_markdown_code_blocks             = 0
    end,
    dependencies = {
      {
        'godlygeek/tabular',
        config = function()
          vim.keymap.set('n', '<Space>@', '<Cmd>TableFormat<CR>', { silent = true, buffer = true })
        end,
      },
    }
  },
  {
    'toppair/peek.nvim',
    event = 'VeryLazy',
    build = 'deno task --quiet build:fast',
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -------------------------------- color scheme --------------------------------
  {
    'ray-x/aurora',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.aurora_italic      = 1
      vim.g.aurora_bold        = 1
      vim.g.aurora_darker      = 1
      vim.g.aurora_transparent = 1

      -- Markdown heading
      -- Purple
      vim.api.nvim_set_hl(0, '@markup.heading.1', { link = 'Title' })
      -- Yellow
      vim.api.nvim_set_hl(0, '@markup.heading.2', { link = 'TSDefinitionUsage' })
      -- Cyan
      vim.api.nvim_set_hl(0, '@markup.heading.3', { link = '@function.builtin' })
      -- Green
      vim.api.nvim_set_hl(0, '@markup.heading.4', { link = 'diffAdded' })
      -- Red
      vim.api.nvim_set_hl(0, '@markup.heading.5', { link = 'markdownHeadingRule' })
      -- Orange
      vim.api.nvim_set_hl(0, '@markup.heading.6', { link = 'sqlKeyword' })

      vim.cmd([[colorscheme aurora]])
    end
  }
}, {
    ui = {
      border = 'rounded'
    }
})
