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

" cmdline height
set cmdheight=2

" remove on backspace
set backspace=indent,eol,start

" copy to system at the same time as yank
set clipboard+=unnamed

" timeout length while waiting next keymapping
set timeoutlen=3000
" timeout length while waiting next keycode
set ttimeoutlen=50

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

" Enable vi-arrow in command line mode by <ctrl> + (h|j|k|l)
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" add new line <Space><CR>
nmap <Space><CR> o<ESC>

" visualize invisible characters
set list
set listchars=tab:»-,trail:-,eol:↩

" replace tab to space
set expandtab

" tab size
set tabstop=2 " how many spaces to highlight as tab
set shiftwidth=2 " tab size when enter a line
set softtabstop=2 " tab size when press <tab>
set smarttab " convert to tab space until `shiftwidth` size of a current line

" stop tab until shiftwidth size
set shiftround

" support straddling line when enable wrapping line
nnoremap j gj
nnoremap k gk
