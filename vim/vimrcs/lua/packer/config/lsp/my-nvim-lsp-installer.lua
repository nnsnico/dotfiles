local M = {}

local lsp_servers = {
  {
    name = "sumneko_lua",
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

M.linters = {
  {
    name = 'textlint',
    setup = { 'diagnostics', 'formatting' },
    configuration = {
      filetypes = { 'markdown', 'text' }
    }
  },
  {
    name = 'shellcheck',
    setup = { 'code_actions', 'diagnostics' },
    configuration = {
      filetypes = { 'sh' }
    }
  },
}

M.config = function()
  local server_name = vim.fn.map(lsp_servers, function(_, server) return server.name end)
  local linter_name = vim.fn.map(M.linters, function(_, linter) return linter.name end)
  local install_list = vim.list_extend(server_name, linter_name)

  require('mason').setup()
  require('mason-lspconfig').setup({
    ensure_installed = install_list,
    automatic_installation = true,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  })

  -- setup nvim-lspconfig
  require('packer.config.lsp.my-nvim-lspconfig').setup(lsp_servers)
end

return M
