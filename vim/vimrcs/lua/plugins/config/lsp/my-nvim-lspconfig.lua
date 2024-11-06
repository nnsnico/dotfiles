local M = {}
local lsputils = require('plugins.config.lsp.utils')
local const = require('constants')

local is_hover = false


-- Change default LSP handling to open split automatically

---@param results Response
---@param no_result_msg string
local function auto_split(results, no_result_msg)
  if results == nil or vim.tbl_isempty(results) then
    vim.notify(no_result_msg, vim.log.levels.INFO)
    return
  end

  local qflist = lsputils.map_to_qflist_from_location(results)
  lsputils.handle_qflist(qflist)
end

M.on_attach = function(client, bufnr)

  -- diagnostic config

  vim.diagnostic.config({
    virtual_text = false,
    float = {
      border = 'rounded'
    },
    signs = {
      text = {
        [vim.diagnostic.severity.INFO]  = const.diagnostic_icons.info,
        [vim.diagnostic.severity.ERROR] = const.diagnostic_icons.error,
        [vim.diagnostic.severity.WARN]  = const.diagnostic_icons.warn,
        [vim.diagnostic.severity.HINT]  = const.diagnostic_icons.hint,
      }
    },
  })

  -- overrided a handler to jump definition

  local request = client.request
  client.request = function(method, params, handler, req_bufnr)
    if method == 'textDocument/definition' then
      return request(method, params, function(_, result, _, _)
        auto_split(result, 'No definitions')
      end, req_bufnr)
    end

    return request(method, params, handler, req_bufnr)
  end

  local lspconfig = require('lspconfig')
  lspconfig.util.default_config = vim.tbl_extend(
    'force',
    lspconfig.util.default_config,
    ---@type vim.lsp.ClientConfig
    {
      handlers = {
        ---@param results Response
        ['textDocument/typeDefinition'] = function(_, results, _)
          auto_split(results, 'No type definitions')
        end,
        ---@param results Response
        ['textDocument/references'] = function(_, results, _)
          auto_split(results, 'No references')
        end
      },
      capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('lsp-file-operations').default_capabilities()
      )
    }
  )

  -- Keymaps

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,      opts)
  vim.keymap.set('n', 'gy',         vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,  opts)
  vim.keymap.set('n', 'gr',         vim.lsp.buf.references,      opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,          opts)
  vim.keymap.set('n', 'K',          function()
    is_hover = true
    vim.lsp.buf.hover({border = 'rounded'})
  end, opts)
  vim.keymap.set('n', '<Space>f',   function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set('n', '<Space>q',   vim.lsp.buf.code_action,                             opts)
  vim.keymap.set('n', '[e', function()
    vim.diagnostic.jump({ count = -1, float = false })
  end, opts)
  vim.keymap.set('n', ']e', function()
    vim.diagnostic.jump({ count = 1, float = false })
  end, opts)
  vim.keymap.set('n', '<Space>a', function()
    vim.diagnostic.setloclist({ open = false })
    if not vim.tbl_isempty(vim.fn.getloclist(0)) then
      vim.cmd('botright lopen')
    else
      vim.notify('No diagnostics')
    end
  end, opts)

  -- auto commands

  local filetypes = { 'lua', 'dart', 'rust' }

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if vim.tbl_contains(filetypes, vim.o.filetype) then
        vim.lsp.buf.document_highlight()
      end
    end
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if vim.tbl_contains(filetypes, vim.o.filetype) then
        vim.lsp.buf.clear_references()
      end
    end
  })

  -- toggle hide/show diagnostic window by is_hover flag

  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if is_hover then
        is_hover = false
      end
    end
  })
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if is_hover then
        vim.diagnostic.hide(nil, 0)
      else
        vim.diagnostic.show(nil, 0, nil, nil)
        vim.diagnostic.open_float({ focus = false })
      end
    end
  })

  -- Enable nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
end

M.attach_lsp = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      M.on_attach(client, bufnr)
    end
  })
end

---@param lsps LspConf.Configuration[]
M.setup = function(lsps)
  for _, lsp in pairs(lsps) do
    local setting = lsp.setting or function() return {} end
    require('lspconfig')[lsp.name].setup(setting())
  end
end

return M
