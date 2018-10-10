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

" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " HTML snippets
  call dein#add('mattn/emmet-vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev' : '3787e5' })

  " Insert Auto date
  call dein#add('vim-scripts/autodate.vim')

  " auto format
  call dein#add('Chiel92/vim-autoformat')
  " editor config
  call dein#add('editorconfig/editorconfig-vim')
  " Select on Vim
  call dein#add('Shougo/unite.vim')
  call dein#add('ujihisa/unite-colorscheme')
  " Use Git on Vim
  call dein#add('tpope/vim-fugitive')
  " Search in Directory
  call dein#add('ctrlpvim/ctrlp.vim')
  " ColorScheme on Vim
  call dein#add('flazz/vim-colorschemes')
  call dein#add('sjl/badwolf')
  call dein#add('w0ng/vim-hybrid')
  " syntax color
  call dein#add('leafgarland/typescript-vim')
  call dein#add('ianks/vim-tsx')
  call dein#add('dag/vim-fish')
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('elmcast/elm-vim')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  " Auto close parentheses
  call dein#add('cohama/lexima.vim')
  " Auto close something selection range
  call dein#add('tpope/vim-surround')
  " Mutil Cursor ctrl + v
  call dein#add('terryma/vim-multiple-cursors')
  " ColorScheme on Vim mode
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  " Show directory tree
  call dein#add('scrooloose/nerdtree')

  " Asynchronous linter
  call dein#add('w0rp/ale')

  " (Optional) Enable devicon on nerdtree
  " When you not install `nerd fonts`, comment out this line
  call dein#add('ryanoasis/vim-devicons')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" color scheme
colorscheme hybrid
set background=dark

" setting
" default shell
set sh=zsh
"文字コードをUTF-8に設定
set enc=utf-8
set fencs=utf-8
set ffs=unix,dos,mac
" バックアップファイルとスワップファイルを作らない
set nobackup
set noswapfile
set nowrap
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
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
" ctrl + l で右に移動する
imap <C-l> <C-g>U<Right>
" Space + Enterで空行を追加
nmap <Space><CR> o<ESC>
" コマンドラインモードをセミコロンで
nn ; :

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
set wildmode=list:longest
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

" NERDTree系
" ファイル指定の有無によって起動時にtreeを表示するかを切り替える
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 隠しファイルをデフォルトで表示
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
" Ctrl + tでディレクトリツリー表示
map <C-t> :NERDTreeToggle<CR>
" ctrl + h & lでタブの移動
nmap <C-l> gt
nmap <C-h> gT
" ssで垂直方向に画面分割
nmap gs :split<CR>
" svで水平方向に画面分割
nmap gv :vsplit<CR>
" 拡張子のハイライト表示(nerdtree-devicon未使用時)
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" Scalafmt系
nmap <F5> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
nmap <C-a> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin 2>/dev/null'"
let g:formatters_scala = ['scalafmt']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" autodate系
" フォーマット
let autodate_format="%Y/%m/%d %A"

" Emmet系
let g:user_emmet_leader_key='<C-Y>'
