-- ## Updates ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local updates = wibox.widget.textbox()
updates.font = theme.font
--updates.markup

watch('bash -c "pacman -Qu | grep -Fcv "[ignored]" | sed "s/^//;s/^0$//g""', 3600, function(_, stdout)
    updates.text = stdout
    collectgarbage('collect')
end)

--return updates
updates_icon = wibox.widget {
	markup = '<span font="' .. theme.iconfont .. '"> </span>',
    align  = "center",
    valign = "center",
	widget = wibox.widget.textbox,
}
return wibox.widget {
	wibox.widget{
		updates_icon,
		align  = "center",
		valign = "center",
		fg = colors.yellow,
		widget = wibox.container.background
	},
    wibox.widget{
        updates, 
        fg = colors.yellow,
        widget = wibox.container.background
    },
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
