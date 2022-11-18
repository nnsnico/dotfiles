" ------------------------------- Basic Settings -------------------------------

" default shell
set shell=zsh

" character encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" set filetype
filetype plugin on

" support special symbol
if has('nvim')
  set ambiwidth=single
else
  set ambiwidth=double
endif

" not make backup and swapfile
set nobackup
set noswapfile
set nowrap

" auto read when the file being edited is changed
set autoread

" able to edit other file while editing buffer
set hidden

" apply indent auto when paste text
set autoindent

" show inputting command on status line
set showcmd

" popup menu height
set pumheight=10

" cmdline height
set cmdheight=2

" remove on backspace
set backspace=indent,eol,start

" copy to system at the same time as yank
" for WSL2, use `atotto/gocopy.exe` (neovim only)
let uname = substitute(system('uname'), '\n', '', '')
if uname == 'Linux'
  let lines = readfile('/proc/version')
  if lines[0] =~ 'microsoft'
    let user = 'yuji\ toyama'
    let g:clipboard = {
      \   'name': 'wslClipboard',
      \   'copy': {
      \     '+': 'gocopy.exe',
      \     '*': 'gocopy.exe',
      \   },
      \   'paste': {
      \     '+': 'gopaste.exe',
      \     '*': 'gopaste.exe',
      \   },
      \   'cache_enabled': 1,
      \ }
  endif
endif
set clipboard+=unnamed

" timeout length while waiting next keymapping
set timeoutlen=1000
" timeout length while waiting next keycode
set ttimeoutlen=10
" set updatetime
set updatetime=300

" time while highlight match paren
set matchtime=1

" scroll offset
set scrolloff=3
set sidescrolloff=3
set sidescroll=1

" enable modeline
set modeline

" split below when :split
set splitbelow

" split right when :vsplit
set splitright

" ---------------------------------- Keymaps ----------------------------------

" disable arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
imap    <Up>    <Nop>
imap    <Down>  <Nop>
imap    <Left>  <Nop>
imap    <Right> <Nop>

" Enable moving cursor likes emacs in command line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" ex command alias
command! -nargs=0 W :w
command! -nargs=0 WQA :wqa
command! -nargs=0 QA :qa

" splict window
nnoremap <silent> gs :<C-u>split<CR>
nnoremap <silent> gv :<C-u>vsplit<CR>

" move tab
nnoremap <C-l> gt
nnoremap <C-h> gT

" add new line <Space><CR>
nnoremap <Space><CR> o<ESC>

" support straddling line when enable wrapping line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" move to the first/end of the line
nnoremap gh ^
nnoremap gH 0
nnoremap gl $
nnoremap gL g$

nnoremap gp %

nnoremap ZZ :<C-u>q<CR>
nnoremap ZA :<C-u>qa<CR>
nnoremap ZW :<C-U>wq<CR>

" maximize window
nnoremap <silent><Space>m :<C-u>resize \| vertical resize<CR>

" toggle paste mode
" set pastetoggle=<leader>p
nnoremap <Leader>p :<C-u>set invpaste paste?<CR>

" toggle to wrap line
nnoremap <expr> tw &wrap == 0 ? ":set wrap<CR>" : ":set nowrap<CR>"

" center horizontally on cursor position
nnoremap <silent> z. :<C-u>normal! zszH<CR>

" ------------------------------------ Tab ------------------------------------

" replace tab to space
set expandtab

" tab size
set tabstop=2 " how many spaces to highlight as tab
set shiftwidth=2 " tab size when enter a line
set softtabstop=2 " tab size when press <tab>
set smarttab " convert to tab space until `shiftwidth` size of a current line

" stop tab until shiftwidth size
set shiftround
