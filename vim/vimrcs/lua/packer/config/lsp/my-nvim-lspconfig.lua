local M = {}
local utils = require('functions.utils')
local lsputils = require('packer.config.lsp.utils')

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

  -- Change default LSP handling to open split automatically

  vim.lsp.handlers['textDocument/definition'] = function(_, results, _)
    if results == nil or utils.is_empty(results) then
      vim.notify('No definition', 'info')
      return
    end

    local qflist = lsputils.map_to_qflist_from_location(results)
    lsputils.handle_qflist(qflist)
  end

  vim.lsp.handlers['textDocument/typeDefinition'] = function(_, results, _)
    if results == nil or utils.is_empty(results) then
      vim.notify('No reference', 'info')
      return
    end

    local qflist = lsputils.map_to_qflist_from_location(results)
    lsputils.handle_qflist(qflist)
  end

  vim.lsp.handlers['textDocument/references'] = function(_, results, _)
    if results == nil or utils.is_empty(results) then
      vim.notify('No reference', 'info')
      return
    end

    local qflist = lsputils.map_to_qflist_from_location(results)
    lsputils.handle_qflist(qflist)
  end

  -- Keymaps

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '[e',         vim.diagnostic.goto_prev,                            opts)
  vim.keymap.set('n', ']e',         vim.diagnostic.goto_next,                            opts)
  vim.keymap.set('n', '<Space>a',   vim.diagnostic.setloclist,                           opts)
  vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,                              opts)
  vim.keymap.set('n', 'gy',         vim.lsp.buf.type_definition,                         opts)
  vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,                          opts)
  vim.keymap.set('n', 'gr',         vim.lsp.buf.references,                              opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,                                  opts)
  vim.keymap.set('n', 'K',          vim.lsp.buf.hover,                                   opts)
  vim.keymap.set('n', '<Space>f',   function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set('n', '<Space>q',   vim.lsp.buf.code_action,                             opts)

  -- auto commands

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
    require('lspconfig')[lsp.name].setup(
      vim.tbl_extend(
        "error",
        {
          on_attach = M.on_attach,
        },
        lsp.setting()
      ))
  end
end

return M
