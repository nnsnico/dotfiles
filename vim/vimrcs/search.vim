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

" set very magic
nnoremap / /\v
nnoremap ? ?\v

" search in word
nnoremap <Space>/ /\<\><Left><Left>
nnoremap <Space>? ?\<\><Left><Left>

" cancel highlight double push <ESC>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" search on selected word
vnoremap * y/\V<C-r>=escape(@",'/\')<CR><CR>
