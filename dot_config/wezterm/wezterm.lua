local wezterm = require 'wezterm'

return {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 12.0,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_background_opacity = 0.85,
  default_cursor_style = "BlinkingBar",
  animation_fps = 240,	
  cursor_blink_rate = 300,
}
