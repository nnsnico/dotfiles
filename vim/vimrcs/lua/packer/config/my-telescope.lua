local M = {}

M.setup = function()
  ---@param name string
  ---@param opt table?
  ---@return function
  local function builtin(name, opt)
    return function()
      require('telescope.builtin')[name](opt or {})
    end
  end

  vim.keymap.set('n', 'zf',         builtin('find_files'))
  vim.keymap.set('n', '<Leader>zb', builtin('buffers'))
  vim.keymap.set('n', 'zk',         builtin('keymaps'))
  vim.keymap.set('n', 'zl',         builtin('current_buffer_fuzzy_find'))
  vim.keymap.set('n', 'zg',         builtin('git_status'))
  vim.keymap.set('n', 'zr',         builtin('live_grep'))
  vim.keymap.set('n', 'zc',         builtin('colorscheme'))
  vim.keymap.set('n', '<Leader>zc', builtin('commands'))
  vim.keymap.set('n', 'zh',         builtin('help_tags'))
end

M.config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local config = require('telescope.config')

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
