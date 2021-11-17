let s:extensions = [
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-markdownlint',
  \ 'coc-metals',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-rls',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-webview',
  \ 'coc-yaml'
  \ ]

execute 'CocInstall ' . join(s:extensions)
