local M = {}

M.on_attach = function(_, bufnr)
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

  -- Change definition handling to open split automatically
  vim.lsp.handlers["textDocument/definition"] = function(_, results, _)
    require('luafunction.auto-window-splitter').auto_split_for_builtinlsp(results)
  end

  buf_set_keymap("n", "<Space>w", ":call v:lua.definition()<CR>", opts)

  buf_set_keymap("n", "[e",         "<cmd>lua vim.diagnostic.goto_prev()<CR>",                  opts)
  buf_set_keymap("n", "]e",         "<cmd>lua vim.diagnostic.goto_next()<CR>",                  opts)
  buf_set_keymap("n", "<Space>q",   "<cmd>lua vim.lsp.buf.code_action()<CR>",                   opts)
  buf_set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition({ reusewin = true })<CR>", opts)
  buf_set_keymap("n", "gy",         "<cmd>lua vim.lsp.buf.type_definition()<CR>",               opts)
  buf_set_keymap("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>",                opts)
  buf_set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",                    opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",                        opts)
  buf_set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",                         opts)
  buf_set_keymap("n", "<Space>f",   "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",        opts)
  buf_set_keymap("n", "<Space>a",   "<cmd>lua vim.diagnostic.setloclist()<CR>",                 opts)

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.lsp.buf.document_highlight()
    end
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      vim.lsp.buf.clear_references()
    end
  })

end

M.setup = function(lsps)
  for _, lsp in pairs(lsps) do
    require('lspconfig')[lsp.name].setup {
      on_attach = M.on_attach,
      settings = lsp.setting(),
    }
  end
end

return M
