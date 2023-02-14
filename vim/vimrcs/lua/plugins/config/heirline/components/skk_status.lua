return {
  init = function(self)
    local mode = vim.fn['skkeleton#mode']()
    if mode == '' then
      self.mode = 'A'
    elseif mode == 'kata' then
      self.mode = 'ア'
    elseif mode == 'hira' then
      self.mode = 'あ'
    else
      self.mode = ''
    end
  end,
  provider = function(self)
    return " " .. self.mode .. " "
  end,
  hl = function()
    return {
      fg = 'skk_fg',
      bg = 'skk_bg',
    }
  end,
}
