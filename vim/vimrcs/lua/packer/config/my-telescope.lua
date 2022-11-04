local M = {}

local telescope = require('telescope')
local actions = require('telescope.actions')
local config = require('telescope.config')

M.setup = function()
  vim.keymap.set('n', 'zf',         ':<C-u>Telescope find_files<CR>',                { noremap = true })
  vim.keymap.set('n', 'zb',         ':<C-u>Telescope buffers<CR>',                   { noremap = true })
  vim.keymap.set('n', 'zl',         ':<C-u>Telescope current_buffer_fuzzy_find<CR>', { noremap = true })
  vim.keymap.set('n', 'zg',         ':<C-u>Telescope git_status<CR>',                { noremap = true })
  vim.keymap.set('n', 'zr',         ':<C-u>Telescope live_grep<CR>',                 { noremap = true })
  vim.keymap.set('n', 'zc',         ':<C-u>Telescope colorscheme<CR>',               { noremap = true })
  vim.keymap.set('n', '<Leader>zc', ':<C-u>Telescope commands<CR>',                  { noremap = true })
  vim.keymap.set('n', 'zh',         ':<C-u>Telescope help_tags<CR>',                 { noremap = true })
end

M.config = function()
  local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
  table.insert(vimgrep_arguments, '--hidden')
  table.insert(vimgrep_arguments, '--glob')
  table.insert(vimgrep_arguments, '!.git/*')

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-u>'] = false,
        },
        n = {
          ['<Esc><Esc>'] = actions.close,
          ['<C-g>'] = actions.close,
        },
      },
      vimgrep_arguments = vimgrep_arguments,
      winblend = vim.o.winblend,
      prompt_prefix = '',
      selection_caret = '\u{F0A4} ',
      multi_icon = '\u{F058} ',
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      }
    },
  })
  telescope.load_extension('fzf')
end

return M
