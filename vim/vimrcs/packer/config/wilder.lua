local wilder = {}

wilder.config = function()
  vim.api.nvim_set_keymap('c', '<Tab>', '<C-n>', {})

  vim.cmd([[
    function! s:wilder_init() abort
      call wilder#setup({
            \ 'modes': [':'],
            \ 'next_key': '<C-n>',
            \ 'previous_key': '<C-p>',
            \ })
      call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline({
            \       'fuzzy': 1,
            \       'set_pcre2_pattern': has('nvim'),
            \     }),
            \     wilder#python_search_pipeline({
            \       'pattern': 'fuzzy',
            \     }),
            \   ),
            \ ])

      let l:highlighters = [
            \ wilder#pcre2_highlighter(),
            \ wilder#basic_highlighter(),
            \ ]
      call wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#DB8B33', 'bold': 1}])

      call wilder#set_option('renderer', wilder#popupmenu_renderer(
            \ wilder#popupmenu_border_theme({
            \   'winblend': &pumblend,
            \   'border': 'rounded',
            \   'highlighter': l:highlighters,
            \   'highlights': {
            \     'accent': 'WilderAccent',
            \     'border': 'Normal',
            \   },
            \ })))
    endfunction

    autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()
  ]])
end

return wilder
