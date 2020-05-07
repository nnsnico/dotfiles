let s:extensions = [
  \ 'coc-yaml',
  \ 'coc-eslint',
  \ 'coc-rls',
  \ 'coc-metals',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-python'
  \ ]

for ex in s:extensions
  echom 'Installing ' . ex
  execute 'CocInstall -sync ' . ex
endfor
