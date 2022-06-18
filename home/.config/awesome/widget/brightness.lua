-- ## Brightness ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local brightness = wibox.widget.textbox()
brightness.font = beautiful.font

watch([[bash -c "brightnessctl | grep -oP '[^()]+%'"]], 0, function(_, stdout)
    brightness.text = stdout
    collectgarbage('collect')
end)

--return brightness
brightness_icon = wibox.widget {
	markup = '<span font="' .. theme.iconfont .. '"> </span>',
	widget = wibox.widget.textbox,
}
return wibox.widget {
	wibox.widget{
		brightness_icon,
		fg = colors.brightyellow,
		widget = wibox.container.background
	},
    wibox.widget{
        brightness, 
        fg = colors.brightyellow,
        widget = wibox.container.background
    },
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
