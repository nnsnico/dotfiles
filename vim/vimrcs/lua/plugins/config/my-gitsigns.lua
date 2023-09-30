local M = {}

M.config = function()
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      map({ 'n', 'v' }, '<Space>ha', ':Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<Space>hr', ':Gitsigns reset_hunk<CR>')
      map('n',          '<Space>hp', gs.preview_hunk)

      map('n', '<Space>g', '<Cmd>Gitsigns setqflist<CR>', { silent = true })
    end
  })

  vim.api.nvim_set_hl(0, 'GitSignsAddPreview',    { link = 'diffAdded' })
  vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { link = 'diffRemoved' })
end

return M
