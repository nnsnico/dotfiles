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

---@alias setup.Function 'code_actions' | 'completion' | 'diagnostics' | 'formatting' | 'hover'
---@type { name: string, setup: setup.Function[], configuration?: table }[]
M.tools = {
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
  local tool_name = vim.fn.map(M.tools, function(_, tool) return tool.name end)

  require('mason').setup()

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
