local M = {}
local utils = require('luafunction.utils')
local auto_window_splitter = require('luafunction.auto-window-splitter')
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

  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  -- Change definition handling to open split automatically
  vim.lsp.handlers["textDocument/definition"] = function(_, results, _)
    if results == nil or utils.is_empty(results) then
      vim.notify('No definition', 'info')
      return
    end
    local qflist = lsputils.map_to_qflist(results)

    if #qflist == 1 then
      if qflist[1].filename == utils.get_current_filename() then
        auto_window_splitter.move_cursor(0, qflist[1].lnum, qflist[1].col)
      else
        local jumpable_windows = auto_window_splitter.get_jumpable_windows(qflist[1].filename)
        if not utils.is_empty(jumpable_windows) then
          for _, v in pairs(jumpable_windows) do
            vim.fn.win_gotoid(v.winid)
              auto_window_splitter.move_cursor(v.winid, qflist[1].lnum, qflist[1].col)
            return
          end
        else
          auto_window_splitter.auto_split(qflist[1].filename)
          auto_window_splitter.move_cursor(0, qflist[1].lnum, qflist[1].col)
        end
      end
    else
      vim.fn.setqflist(qflist)
      vim.cmd('copen')
    end
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
