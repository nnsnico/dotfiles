local ddc = {}

ddc.config = function()
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
    }
  })
  vim.fn['ddc#enable']()
end

return ddc
