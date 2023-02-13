local M = {}

local lsp_servers = {
  {
    name = "lua_ls",
    setting = function()
      local runtime_path = vim.split(package.path, ';', {})
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')
      return {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = runtime_path,
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
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
  },
  {
    name = 'vimls',
  }
}

---@class NullLs.Configuration
---@field source NullLs.Source
---@field config ?table

---@alias NullLs.Source 'code_actions' | 'completion' | 'diagnostics' | 'formatting' | 'hover'

---@type { name: string, setup: NullLs.Configuration[] }[]
M.tools = {
  {
    name = 'textlint',
    setup = {
      {
        source = 'diagnostics',
        config = {
          filetypes = { 'markdown', 'text' },
          extra_args = { '-c', vim.fn.expand('~/dotfiles/.textlintrc.json') },
          method = require('null-ls').methods.DIAGNOSTICS_ON_SAVE,
        }
      },
      {
        source = 'formatting',
        config = {
          filetypes = { 'markdown', 'text' },
          extra_args = { '-c', vim.fn.expand('~/dotfiles/.textlintrc.json') },
        },
      },
    },
  },
  {
    name = 'shellcheck',
    setup = {
      { source = 'code_actions', config = { filetypes = { 'sh' } } },
      { source = 'diagnostics', config = { filetypes = { 'sh' } } }
    },
  },
}

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
  require('packer.config.lsp.my-nvim-lspconfig').setup(lsp_servers)
end

return M
