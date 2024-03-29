local M = {}

M.config = function()
  require('gitsigns').setup({
    numhl = true,
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

      map({ 'n' }, '<Space>ha', gs.stage_hunk)
      map({ 'v' }, '<Space>ha', function()
        gs.stage_hunk({
          vim.fn.line('.'),
          vim.fn.line('v'),
        })
      end)

      map({ 'n' }, '<Space>hr', gs.reset_hunk)
      map({ 'v' }, '<Space>hr', function()
        gs.reset_hunk({
          vim.fn.line('.'),
          vim.fn.line('v'),
        })
      end)

      map('n', '<Space>hp', gs.preview_hunk)

      map('n', '<Space>g', function()
        if vim.b.gitsigns_status ~= '' then
          vim.cmd('botright Gitsigns setloclist')
        else
          vim.notify('No changed files')
        end
      end, { silent = true })
    end
  })

  vim.api.nvim_set_hl(0, 'GitSignsAddPreview',    { link = 'diffAdded' })
  vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { link = 'diffRemoved' })
end

return M
