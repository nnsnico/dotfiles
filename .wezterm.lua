local wezterm = require('wezterm')

-- AaaaaaBCDE ->
return {
  color_scheme              = "tokyonight",
  font                      = wezterm.font_with_fallback({
    'JetBrainsMono Nerd Font',
    { family = 'PlemolJP Console' },
  }),
  font_size                 = 13,
  window_background_opacity = 0.9,
  custom_block_glyphs       = false,
  enable_tab_bar            = false,
  window_padding            = {
    left   = 0,
    right  = 0,
    top    = 0,
    bottom = 0,
  }
}
