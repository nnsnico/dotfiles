local ddc = {}

ddc.config = function()
  vim.o.shortmess = vim.o.shortmess .. "c"

  vim.fn['ddc#custom#patch_global']('ui', 'native')
  vim.fn['ddc#custom#patch_global']('sources', {'skkeleton'})
  vim.fn['ddc#custom#patch_global']('sourceOptions', {
    ["_"] = {
      matchers = {'matcher_head'},
      sorters  = {'sorter_rank'},
    },
    skkeleton = {
      mark                  = 'skkeleton',
      matchers              = {'skkeleton'},
      sorters               = {},
      minAutoCompleteLength = 2,
      isVolatile            = true
    }
  })
  vim.fn['ddc#enable']()
end

return ddc
