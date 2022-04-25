" true color on terminal (support neovim only)
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" enable true colors
if has('termguicolors')
  set termguicolors
  " for tmux
  if !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

" colorscheme
set background=dark
colorscheme tokyonight

" transparent color on floating window and popup window (support neovim only)
if has('nvim')
  set pumblend=20
  set winblend=10
endif

" move from terminal on neovim
if has('nvim')
  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l
endif

" enable syntax color
syntax enable

" show line number
set number

" highlight current line
set cursorline

" able to edit end of line one more
set virtualedit=onemore

" enable smart indent
set smartindent

" visualize bell (flash display)
set visualbell

" show match paren
set showmatch

if has('nvim')
  " use global statusline
  set laststatus=3
else
  " always show statusline
  set laststatus=2
endif

" not shown mode
set noshowmode

" completion command line
if has('nvim')
  set wildmode=longest,full
  cnoremap <expr> <C-p> pumvisible() ? "<C-p>" : "<Up>"
  cnoremap <expr> <C-n> pumvisible() ? "<C-n>" : "<Down>"
else
  set wildmode=list:longest,full
endif

" height command line
set cmdheight=2

" visualize invisible characters
set list
set listchars=tab:»-,trail:-,eol:↩

" show a column line
set colorcolumn=80

" change shape of cursor each mode (support vim only)
if has('mac')
  let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
  let &t_EI = "\<Esc>]1337;CursorShape=0\x7"
endif
