" Installation
" exec installer script(/install/vim_installer.sh)
"
" Optional
" Please install `nerd fonts` if you show mini icon in nerdtree
" https://github.com/ryanoasis/nerd-fonts
"


"dein Scripts-----------------------------

set shell=/bin/bash

if &compatible
  set nocompatible               " Be iMproved
endif

augroup MyAutoCmd
  autocmd!
augroup END

" dein settings
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

let s:toml_file = '~/dotfiles/vim/dein.toml'
let s:toml_file_lazy = '~/dotfiles/vim/dein_lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file , {'lazy': 0})
  call dein#load_toml(s:toml_file_lazy, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"end Scripts-----------------------------

" COLOR SCHEME -----------------------------

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if has('nvim')
  set pumblend=30
  set winblend=20
endif

if has('termguicolors')
  set termguicolors
endif

colorscheme apprentice
set background=dark

" END COLOR SCHEME -----------------------------

" BASIC -----------------------------

" default shell
set shell=zsh
" character encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
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

" END BASIC -----------------------------

" VISUAL -----------------------------

" enable syntax color
syntax on
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
" always show status line
set laststatus=2
" completion command line
set wildmode=list:longest,full
" height command line
set cmdheight=2
" support special symbol
set ambiwidth=double
" support straddling line when enable wrapping line
nnoremap j gj
nnoremap k gk
" change shape of cursor each mode (support iTerm only)
if has('mac')
  let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
  let &t_EI = "\<Esc>]1337;CursorShape=0\x7"
endif

" END VISUAL -----------------------------

" TAB -----------------------------

" visualize invisible characters
set list
set listchars=tab:»-,trail:-,eol:↩
" replace tab to space
set expandtab
" tab size
set tabstop=2
set shiftwidth=2
" stop tab until shiftwidth size
set shiftround

" END TAB -----------------------------

" SEARCH -----------------------------

" ignore lowercase and uppercase
set noignorecase
" search by distinguishing if uppercase are included
set smartcase
" incremental search
set incsearch
" wrap scanning
set wrapscan
" highlight
set hlsearch
" cancel highlight double push <ESC>
nmap <silent><Esc><Esc> :nohlsearch<CR><Esc>

" (Optional) move from terminal on neovim
if has('nvim')
  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l
endif

" END SEARCH -----------------------------

let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1

" highlight comment
augroup mygroup
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd BufNewFile,BufRead *.conf set filetype=conf
augroup end

if has('nvim')
  function! OnUIEnter(event)
    let l:ui = nvim_get_chan_info(a:event.chan)
    if has_key(l:ui, 'client') && has_key(l:ui.client, 'name')
      if l:ui.client.name ==# 'Firenvim'
        set laststatus=0
        set guifont=HackNerdFontCompleteM-Regular:h9
      endif
    endif
  endfunction
endif

if has('nvim')
  autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
endif

if exists('g:vv')
  VVset fontfamily="HackNerdFontComplete-Regular"
endif
