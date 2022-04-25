local M = {}

M.config = function()
  local wilder = require('wilder')

  vim.api.nvim_set_keymap('c', '<Tab>', '<C-n>', {})

  local wilder_init = function()
    wilder.setup({
      modes        = { ':' },
      next_key     = '<C-n>',
      previous_key = '<C-p>',
    })
    wilder.set_option('use_python_remote_plugin', 0)
    wilder.set_option('pipeline', {
      wilder.debounce(50),
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy        = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.python_search_pipeline()
      )
    })

    local highlighters = {
      wilder.lua_pcre2_highlighter(),
      wilder.lua_fzy_highlighter(),
    }

    wilder.set_option('renderer', wilder.popupmenu_renderer(
      wilder.popupmenu_border_theme({
        winblend = vim.o.pumblend,
        border = 'rounded',
        highlighter = highlighters,
        highlights = {
          accent = wilder.make_hl(
            'WilderAccent',
            'Pmenu',
            { { a = 1 }, { a = 1 }, { foreground = '#DB8B33', bold = 1 } }
          ),
          border = 'Normal',
        },
        left = {
          ' ',
          wilder.popupmenu_devicons(),
        },
        right = {
          ' ',
          wilder.popupmenu_scrollbar(),
        },
      })
    ))
  end

  vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
    pattern = { '*' },
    once = true,
    callback = function()
      wilder_init()
      vim.fn['wilder#main#start']()
    end,
  })
end

return M
