local M = {}

M.config = function()
  local linters = require('packer.config.lsp.my-nvim-lsp-installer').linters

  local sources = {}
  for _, linter in ipairs(linters) do
    for k, fn in ipairs(linter.setup) do
      local fn_name = 'require("null-ls").builtins.' .. fn .. '.' .. linter.name
      if linter.configuration then
        fn_name = fn_name .. '.with(' .. vim.inspect(linter.configuration) .. ')'
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
