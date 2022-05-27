local clap = {}

clap.setup = function()
  vim.g.clap_current_selection_sign = {
    text   = '\u{F0A4}',
    texthl = "WarningMsg",
    linehl = "ClapCurrentSelection"
  }
  vim.g.clap_enable_icon = 1
  vim.g.clap_layout = {
    relative = 'editor'
  }
  vim.g.clap_open_action = {
    ["ctrl-t"] = 'tab split',
    ["ctrl-x"] = 'split',
    ["ctrl-v"] = 'vsplit'
  }

  vim.api.nvim_set_keymap('n', '<Plug>ClapFiles',      ':<C-u>Clap files --hidden<CR>',       { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapBuffers',    ':<C-u>Clap buffers<CR>',              { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapBLine',      ':<C-u>Clap blines<CR>',               { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapGFiles',     ':<C-u>Clap git_diff_files<CR>',       { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapGrep',       ':<C-u>Clap grep<CR>',                 { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapGrepWord',   ':<C-u>Clap grep ++query=<cword><CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<Plug>ClapGrepSelect', ':<C-u>Clap grep ++query=@visual<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapWindows',    ':<C-u>Clap windows<CR>',              { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapColors',     ':<C-u>Clap colors<CR>',               { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapCommand',    ':<C-u>Clap command<CR>',              { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Plug>ClapHelp',       ':<C-u>Clap help_tags<CR>',            { noremap = true, silent = true })

  -- custom commands likes `fzf.vim`
  vim.api.nvim_set_keymap('n', 'zf',         '<Plug>ClapFiles',      { silent = true })
  vim.api.nvim_set_keymap('n', 'zb',         '<Plug>ClapBuffers',    { silent = true })
  vim.api.nvim_set_keymap('n', 'zl',         '<Plug>ClapBLine',      { silent = true })
  vim.api.nvim_set_keymap('n', 'zg',         '<Plug>ClapGFiles',     { silent = true })
  vim.api.nvim_set_keymap('n', 'zr',         '<Plug>ClapGrep',       { silent = true })
  vim.api.nvim_set_keymap('n', 'zv',         '<Plug>ClapGrepWord',   { silent = true })
  vim.api.nvim_set_keymap('v', 'zv',         '<Plug>ClapGrepSelect', { silent = true })
  vim.api.nvim_set_keymap('n', 'zw',         '<Plug>ClapWindows',    { silent = true })
  vim.api.nvim_set_keymap('n', 'zc',         '<Plug>ClapColors',     { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>zc', '<Plug>ClapCommand',    { silent = true })
  vim.api.nvim_set_keymap('n', 'zh',         '<Plug>ClapHelp',       { silent = true })
end

return clap
