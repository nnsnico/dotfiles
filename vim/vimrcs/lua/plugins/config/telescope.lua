local M = {}

M.setup = function()
  ---@param name string
  ---@param opt ?table
  ---@return function
  local function builtin(name, opt)
    return function()
      require('telescope.builtin')[name](opt or {})
    end
  end

  return {
    { 'zf',         builtin('find_files'),                mode = 'n' },
    { '<Leader>zb', builtin('buffers'),                   mode = 'n' },
    { 'zk',         builtin('keymaps'),                   mode = 'n' },
    { 'zl',         builtin('current_buffer_fuzzy_find'), mode = 'n' },
    { 'zg',         builtin('git_status'),                mode = 'n' },
    { 'zr',         builtin('live_grep'),                 mode = 'n' },
    { 'zc',         builtin('colorscheme'),               mode = 'n' },
    { '<Leader>zc', builtin('commands'),                  mode = 'n' },
    { 'zh',         builtin('help_tags'),                 mode = 'n' },
  }
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
