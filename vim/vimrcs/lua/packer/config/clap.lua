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

  vim.keymap.set('n', '<Plug>ClapFiles',      ':<C-u>Clap files --hidden<CR>',       { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapBuffers',    ':<C-u>Clap buffers<CR>',              { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapBLine',      ':<C-u>Clap blines<CR>',               { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapGFiles',     ':<C-u>Clap git_diff_files<CR>',       { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapGrep',       ':<C-u>Clap grep<CR>',                 { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapGrepWord',   ':<C-u>Clap grep ++query=<cword><CR>', { noremap = true, silent = true })
  vim.keymap.set('v', '<Plug>ClapGrepSelect', ':<C-u>Clap grep ++query=@visual<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapWindows',    ':<C-u>Clap windows<CR>',              { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapColors',     ':<C-u>Clap colors<CR>',               { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapCommand',    ':<C-u>Clap command<CR>',              { noremap = true, silent = true })
  vim.keymap.set('n', '<Plug>ClapHelp',       ':<C-u>Clap help_tags<CR>',            { noremap = true, silent = true })

  -- custom commands likes `fzf.vim`
  vim.keymap.set('n', 'zf',         '<Plug>ClapFiles',      { silent = true })
  vim.keymap.set('n', 'zb',         '<Plug>ClapBuffers',    { silent = true })
  vim.keymap.set('n', 'zl',         '<Plug>ClapBLine',      { silent = true })
  vim.keymap.set('n', 'zg',         '<Plug>ClapGFiles',     { silent = true })
  vim.keymap.set('n', 'zr',         '<Plug>ClapGrep',       { silent = true })
  vim.keymap.set('n', 'zv',         '<Plug>ClapGrepWord',   { silent = true })
  vim.keymap.set('v', 'zv',         '<Plug>ClapGrepSelect', { silent = true })
  vim.keymap.set('n', 'zw',         '<Plug>ClapWindows',    { silent = true })
  vim.keymap.set('n', 'zc',         '<Plug>ClapColors',     { silent = true })
  vim.keymap.set('n', '<Leader>zc', '<Plug>ClapCommand',    { silent = true })
  vim.keymap.set('n', 'zh',         '<Plug>ClapHelp',       { silent = true })
end

return clap
