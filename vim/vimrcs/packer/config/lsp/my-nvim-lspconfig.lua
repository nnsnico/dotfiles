local M = {}

local on_attach = function(_, bufnr)
  vim.o.signcolumn = 'yes:2'

  -- Change diagnostic icons
  local signs = {
    Error = '\u{F1E2}',
    Warn  = '\u{E230}',
    Hint  = '\u{F270}',
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "[e",         "<cmd>lua vim.diagnostic.goto_prev()<CR>",    opts)
  buf_set_keymap("n", "]e",         "<cmd>lua vim.diagnostic.goto_next()<CR>",    opts)
  -- TODO action fix tool like 'CocFix'
  -- TODO action selected like 'coc-codeaction-selected'
  buf_set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",      opts)
  buf_set_keymap("n", "gy",         "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>",  opts)
  buf_set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",      opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",          opts)
  buf_set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",           opts)
  buf_set_keymap("n", "<Space>f",   "<cmd>lua vim.lsp.buf.formatting()<CR>",      opts)
  buf_set_keymap("n", "<Space>a",   "<cmd>lua vim.diagnostic.setloclist()<CR>",   opts)
end

M.setup = function(lsps)
  for _, lsp in pairs(lsps) do
    require('lspconfig')[lsp.name].setup {
      on_attach = on_attach,
      settings = lsp.setting(),
    }
  end
end

return M
