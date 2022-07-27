---@diagnostic disable: redundant-parameter
local M = {}

M.setup = function()
  vim.api.nvim_set_keymap(
    'n',
    '<C-t>',
    '@% == "" ? ":<C-u>NvimTreeOpen<CR>" : ":<C-u>NvimTreeFindFile<CR>"',
    { noremap = true, expr = true }
  )
end

M.config = function()
  local tree_callback = require('nvim-tree.config').nvim_tree_callback
  require('nvim-tree').setup {
    view = {
      mappings = {
        custom_only = true,
        list = {
          { key = { "<CR>", "o" }, cb = tree_callback("edit") },
          { key = "<C-t>",         cb = tree_callback("close") },
          { key = "x",             cb = tree_callback("close_node") },
          { key = "K",             cb = tree_callback("first_sibling") },
          { key = "J",             cb = tree_callback("last_sibling") },
          { key = "I",             cb = tree_callback("toggle_ignored") },
          { key = "H",             cb = tree_callback("toggle_dotfiles") },
          { key = "R",             cb = tree_callback("refresh") },
          { key = "i",             cb = tree_callback("split") },
          { key = "s",             cb = tree_callback("vsplit") },
          { key = "go",            cb = tree_callback("preview") },
          { key = "[c",            cb = tree_callback("prev_git_item") },
          { key = "]c",            cb = tree_callback("next_git_item") },
          { key = "M",             cb = tree_callback("create") },
          { key = "r",             cb = tree_callback("rename") },
          { key = "cc",            cb = tree_callback("cut") },
          { key = "yy",            cb = tree_callback("copy") },
          { key = "YY",            cb = tree_callback("copy_path") },
          { key = "Yy",            cb = tree_callback("copy_absolute_path") },
          { key = "dd",            cb = tree_callback("remove") },
          { key = "p",             cb = tree_callback("paste") },
          { key = "g?",            cb = tree_callback("toggle_help") },
        }
      },
    },
    renderer = {
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
  }
end

return M
