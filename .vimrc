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

let s:toml_file = '~/dotfiles/dein.toml'
let s:toml_file_lazy = '~/dotfiles/dein_lazy.toml'
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

" color scheme
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

" setting
" default shell
set shell=zsh
"文字コードをUTF-8に設定
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
" バックアップファイルとスワップファイルを作らない
set nobackup
set noswapfile
set nowrap
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" apply indent auto when paste text
set autoindent
" 入力中のコマンドをステータスに表示する
set showcmd
" cmdline height
set cmdheight=2
" バックスペースで削除
set backspace=indent,eol,start
" ヤンクでコピーした内容をOSレベルのクリップボードで保存する
set clipboard+=unnamed
" 矢印キーを無効にする
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>
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
" ctrl + l で右に移動する
imap <C-l> <C-g>U<Right>
" Space + Enterで空行を追加
nmap <Space><CR> o<ESC>

" 見た目系
" シンタックスカラー
syntax on
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest,full
" 文字がかぶるのを修正する
set ambiwidth=double
" 折り返し時に表示行単位での移動できるようにする
nn j gj
nn k gk
" カーソルの表示をモードで変更する(iTerm限定)
if has('mac')
  let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
  let &t_EI = "\<Esc>]1337;CursorShape=0\x7"
endif

" Tab系
" 不可視文字を可視化
set list
set listchars=tab:»-,trail:-,eol:↩
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別して検索する
set noignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1

" highlight comment
augroup mygroup
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd BufNewFile,BufRead *.conf set filetype=conf
augroup end
