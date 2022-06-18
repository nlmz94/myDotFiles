-- ## Keyboard layout ##
-- ~~~~~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local awful = require("awful")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

-- Keyboard :
keyboardlayout = awful.widget.keyboardlayout()
keyboardlayout.widget.font = theme.font
keyboard_icon = wibox.widget {
	markup = '<span font="' .. theme.iconfont .. '"></span>',
	widget = wibox.widget.textbox,
}

return wibox.widget {
	wibox.widget{
		keyboard_icon,
		fg = colors.brightblue,
		widget = wibox.container.background
	},
    wibox.widget{
        keyboardlayout, 
        fg = colors.brightblue,
        widget = wibox.container.background
    },
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
