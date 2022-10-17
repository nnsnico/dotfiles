local M = {}

M.config = function()
  local tools = require('packer.config.lsp.my-nvim-lsp-installer').tools

  local sources = {}
  for _, tool in ipairs(tools) do
    for k, fn in ipairs(tool.setup) do
      local fn_name = 'require("null-ls").builtins.' .. fn .. '.' .. tool.name
      if tool.configuration then
        fn_name = fn_name .. '.with(' .. vim.inspect(tool.configuration) .. ')'
      end
      table.insert(sources, k, load('return ' .. fn_name)())
    end
  end

  require('null-ls').setup({
    sources = sources,
    on_attach = require('packer.config.lsp.my-nvim-lspconfig').on_attach,
  })
end

return M
