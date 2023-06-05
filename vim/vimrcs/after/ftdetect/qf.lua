vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'qf',
  callback = function()
    vim.o.number = false
  end
})
