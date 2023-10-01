local M = {}

M.init = function()
  vim.g.firenvim_config = {
    globalSettings = {
      alt = 'all',
    },
    localSettings = {
      ['.*'] = {
        cmdline  = 'neovim',
        content  = 'text',
        priority = 0,
        selector = 'textarea',
        takeover = 'always',
      },
      ['https://www\\.google\\.com/'] = {
        takeover = 'never',
        priority = 1,
      },
      ['https://mail\\.google\\.com/'] = {
        content  = 'html',
        priority = 1,
        selector = 'div[role="textbox"]',
        takeover = 'always',
      },
      ['https://github\\.com/.*blob.*'] = {
        takeover = 'never',
        priority = 1,
      },
      ['https://github\\.com/.*(issues|pull|compare).*'] = {
        cmdline  = 'neovim',
        content  = 'text',
        priority = 1,
        selector = 'textarea',
        takeover = 'always',
        filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md',
      },
      ['https://blog\\.hatena\\.ne\\.jp/'] = {
        cmdline  = 'neovim',
        content  = 'text',
        priority = 1,
        selector = 'textarea',
        takeover = 'always',
        filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.md',
      },
      ['https://play\\.kotlinlang\\.org'] = {
        cmdline  = 'neovim',
        content  = 'text',
        priority = 1,
        selector = 'textarea',
        takeover = 'always',
        filename = '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.kt',
      },
      ['https://perf\\.hrmos\\.co/'] = {
        content  = 'html',
        priority = 1,
        selector = 'div[class="ql-editor"]',
        takeover = 'always',
      },
      ['https://.*\\.notion\\.so'] = {
        takeover = 'never',
        priority = 1,
      },
      ['https://.*\\.notion\\.site/'] = {
        takeover = 'never',
        priority = 1,
      },
    }
  }
  if vim.g.started_by_firenvim then
    vim.keymap.set('n', '<C-e>', '<Cmd>call firenvim#hide_frame()<CR>', { silent = true })
    vim.o.laststatus = 0
    vim.o.wrap = true
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if vim.o.lines < 20 then
          vim.o.lines = 20
        end
      end
    })
  end
  vim.cmd('hi link CmpItemAbbrDefault Pmenu')
  vim.cmd('hi link CmpItemAbbr Pmenu')
  vim.cmd('hi link CmpItemMenu Pmenu')
end

return M
