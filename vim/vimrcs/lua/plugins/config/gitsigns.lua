local M = {}

M.config = function()
  require('gitsigns').setup({
    numhl = true,
    preview_config = {
      border = 'rounded',
    },
    on_attach = function(bufnr)
      local gs = require('gitsigns')

      ---@param mode string|string[]
      ---@param l string
      ---@param r string|function
      ---@param opts vim.keymap.set.Opts?
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          gs.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          gs.nav_hunk('prev')
        end
      end)

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

  vim.api.nvim_set_hl(0, 'GitSignsAddPreview', { link = 'diffAdded' })
  vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { link = 'diffRemoved' })
end

return M
