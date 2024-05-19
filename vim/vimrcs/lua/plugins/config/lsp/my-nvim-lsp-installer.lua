local M = {}

---@class LspConf.Configuration
---@field name string
---@field ft string | string[]
---@field setting ?function

---@type LspConf.Configuration[]
local lsp_servers = {
  {
    name = "lua_ls",
    ft = 'lua',
    setting = function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')

      local library = {}
      local function add(lib)
        for _, p in pairs(vim.fn.expand(lib, false, true)) do
          p = vim.uv.fs_realpath(p)
          library[p] = true
        end
      end

      add("$VIMRUNTIME")
      add("~/dotfiles/vim/vimrcs") -- specify dotfile path
      add(vim.fn.stdpath('data') .. '/lazy/*') -- specify the package path

      return {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = runtime_path,
            },
            completion = { callSnippet = "Both" },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = library,
              maxPreload = 2000,
              preloadFileSize = 50000,
            },
            telemetry = {
              enable = false,
            }
          },
        },
      }
    end,
  },
  {
    name = "rust_analyzer",
    ft = 'rust',
    setting = function()
      return {
        settings = {
          ['rust-analyzer'] = {
            imports = {
              granularity = {
                group = 'module',
              },
              prefix = 'self',
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
            checkOnSave = true,
            check = {
              command = 'clippy',
              extraArgs = {
                '--',
                '-W',
                'clippy::pedantic'
              },
            },
          }
        }
      }
    end
  },
  {
    name = 'v_analyzer',
    ft = 'vlang',
    setting = function()
      local zinit_path = vim.fn.environ()['ZPFX'] or ''
      return {
        cmd = { zinit_path .. '/bin/v-analyzer' },
        filetypes = { 'v', 'vsh', 'vv', 'vlang' },
      }
    end
  },
  {
    name = 'vimls',
    ft = 'vim',
  },
  {
    name = 'bashls',
    ft = { 'bash', 'zsh' },
  },
}

---@class NullLsConf.Configuration
---@field source 'code_actions' | 'completion' | 'diagnostics' | 'formatting' | 'hover'
---@field config function?

---@class ToolConf.Configuration
---@field name string
---@field ft string | string[]
---@field setup NullLsConf.Configuration[]

---@type ToolConf.Configuration[]
M.tools = {
  {
    name = 'textlint',
    ft = { 'markdown', 'text' },
    setup = {
      {
        source = 'diagnostics',
        config = function()
          return {
            filetypes = { 'markdown', 'text' },
            extra_args = { '-c', vim.fn.expand('~/dotfiles/.textlintrc.json') },
            method = require('null-ls').methods.DIAGNOSTICS_ON_SAVE,
          }
        end
      },
      {
        source = 'formatting',
        config = function()
          return {
            filetypes = { 'markdown', 'text' },
            extra_args = { '-c', vim.fn.expand('~/dotfiles/.textlintrc.json') },
          }
        end,
      },
    },
  },
  {
    name = 'shfmt',
    ft = { 'sh', 'bash' },
    setup = {
      {
        source = 'formatting',
        config = function()
          return { filetypes = { 'sh', 'bash' } }
        end,
      },
    },
  },
}

---@return string[]
M.filetypes = function()
  ---@param server LspConf.Configuration
  ---@type string[]
  local lsp_ft = vim.tbl_map(function(server) return server.ft end, lsp_servers)
  ---@param tool ToolConf.Configuration
  ---@type string[]
  local tool_ft = vim.tbl_map(function (tool) return tool.ft end, M.tools)
  local extended = vim.iter(vim.list_extend(lsp_ft, tool_ft)):flatten():totable()
  local set = {}
  for i, _ in ipairs(extended) do
    if not vim.tbl_contains(set, extended[i]) then
      table.insert(set, extended[i])
    end
  end
  return set
end

M.config = function()
  local server_name = vim.fn.map(lsp_servers, function(_, server) return server.name end)
  local tool_name = vim.fn.map(M.tools, function(_, tool) return tool.name end)

  require('mason').setup({
    ui = {
      border = 'rounded'
    }
  })

  -- for language server
  require('mason-lspconfig').setup({
    ensure_installed = server_name,
    automatic_installation = true,
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  })

  -- for linter
  require('mason-tool-installer').setup({
    ensure_installed = tool_name,
  })

  -- setup nvim-lspconfig
  local lspconfig = require('plugins.config.lsp.my-nvim-lspconfig')
  lspconfig.setup(lsp_servers)
  lspconfig.attach_lsp()
end

return M
