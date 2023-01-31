vim.cmd([[packadd packer.nvim]])

if vim.fn.has('mac') then
  -- @see: https://github.com/wbthomason/packer.nvim/issues/180
  vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
end

local packer = require('packer')
packer.init()

local augroup = vim.api.nvim_create_augroup('packer_user_config', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = 'plugins.lua',
  callback = function(args)
    vim.cmd(string.format('source %s | PackerCompile', args.file))
  end,
})

local M = {}
local utils = require('functions.utils')

M.startup = function()
  return require('packer').startup(function(use)

    ----------------------------------- Basic ----------------------------------

    use 'wbthomason/packer.nvim'
    use 'vim-jp/vital.vim'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufReadPost',
      opt = true,
      config = function()
        require('packer.config.my-treesitter').config()
      end,
      requires = {
        'mrjones2014/nvim-ts-rainbow',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
      }
    }

    use {
      'mrjones2014/nvim-ts-rainbow',
      opt = true,
      after = 'nvim-treesitter'
    }

    use {
      'nvim-treesitter/nvim-treesitter-context',
      opt = true,
      config = function()
        require('treesitter-context').setup({
          enable = true
        })
      end,
      after = 'nvim-treesitter'
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      opt = true,
      after = 'nvim-treesitter',
    }

    -------------------------------- LSP/Linter --------------------------------

    use {
      'williamboman/mason.nvim',
      config = utils.call_safe(require('packer.config.lsp.my-nvim-lsp-installer').config),
      requires = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'neovim/nvim-lspconfig',
        'ii14/emmylua-nvim',
        'SmiteshP/nvim-navic',
        'hrsh7th/cmp-nvim-lsp',
      },
    }

    use {
      'hrsh7th/nvim-cmp',
      module = { 'cmp' },
      requires = {
        { 'L3MON4D3/LuaSnip' },
        { 'hrsh7th/cmp-buffer',     event = { 'InsertEnter' } },
        { 'hrsh7th/cmp-path',       event = { 'InsertEnter' } },
        { 'f3fora/cmp-spell',       event = { 'InsertEnter' } },
        { 'hrsh7th/cmp-emoji',      event = { 'InsertEnter' } },
        { 'hrsh7th/cmp-nvim-lsp',   event = { 'InsertEnter' } },
        { 'uga-rosa/cmp-skkeleton', event = { 'InsertEnter' }, wants = { 'skkeleton' } }
      },
      wants = { 'nvim-autopairs' },
      config = function()
        require('packer.config.my-nvim-cmp').config()
      end,
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = require('packer.config.my-null-ls').config,
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }

    use {
      'stevearc/aerial.nvim',
      cmd = 'AerialToggle',
      setup = function()
        vim.keymap.set('n', '<Space>s', '<cmd>AerialToggle!<CR>', {})
      end,
      config = function()
        require('aerial').setup()
      end
    }

    use {
      'akinsho/flutter-tools.nvim',
      ft = 'dart',
      config = function()
        local on_attach = require('packer.config.lsp.my-nvim-lspconfig').on_attach
        require('flutter-tools').setup({
          fvm = true,
          widget_guides = {
            enabled = true,
          },
          lsp = {
            on_attach = on_attach,
          }
        })
      end,
      setup = function()
        vim.keymap.set('n', '<Space>o', ':<C-u>FlutterOutlineToggle<CR>', { noremap = true, silent = true })
      end,
      requires = {
        'nvim-lua/plenary.nvim',
      },
    }

    use {
      'scalameta/nvim-metals',
      ft = { 'scala', 'sbt' },
      config = function()
        local metals_config = require('metals').bare_config()

        metals_config.settings = {
          showImplicitArguments = true,
          excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' }
        }

        metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
        metals_config.on_attach = require('packer.config.lsp.my-nvim-lspconfig').on_attach

        local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
          pattern = { 'scala', 'sbt', 'java' },
          callback = function()
            require('metals').initialize_or_attach(metals_config)
          end,
          group = nvim_metals_group
        })
      end,
      require = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/cmp-nvim-lsp',
      }
    }

    ------------------------------- fuzzy finder -------------------------------

    use {
      'nvim-telescope/telescope.nvim',
      module = { 'telescope' },
      branch = '0.1.x',
      setup = function()
        require('packer.config.my-telescope').setup()
      end,
      config = function()
        require('packer.config.my-telescope').config()
      end,
      requires = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'kyazdani42/nvim-web-devicons',
      }
    }

    ----------------------------------- filer ----------------------------------

    use {
      'kyazdani42/nvim-tree.lua',
      cmd = {
        'NvimTreeOpen',
        'NvimTreeToggle',
        'NvimTreeFindFile',
        'NvimTreeRefresh',
      },
      opt = true,
      setup = function()
        require('packer.config.my-nvim-tree').setup()
      end,
      config = function()
        require('packer.config.my-nvim-tree').config()
      end,
      requires = {
        { 'kyazdani42/nvim-web-devicons', opt = true },
      }
    }

    --------------------------- manipulation utility ---------------------------

    use {
      'windwp/nvim-autopairs',
      event = { 'InsertEnter' },
      config = function()
        require('nvim-autopairs').setup()
      end,
    }

    use {
      'tpope/vim-commentary',
      keys = {
        { 'n', 'gc' },
        { 'n', 'gcc' },
        { 'n', 'gcu' },
        { 'x', 'gc' },
        { 'o', 'gc' },
      }
    }

    use 'tpope/vim-repeat'

    use {
      'tpope/vim-surround',
      setup = function()
        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'lua',
          callback = function ()
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
    }

    use {
      'mg979/vim-visual-multi',
      keys = {
        { 'n', '<C-n>' },
        { 'v', '<C-n>' },
        { 'n', '\\A' },
        { 'v', '\\A' },
        { 'n', '\\c' },
        { 'v', '\\c' },
        { 'n', '\\/' },
      }
    }

    use {
      'junegunn/vim-easy-align',
      keys = { '<Plug>(EasyAlign)' },
      setup = function()
        vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)', {})
      end,
    }
    use {
      'phaazon/hop.nvim',
      tag = 'v2',
      keys = { { 'n', '<Leader>s' } },
      config = function()
        require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
        vim.keymap.set('n', '<Leader>s', require('hop').hint_char1, {})
      end,
    }

    use {
      'karb94/neoscroll.nvim',
      event = { 'BufReadPost' },
      opt = true,
      config = function()
        require('neoscroll').setup({
          mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zz', 'zt', 'zb' },
          easing_function = 'circular'
        })
      end
    }

    use {
      'vim-skk/skkeleton',
      setup = require('packer.config.skkeleton').setup(),
      requires = {
        { "vim-denops/denops.vim" }
      },
    }

    use {
      'AndrewRadev/tagalong.vim',
      ft = { 'html', 'javascriptreact', 'jsx', 'php', 'typescriptreact', 'xml', 'markdown' },
      setup = function()
        vim.g.tagalong_additional_filetypes = { 'markdown' }
      end
    }

    ------------------------------ visual utility ------------------------------

    use {
      'rebelot/heirline.nvim',
      config = utils.call_safe(require('packer.config.heirline.my-heirline').config),
      requires = {
        { 'kyazdani42/nvim-web-devicons', opt = 1 },
        { 'vim-skk/skkeleton' },
        { 'SmiteshP/nvim-navic' },
      },
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufReadPost' },
      opt = true,
      config = function()
        vim.g.indent_blankline_char_list = { '|', '¦' }
        vim.g.indent_blankline_use_treesitter = true

        require('indent_blankline').setup {
          space_char_blankline       = " ",
          show_current_context       = true,
          show_current_context_start = true,
        }
      end
    }
    use {
      'gelguy/wilder.nvim',
      opt = true,
      event = 'CmdlineEnter',
      config = function()
        require('packer.config.my-wilder').config()
      end,
      requires = { 'romgrk/fzy-lua-native', 'kyazdani42/nvim-web-devicons' },
      rocks = { 'pcre2' },
    }

    use {
      'kevinhwang91/nvim-bqf',
      ft = 'qf',
      config = function()
        require('packer.config.my-nvim-bqf').config()
      end,
      setup = function()
        require('packer.config.my-nvim-bqf').setup()
      end,
      requires = {
        {
          'junegunn/fzf',
          run = function()
            vim.fn['fzf#install']()
          end,
        },
      }
    }

    use {
      'rcarriga/nvim-notify',
      config = require('packer.config.my-nvim-notify').config()
    }

    use {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup({
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
          }
        })
      end
    }

    ----------------------------------- VCS -----------------------------------

    use {
      'tpope/vim-fugitive',
      opt = true,
      cmd = { 'Git', 'G' },
    }

    use {
      'lewis6991/gitsigns.nvim',
      event = { 'FocusLost', 'CursorHold' },
      tag = 'release',
      config = function()
        require('packer.config.my-gitsigns').config()
      end,
    }
    use {
      'APZelos/blamer.nvim',
      cmd = 'BlamerToggle',
      setup = function()
        vim.g.blamer_date_format = '%Y/%m/%d %H:%M'
        vim.g.blamer_delay = 100
        vim.keymap.set('n', '<Space>b', ':<C-u>BlamerToggle<CR>', { noremap = true, silent = true })
      end,
    }
    use {
      'rhysd/git-messenger.vim',
      keys = { '<Plug>(git-messenger)' },
      setup = function()
        vim.keymap.set('n', '<Leader>b', '<Plug>(git-messenger)', { silent = true })
      end
    }

    use {
      'iberianpig/tig-explorer.vim',
      cmd = 'Tig*',
      setup = function()
        vim.keymap.set('n', '<Leader>g', function() vim.cmd('TigOpenProjectRootDir') end)
      end,
      requires = {
        'rbgrouleff/bclose.vim', cmd = 'Bclose', wants = 'tig-explorer.vim'
      }
    }

    ---------------------------------- Other ----------------------------------

    use {
      'tyru/open-browser.vim',
      keys = { '<Plug>(openbrowser-open)' },
      cmd = { 'OpenBrowser*' },
      setup = function()
        vim.keymap.set('v', '<Leader>o', '<Plug>(openbrowser-open)')
      end,
    }
    use {
      'iamcco/markdown-preview.nvim',
      ft = { 'markdown' },
      run = ':call mkdp#util#install()',
    }
    use 'editorconfig/editorconfig-vim'
    use {
      'voldikss/vim-translator',
      keys = { { 'n', '<Plug>Translate' }, { 'v', '<Plug>Translate' } },
      cmd = { 'Translate*' },
      setup = function()
        vim.g.translator_target_lang = 'ja'
        vim.g.translator_source_lang = 'en'
        vim.keymap.set('n', '<Leader>t', '<Plug>TranslateW', { silent = true })
        vim.keymap.set('v', '<Leader>t', '<Plug>TranslateWV', { silent = true })
      end,
    }
    use {
      'nnsnico/sepcomment.vim',
      cmd = 'SepComment',
      setup = function() vim.g['sepcomment#length'] = 78 end
    }
    use {
      'glacambre/firenvim',
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
            ['https://perf\\.hrmos\\.co/'] = {
              content  = 'html',
              priority = 1,
              selector = 'div[class="ql-editor"]',
              takeover = 'always',
            },
            ['https://.*\\.notion\\.so'] = {
              takeover = 'never',
              priority = 1,
            }
          }
        }
      end
    }

    ----------------------------- syntax highlight -----------------------------

    use {
      'rust-lang/rust.vim',
      opt = true,
      ft = 'rust',
      setup = function() vim.g.rustfmt_autosave = 1 end
    }

    use {
      'neoclide/jsonc.vim',
      opt = true,
      ft = 'jsonc',
    }

    use {
      'HerringtonDarkholme/yats.vim',
      opt = true,
      ft = { 'typescript', 'typescriptreact' },
    }

    use {
      'ollykel/v-vim',
      opt = true,
      ft = 'vlang',
      setup = function() vim.g.v_autofmt_bufwritepre = 0 end,
    }

    use {
      'plasticboy/vim-markdown',
      opt = true,
      ft = 'markdown',
      setup = function()
        vim.g.vim_markdown_no_default_key_mappings = 1
        vim.g.vim_markdown_folding_disabled        = 1
        vim.g.vim_markdown_conceal                 = 0
        vim.g.vim_markdown_conceal_code_blocks     = 0
      end
    }

    use {
      'godlygeek/tabular',
      opt = true,
      ft = { 'markdown' },
      setup = function()
        vim.keymap.set('n', '<Space>@', ':TableFormat<CR>', { noremap = true, silent = true })
      end
    }

    use {
      'ray-x/aurora',
      config = function()
        vim.g.aurora_italic      = 1
        vim.g.aurora_bold        = 1
        vim.g.aurora_darker      = 1
        vim.cmd([[colorscheme aurora]])
      end
    }

    use 'wakatime/vim-wakatime'

  end)
end

return M
