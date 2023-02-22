local wezterm = require('wezterm')

local function basename(s)
  return string.gsub(s, '(.*)[/\\]([a-z]+)[/\\]?$', '%2')
end

wezterm.on(
  'format-window-title',
  function(_, pane, _, _, _)
    local prog = pane.user_vars.WEZTERM_PROG
    local cwd = basename(pane.current_working_dir)
    return 'WezTerm' .. ' - ' .. cwd .. ' > ' .. (prog or '')
  end
)

return {
  color_scheme              = "tokyonight",
  font                      = wezterm.font_with_fallback({
    'JetBrainsMono Nerd Font',
    { family = 'PlemolJP Console' },
  }),
  font_size                 = 13,
  custom_block_glyphs       = false,
  enable_tab_bar            = false,
  window_decorations        = 'NONE|RESIZE',
  window_background_opacity = 0.9,
  window_padding            = {
    left   = 0,
    right  = 0,
    top    = 0,
    bottom = 0,
  }
}
