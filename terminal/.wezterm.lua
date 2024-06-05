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

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
        else
            overrides.font_size = number_value
        end
    end
    window:set_config_overrides(overrides)
end)

return {
  color_scheme              = "tokyonight",
  font                      = wezterm.font_with_fallback({
    'JetBrainsMono NF',
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
