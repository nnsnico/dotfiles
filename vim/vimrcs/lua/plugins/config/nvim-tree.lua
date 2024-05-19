---@diagnostic disable: redundant-parameter
local M = {}

---@class NvimTreeKeymap
---@field key string|string[]
---@field api function
---@field desc string

---@param keymaps NvimTreeKeymap[]
---@param bufnr number
local function make_keymaps(keymaps, bufnr)
  ---@type NvimTreeKeymap[]
  ---@param desc string
  local opts = function(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  ---@diagnostic disable: param-type-mismatch
  for _, keymap in ipairs(keymaps) do
    if (vim.islist(keymap.key)) then
      for _, key in ipairs(keymap.key) do
        vim.keymap.set('n', key, keymap.api, opts(keymap.desc))
      end
    else
      vim.keymap.set('n', keymap.key, keymap.api, opts(keymap.desc))
    end
  end
  ---@diagnostic enable: param-type-mismatch
end

---@param bufnr number
local on_attach = function(bufnr)
  local api = require('nvim-tree.api')
  local keymap_list = {
    { key = { "<CR>", "o" }, api = api.node.open.edit,               desc = "edit" },
    { key = "<C-t>",         api = api.tree.close,                   desc = "close" },
    { key = "x",             api = api.node.navigate.parent_close,   desc = "close_node" },
    { key = "K",             api = api.node.navigate.sibling.first,  desc = "first_sibling" },
    { key = "J",             api = api.node.navigate.sibling.last,   desc = "last_sibling" },
    { key = "I",             api = api.tree.toggle_gitignore_filter, desc = "toggle_git_ignored" },
    { key = "H",             api = api.tree.toggle_hidden_filter,    desc = "toggle_dotfiles" },
    { key = "R",             api = api.tree.reload,                  desc = "refresh" },
    { key = "i",             api = api.node.open.horizontal,         desc = "split" },
    { key = "s",             api = api.node.open.vertical,           desc = "vsplit" },
    { key = "t",             api = api.node.open.tab,                desc = "tabnew" },
    { key = "go",            api = api.node.open.preview,            desc = "preview" },
    { key = "[c",            api = api.node.navigate.git.prev,       desc = "prev_git_item" },
    { key = "]c",            api = api.node.navigate.git.next,       desc = "next_git_item" },
    { key = "M",             api = api.fs.create,                    desc = "create" },
    { key = "r",             api = api.fs.rename,                    desc = "rename" },
    { key = "cc",            api = api.fs.cut,                       desc = "cut" },
    { key = "yy",            api = api.fs.copy.node,                 desc = "copy" },
    { key = "YY",            api = api.fs.copy.relative_path,        desc = "copy_path" },
    { key = "Yy",            api = api.fs.copy.absolute_path,        desc = "copy_absolute_path" },
    { key = "dd",            api = api.fs.remove,                    desc = "remove" },
    { key = "p",             api = api.fs.paste,                     desc = "paste" },
    { key = "g?",            api = api.tree.toggle_help,             desc = "toggle_help" },
  }

  make_keymaps(keymap_list, bufnr)
end

M.setup = function()
  vim.keymap.set(
    'n',
    '<C-t>',
    function()
      local utils = require('functions.utils')
      local function is_empty(s)
        return s == nil or s == ''
      end

      if is_empty(utils.get_current_filename()) then
        return ':<C-u>NvimTreeOpen<CR>'
      else
        return ':<C-u>NvimTreeFindFile<CR>'
      end
    end,
    { noremap = true, silent = true, expr = true }
  )
end

M.config = function()
  require('nvim-tree').setup {
    on_attach = on_attach,
    renderer = {
      group_empty = true,
      full_name = true,
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          folder_arrow = false,
        },
      },
    },
    diagnostics = {
      enable = true
    }
  }
end

return M
