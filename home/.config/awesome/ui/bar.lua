-- ## Bar ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("ui.helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

--

-- Tags 
-- awful.util.tagnames =  { "1", "2" , "3", "4", "5", "6", "7", "8", "9" }
-- awful.util.tagnames =  { "", " ", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "dev",  "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx" }
-- awful.util.tagnames =  { "", "", " ", "","", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "I", "II", "III", "IV", "V", "VI" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "一", "二", "三", "四", "五", "六", "七", "八", "九" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
awful.util.tagnames =  { "", "", "", "", "", "", "", "", ""}
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", ""}

-- Pacman Taglist :
-- awful.util.tagnames = {"●", "●", "●", "●", "●", "●", "●", "●", "●", "●"}
-- awful.util.tagnames = {"", "", "", "", "", "", "", "", "", ""}
-- awful.util.tagnames = {"•", "•", "•", "•", "•", "•", "•", "•", "•", "•"}
-- awful.util.tagnames = { "","", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames = { "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "",  "" }

-- Widgets :

-- Barcontainer :
local function barcontainer(widget)
    local container = wibox.widget
      {
        widget,
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
    }
    local box = wibox.widget{
        {
            container,
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin
        },
        bg = colors.black,
        shape = helpers.rrect(dpi(4)),
        widget = wibox.container.background
    }
return wibox.widget{
        box,
        top = dpi(2),
        bottom = dpi(2),
        right = dpi(2),
        left = dpi(2),
        widget = wibox.container.margin
    }
end

local clock_widget = require('widget.clock')
local keyboardlayout_widget = require('widget.keyboardlayout')
local mem_widget = require('widget.memory')
local cpu_widget = require('widget.cpu')
local temprature_widget = require('widget.temprature')
local battery_widget = require('widget.battery')

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
   
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
	
	-- Create a launcher for each screen
	mylauncher = wibox.container.margin(mylauncher, dpi(5), dpi(5), dpi(5), dpi(5))
	
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        visible = true,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }
    s.mylayoutbox = wibox.container.margin(s.mylayoutbox, dpi(6), dpi(6), dpi(6), dpi(6))
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
        },
    }
	taglist = wibox.widget {
		{
			{
				s.mytaglist,
				spacing = dpi(4),
				forced_height = 24,
				layout = wibox.layout.fixed.horizontal,
			},
			halign = "center",
			widget = wibox.container.place,

		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end,
		bg = colors.black,
		widget = wibox.container.background,
	}
	
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
		style    = {
			border_width = 1,
			border_color = colors.black,
			-- Text Enabeld :
			--shape        = function(cr,w,h) gears.shape.rounded_rect(cr, w, h, 8) end,
			-- Text disabeld :
			shape        = gears.shape.circle,
			bg_minimize = colors.brightblack,
		},		
		layout   = {
			spacing = 2,
			spacing_widget = {
				{
					forced_width = 0,
					shape        = gears.shape.circle,
					widget       = wibox.widget.separator
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout  = wibox.layout.flex.horizontal
		},
		widget_template = {
			{
				{
					{
						-- Icon :
						{
							id     = "clienticon",
							widget = awful.widget.clienticon,
						},
						margins = 6,
						widget  = wibox.container.margin,
					},
					-- Text :
					--{
					--	id     = "text_role",
					--	widget = wibox.widget.textbox,
					--},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 5,
				right = 5,
				widget = wibox.container.margin
			},
			id     = "background_role",
			widget = wibox.container.background,
		},
    }

	-- Systemtry :
	s.systray = wibox.widget {
		visible = false,
		base_size = dpi(24),
		horizontal = true,
		screen = 'primary',
		widget = wibox.widget.systray
	}
	s.tray_toggler  		= require('widget.tray-toggle')
	
    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "bottom",
        screen   = s,
		stretch = false,
		visible = true,
		height = 34,
		expand = "none",
		width = s.geometry.width - dpi(20),
        ontop = false,
        type = "dock",
        --bg = colors.transparent,
        awful.placement.top(s.mywibar, { margins = beautiful.useless_gap * 5 }),
 
        widget   = {
            layout = wibox.layout.align.horizontal,
            --expand = "none",
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                barcontainer(s.mytaglist),
                --taglist,
            },
            
			{ -- Middle widget
			  layout = wibox.layout.align.horizontal,
			  s.mytasklist,
			},
         
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                expand = "none",
                -- # Net :
				--barcontainer(net),
				
                -- # CPU TEMP :
                barcontainer(temprature_widget),
                
                -- # CPU :
                barcontainer(cpu_widget),
                
                -- # RAM :
				barcontainer(mem_widget),
                
                -- # Battery :
				--barcontainer(battery_widget),
                
                -- # Keybord :
                barcontainer(keyboardlayout_widget),

                -- # Clock :
                barcontainer(clock_widget),

                -- # Systray :
				{
				s.systray,
				margins = dpi(4),
				widget = wibox.container.margin
				},
                s.tray_toggler ,
                
                -- # Layouts :
                s.mylayoutbox
            },
        }
    }
end)

-- Wallpaper :
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = theme.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
