" ------------------------------- Basic Settings -------------------------------

" default shell
set shell=zsh

" character encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" support special symbol
set ambiwidth=double

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
set clipboard+=unnamed

" timeout length while waiting next keymapping
set timeoutlen=1000
" timeout length while waiting next keycode
set ttimeoutlen=10

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
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

" Enable moving cursor likes emacs in command line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" splict window
nmap <silent> gs :split<CR>
nmap <silent> gv :vsplit<CR>

" move tab
nmap <C-l> gt
nmap <C-h> gT

" add new line <Space><CR>
nmap <Space><CR> o<ESC>

" support straddling line when enable wrapping line
nnoremap j gj
nnoremap k gk

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
