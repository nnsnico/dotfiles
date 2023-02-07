local M = {}

function M.setup()
  vim.keymap.set(
      'n',
      '<Leader>w',
      function()
        local win_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(win_id)
      end,
      { desc = 'Pick a window' }
  )
end

function M.config()
  -- synchronizes background color with nvim-tree.lua
  local background_color = vim.api.nvim_exec([[echo synIDattr(synIDtrans(hlID('NvimTreeWindowPicker')), 'bg')]], true)
  require('window-picker').setup({
      include_current_win = true,
      selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      other_win_hl_color = background_color,
      use_winbar = 'never',
      show_prompt = false,
      filter_rules = {
          bo = {
              filetype = { 'NvimTree', 'notify', 'qf' },
              buftype = { 'terminal' },
          },
      },
  })
end

return M
