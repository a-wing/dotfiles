local wezterm = require 'wezterm'
local config = {}

config.window_background_image = '/Users/metal/Pictures/101251718_p0.jpg'
config.color_scheme = 'Gruvbox dark, hard (base16)'

config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled'

config.window_background_image_hsb = {
  brightness = 0.05,
}

config.font = wezterm.font('Cascadia Code PL', { weight = 'DemiBold' })
config.font_size = 12.5

return config
