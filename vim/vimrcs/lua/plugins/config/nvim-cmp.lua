local M = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  vim.o.completeopt = 'menu,menuone,noselect'

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    window = {
      completion = cmp.config.window.bordered({
        border = 'rounded',
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      }),
      documentation = cmp.config.window.bordered({
        border = 'rounded',
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping(function(callback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          callback()
        end
      end, { "i" }),
    }),
    completion = {
      keyword_length = 2,
    },
    formatting = {
      fields = { 'icon', 'kind', 'abbr', 'menu' },
      ---@param item lsp.CompletionItem
      format = function(entry, item)
        -- item.menu = entry:get_completion_item().detail
        local kind = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
        })(entry, item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.icon = " " .. (kind.icon or "") .. " "
        kind.kind = strings[0] or ""
        kind.menu = "(" .. (strings[1] or "") .. ")"
        return kind
      end
    },
    sources = cmp.config.sources({
      { name = 'skkeleton' },
      { name = 'emoji' },
    }, {
      { name = 'nvim_lsp' },
      { name = 'path' },
      {
        name = 'spell',
        option = {
          enable_in_context = function()
            local skk_mode = vim.fn['skkeleton#mode']()
            return skk_mode == ''
          end
        },
      },
    }, {
      { name = 'buffer' },
    }),
  }

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = 'skkeleton' },
      },
      {
        { name = 'buffer' },
      }
    ),
    formatting = {
      fields = { 'abbr' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = 'path' },
      },
      {
        { name = 'cmdline' },
      }
    ),
    formatting = {
      fields = { 'icon', 'abbr' },
      ---@param item lsp.CompletionItem
      format = function(entry, item)
        local kind = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
        })(entry, item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.icon = ' ' .. (kind.icon or '') .. ' '
        kind.kind = " " .. (strings[1] or "") .. " "
        return kind
      end
    },
  })
end

M.init = function()
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      -- Customization for Pmenu
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

      vim.api.nvim_set_hl(0, "CmpItemKindFieldIcon", { fg = "#EED8DA", bg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindPropertyIcon", { fg = "#EED8DA", bg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindEventIcon", { fg = "#EED8DA", bg = "#B5585F" })

      vim.api.nvim_set_hl(0, "CmpItemKindTextIcon", { fg = "#C3E88D", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumIcon", { fg = "#C3E88D", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeywordIcon", { fg = "#C3E88D", bg = "#9FBD73" })

      vim.api.nvim_set_hl(0, "CmpItemKindConstantIcon", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructorIcon", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindReferenceIcon", { fg = "#FFE082", bg = "#D4BB6C" })

      vim.api.nvim_set_hl(0, "CmpItemKindFunctionIcon", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindStructIcon", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindClassIcon", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindModuleIcon", { fg = "#EADFF0", bg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperatorIcon", { fg = "#EADFF0", bg = "#A377BF" })

      vim.api.nvim_set_hl(0, "CmpItemKindVariableIcon", { fg = "#C5CDD9", bg = "#7E8294" })
      vim.api.nvim_set_hl(0, "CmpItemKindFileIcon", { fg = "#C5CDD9", bg = "#7E8294" })

      vim.api.nvim_set_hl(0, "CmpItemKindUnitIcon", { fg = "#F5EBD9", bg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippetIcon", { fg = "#F5EBD9", bg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolderIcon", { fg = "#F5EBD9", bg = "#D4A959" })

      vim.api.nvim_set_hl(0, "CmpItemKindMethodIcon", { fg = "#DDE5F5", bg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindValueIcon", { fg = "#DDE5F5", bg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMemberIcon", { fg = "#DDE5F5", bg = "#6C8ED4" })

      vim.api.nvim_set_hl(0, "CmpItemKindInterfaceIcon", { fg = "#D8EEEB", bg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindColorIcon", { fg = "#D8EEEB", bg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameterIcon", { fg = "#D8EEEB", bg = "#58B5A8" })
    end,
  })
end

return M
