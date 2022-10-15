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
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = { "lua", "json", "dart" },
          sync_install = false,
          highlight = {
            enable = true,
            disable = { "markdown" },
            additional_vim_regex_highlighting = true,
          },
          rainbow = {
            enable = true,
            extended_mode = true,
          },
          indent = {
            enable = true,
          }
        }
      end,
      requires = {
        'p00f/nvim-ts-rainbow',
        'nvim-treesitter/nvim-treesitter-context',
      }
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
      }
    }

    use {
      'hrsh7th/nvim-cmp',
      config = require('packer.config.my-nvim-cmp').config(),
      requires = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-nvim-lsp',
      }
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = require('packer.config.my-null-ls').config,
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }

    use {
      'akinsho/flutter-tools.nvim',
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
      config = function()
        local metals_config = require('metals').bare_config()
        vim.opt_global.shortmess:remove('F'):append('c')

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
      require = { 'nvim-lua/plenary.nvim' }
    }

    ------------------------------- fuzzy finder -------------------------------

    use {
      'liuchengxu/vim-clap',
      run = ':call clap#installer#download_binary()',
      setup = require('packer.config.clap').setup(),
      requires = {
        { 'kyazdani42/nvim-web-devicons' },
      }
    }

    ----------------------------------- filer ----------------------------------

    use {
      'kyazdani42/nvim-tree.lua',
      setup = require('packer.config.my-nvim-tree').setup(),
      config = require('packer.config.my-nvim-tree').config(),
      requires = {
        { 'kyazdani42/nvim-web-devicons' },
      }
    }

    --------------------------- manipulation utility ---------------------------

    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
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
        vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
      end,
    }
    use {
      'phaazon/hop.nvim',
      tag = 'v2',
      config = function()
        require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
        vim.keymap.set('n', '<Leader>s', require('hop').hint_char1)
      end,
    }
    use 'psliwka/vim-smoothie'
    use {
      'vim-skk/skkeleton',
      setup = require('packer.config.skkeleton').setup(),
      requires = {
        { "vim-denops/denops.vim" }
      }
    }
    use {
      'Shougo/ddc.vim',
      config = require('packer.config.ddc').config(),
      requires = {
        { "vim-denops/denops.vim" },
        { "Shougo/ddc-matcher_head" },
        { "Shougo/ddc-sorter_rank" },
      }
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
      },
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        -- Get the gray without gui attribute from the Comment highlight group.
        local hl_guifg_comment = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg', 'gui')
        local hl_cterm_comment = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg', 'cterm')
        local guifg_comment    = hl_guifg_comment ~= '' and 'guifg=' .. hl_guifg_comment or ''
        local cterm_comment    = hl_cterm_comment ~= '' and 'ctermfg=' .. hl_cterm_comment or ''
        vim.cmd([[highlight! link IndentBlanklineChar Comment]])
        vim.cmd(
          'highlight! IndentBlanklineChar '
          .. 'cterm=NONE '
          .. 'gui=NONE '
          .. guifg_comment .. ' '
          .. cterm_comment
        )
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
      config = require('packer.config.my-wilder').config(),
      requires = { 'romgrk/fzy-lua-native', 'kyazdani42/nvim-web-devicons' },
      rocks = { 'pcre2' },
    }

    use {
      'kevinhwang91/nvim-bqf',
      ft = 'qf',
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

    ----------------------------------- VCS -----------------------------------

    use 'tpope/vim-fugitive'

    use {
      'lewis6991/gitsigns.nvim',
      tag = 'release',
      config = require('packer.config.my-gitsigns').config()
    }
    use {
      'APZelos/blamer.nvim',
      setup = function()
        vim.g.blamer_delay = 100
        vim.keymap.set('n', '<Space>b', ':<C-u>BlamerToggle<CR>', { noremap = true, silent = true })
      end,
    }
    use {
      'rhysd/git-messenger.vim',
      setup = function()
        vim.keymap.set('n', '<Leader>b', '<Plug>(git-messenger)', { silent = true })
      end
    }

    ---------------------------------- Other ----------------------------------

    use {
      'tyru/open-browser.vim',
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
          }
        }
      end
    }

    ----------------------------- syntax highlight -----------------------------

    use { 'rust-lang/rust.vim', ft = 'rust', setup = function() vim.g.rustfmt_autosave = 1 end }
    use { 'neoclide/jsonc.vim', ft = 'jsonc' }
    use { 'HerringtonDarkholme/yats.vim', ft = { 'typescript', 'typescriptreact' } }
    use { 'ollykel/v-vim', ft = 'vlang', setup = function() vim.g.v_autofmt_bufwritepre = 1 end }
    use {
      'plasticboy/vim-markdown',
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
        vim.g.aurora_transparent = 1
        vim.g.aurora_darker      = 1
        vim.cmd([[colorscheme aurora]])
      end
    }

    use 'wakatime/vim-wakatime'

  end)
end

return M
