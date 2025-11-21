local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 200
config.initial_rows = 68

config.font_size = 10

config.window_background_image = ".config/wezterm/backgrounds/trees.png"
config.window_background_image_hsb = {
	brightness = 0.05,
	hue = 1.0,
	saturation = 1.0,
}

return config
