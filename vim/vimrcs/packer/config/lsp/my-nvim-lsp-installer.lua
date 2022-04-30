local M = {}

local lsp_installer = require('nvim-lsp-installer')
local lsp_servers = {
  {
    name = "sumneko_lua",
    setting = function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')
      return {
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
      }
    end,
  },
  {
    name = "rust_analyzer",
    setting = function() return {} end,
  }
}

local map = function(fn, ary)
  local tmp = {}
  for i = 1, #ary do
    table.insert(tmp, fn(ary[i]))
  end
  return tmp
end

M.config = function()
  local server_name = map(function(server) return server.name end, lsp_servers)
  lsp_installer.setup({
    ensure_installed = server_name,
    automatic_installation = true,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  })

  -- setup nvim-lspconfig
  require('packer.config.lsp.my-nvim-lspconfig').setup(lsp_servers)
end

return M
