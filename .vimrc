" Installation
" ln -s ~/dotfiles/.vimrc ~/
" and, Install `Vundle` into ~/.vim/bundle/
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" `:PluginInstall` on vim

" Vundle Scripts-----------------------------
" You can comment it out if you use bash
set shell=/bin/bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Snippet
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
" Select on Vim
Plugin 'Shougo/unite.vim'
Plugin 'ujihisa/unite-colorscheme'
" Use Git on Vim
Plugin 'tpope/vim-fugitive'
" Search in Directory
Plugin 'ctrlpvim/ctrlp.vim'
" ColorScheme on Vim
Plugin 'flazz/vim-colorschemes' 
Plugin 'sjl/badwolf'
Plugin 'w0ng/vim-hybrid'
" Color Highlight
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'dag/vim-fish'
" Auto close parentheses
Plugin 'cohama/lexima.vim'
" Mutil Cursor ctrl + v
Plugin 'terryma/vim-multiple-cursors'
" ColorScheme on Vim mode
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Show project tree
Plugin 'scrooloose/nerdtree'

" You can specify revision/branch/tag.
Plugin 'Shougo/vimshell', { 'rev' : '3787e5' }

" Enable devicon on nerdtree
Plugin 'ryanoasis/vim-devicons'

"aawefaefk Required:
call vundle#end()

" Required:
filetype plugin indent on

"End Vundle Scripts-------------------------

" color scheme
colorscheme badwolf
set background=dark

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルとスワップファイルを作らない
set nobackup
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" バックスペースで削除
set backspace=indent,eol,start
" 矢印キーを無効にする
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" ctrl + l で右に移動する
inoremap <C-l> <C-g>U<Right>
" Space + Enterで空行を追加
noremap <Space><CR> o<ESC>
" コマンドラインモードをセミコロンで
nnoremap ; :

" 見た目系
" シンタックスカラー
syntax on
set term=xterm-256color
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
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" カーソルの表示をモードで変更する
let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
let &t_EI = "\<Esc>]1337;CursorShape=0\x7"

" Tab系
" 不可視文字を可視化
set list
set listchars=tab:»-,trail:-,eol:↩︎,
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
noremap <C-l> gt
noremap <C-h> gT
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

