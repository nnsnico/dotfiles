" ignore lowercase and uppercase
set ignorecase

" search by distinguishing if uppercase are included
set smartcase

" incremental search
set incsearch

" wrap scanning
set wrapscan

" highlight
set hlsearch

" cancel highlight double push <ESC>
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
