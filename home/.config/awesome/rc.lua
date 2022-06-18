pcall(require, "luarocks.loader")

-- Standard awesome library
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Themes :

-- choose your theme here
local accents = {
    "otis-forest",			-- 1
    "tomorrow-dark",		-- 2
    "onedark",				-- 3
	
}
-- choose your theme here
local chosen_accents = accents[1]
local theme_path = string.format("%s/.config/awesome/themes/accents/%s.lua", os.getenv("HOME"), chosen_accents)
beautiful.init(theme_path)

-- Configs :

-- Notifications :
require("configuration.notifications")

-- keybinds :
require("configuration.keys")

-- Layouts :
require("configuration.layouts")

-- Rules :
require("configuration.rules")

-- Titlebars :
require("ui.titlebar")

-- Menu :
require("ui.menu")

-- Bar :
require("ui.bar")


