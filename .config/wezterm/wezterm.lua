local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 260
config.initial_rows = 68

config.font_size = 10

config.window_background_image = ".config/wezterm/backgrounds/trees.png"
config.window_background_image_hsb = {
	-- local dimmer = {
	brightness = 0.1,
	hue = 1.0,
	saturation = 1.0,
}
-- config.background = {
-- 	{
-- 		source = { File = ".config/wezterm/backgrounds/trees.png" },
-- 		height = "Contain",
-- 		hsb = dimmer,
-- 	},
-- }

return config
