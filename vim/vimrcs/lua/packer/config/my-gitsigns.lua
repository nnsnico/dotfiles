local M = {}

M.config = function()
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end

      map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
      map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

      map('n', '<Space>ha', ':Gitsigns stage_hunk<CR>')
      map('v', '<Space>ha', ':Gitsigns stage_hunk<CR>')
      map('n', '<Space>hr', ':Gitsigns reset_hunk<CR>')
      map('v', '<Space>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<Space>hp', '<cmd>Gitsigns preview_hunk<CR>')

    end
  })
end

return M
