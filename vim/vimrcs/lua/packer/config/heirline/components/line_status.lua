return {
  static = {
    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local percentage = math.floor((curr_line / lines) * 100)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return " " .. percentage .. "%%" .. " " .. string.rep(self.sbar[i], 2) .. " "
  end,
  hl = {
    fg = 'linestatus_fg',
    bg = 'linestatus_bg',
  }
}
