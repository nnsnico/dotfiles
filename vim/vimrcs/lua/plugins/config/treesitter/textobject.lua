local M = {}

local select_keymaps = {
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['ac'] = '@class.outer',
  ['ic'] = '@class.inner',
  ['ai'] = '@conditional.outer',
  ['ii'] = '@conditional.inner',
  ['al'] = '@loop.outer',
  ['il'] = '@loop.inner',
}

local move_keymaps = {
  goto_next_start = {
    ["]m"] = '@function.outer',
    ["]]"] = '@class.outer',
  },
  goto_next_end = {
    ["]M"] = '@function.outer',
    ["]["] = '@class.outer',
  },
  goto_previous_start = {
    ["[m"] = '@function.outer',
    ["[["] = '@class.outer',
  },
  goto_previous_end = {
    ["[M"] = '@function.outer',
    ["[]"] = '@class.outer',
  },
}

M.config = function()
  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true
    },
    move = {
      set_jumps = true,
    },
  })

  -- select
  local select = require('nvim-treesitter-textobjects.select')
  for keymap, query in pairs(select_keymaps) do
    vim.keymap.set({ 'x', 'o' }, keymap, function()
      select.select_textobject(query, 'textobjects')
    end)
  end

  -- move
  for func, map in pairs(move_keymaps) do
    for keymap, query in pairs(map) do
      vim.keymap.set({ 'n', 'x', 'o' }, keymap, function()
        local func_format = string.format([[require("nvim-treesitter-textobjects.move").%s("%s", "textobjects")]], func, query)
        loadstring(func_format)()
      end)
    end
  end

end

return M
