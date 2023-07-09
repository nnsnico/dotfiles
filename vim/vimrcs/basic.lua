local opt = vim.o

-------------------------------- Basic Settings --------------------------------

opt.shell = 'zsh'

-- character encoding
opt.encoding      = 'utf-8'
opt.fileencodings = 'utf-8'
opt.fileformats   = 'unix,dos,mac'

vim.cmd([[filetype plugin on]])

opt.backup   = false
opt.swapfile = false
opt.wrap     = false

opt.autoread = true
opt.hidden   = true

opt.autoindent = true
opt.showcmd    = true

opt.pumheight = 10
opt.cmdheight = 2

opt.clipboard = 'unnamed'

-- Timeout length while waiting next keymapping
opt.timeoutlen  = 1000
-- Timeout length while waiting next keycode
opt.ttimeoutlen = 10
-- Milliseconds until nothing typed is triggered
opt.updatetime  = 300

-- Seconds to show the matching paren
opt.matchtime = 1

-- Enable modeline
opt.modeline = true

-- Split
opt.splitbelow = true
opt.splitright = true

-------------------------------------- Tab -------------------------------------

-- use space instead tab
opt.expandtab = true

-- Tab size
opt.tabstop     = 2 -- number of spaces to highlight as Tab
opt.shiftwidth  = 2 -- number of tab size when enter new line
opt.softtabstop = 2 -- number of tab size when pressing <Tab>

opt.smarttab   = true -- insert indent when pressing <Tab> at beginning of a line
opt.shiftround = true

----------------------------------- Keymaps ------------------------------------

local keymap = vim.keymap

keymap.set('n', '<Up>',    '<Nop>', {})
keymap.set('n', '<Down>',  '<Nop>', {})
keymap.set('n', '<Left>',  '<Nop>', {})
keymap.set('n', '<Right>', '<Nop>', {})

keymap.set('i', '<Up>',    '<Nop>', { remap = true })
keymap.set('i', '<Down>',  '<Nop>', { remap = true })
keymap.set('i', '<Left>',  '<Nop>', { remap = true })
keymap.set('i', '<Right>', '<Nop>', { remap = true })

keymap.set('c', '<C-p>', '<Up>',    {})
keymap.set('c', '<C-n>', '<Down>',  {})
keymap.set('c', '<C-b>', '<Left>',  {})
keymap.set('c', '<C-f>', '<Right>', {})
keymap.set('c', '<C-a>', '<Home>',  {})
keymap.set('c', '<C-e>', '<End>',   {})
keymap.set('c', '<C-d>', '<Del>',   {})


keymap.set('n', 'gs', function() vim.cmd('split') end,  { silent = true })
keymap.set('n', 'gv', function() vim.cmd('vsplit') end, { silent = true })

keymap.set('n', '<C-l>', function() vim.cmd('normal! gt') end, {})
keymap.set('n', '<C-h>', function() vim.cmd('normal! gT') end, {})

keymap.set('n', '<Space><CR>', 'o<Esc>', {})

keymap.set({ 'n', 'v' }, 'j', 'gj', {})
keymap.set({ 'n', 'v' }, 'k', 'gk', {})

keymap.set({ 'o', 'n', 'x' }, '$', '<Nop>', {})
keymap.set({ 'o', 'n', 'x' }, '%', '<Nop>', {})
keymap.set({ 'o', 'n', 'x' }, '^', '<Nop>', {})

keymap.set({ 'o', 'n', 'x' }, 'gh', '^',                            {})
keymap.set({ 'o', 'n', 'x' }, 'gH', '0',                            {})
keymap.set({ 'o', 'n', 'x' }, 'gl', '$',                            {})
keymap.set({ 'o', 'n', 'x' }, 'gL', 'g$',                           {})
keymap.set({ 'o', 'n' }, 'gp', '<Plug>(MatchitNormalForward)')
keymap.set({ 'x' }, 'gp', '<Plug>(MatchitVisualForward)')

keymap.set('n', 'ZZ', function() vim.cmd('q') end,  {})
keymap.set('n', 'ZA', function() vim.cmd('qa') end, {})
keymap.set('n', 'ZW', function() vim.cmd('wq') end, {})

keymap.set('n', '<Space>m', function()
  vim.cmd('resize')
  vim.cmd('vertical resize')
end, {})

keymap.set('n', '<Leader>p', function()
  opt.paste = not opt.paste
  vim.api.nvim_echo({
    { 'set paste mode: ' .. tostring(opt.paste) },
  }, false, {})
end, {})

keymap.set('n', 'tw', function()
  opt.wrap = not opt.wrap
  print('set wrap line option: ', opt.wrap)
  vim.api.nvim_echo({
    { 'set wrap line option: ' .. tostring(opt.wrap) },
  }, false, {})
end, {})

keymap.set('n', 'z.', function()
  vim.cmd('normal! zszH')
end, { silent = true })


keymap.set('n', '<Space>w',   function() vim.cmd('w') end)
keymap.set('n', '<Space>wqa', function() vim.cmd('wqa') end)
keymap.set('n', '<Space>QA',  function() vim.cmd('qa') end)
