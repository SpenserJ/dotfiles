local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")
local set_wallpaper = require("wallpaper")
local mymainmenu = require("mainmenu")

-- 3rd party widgets
local cpu_widget = require("3rd-party.widgets-streetturtle.cpu-widget.cpu-widget")
local ram_widget = require("3rd-party.widgets-streetturtle.ram-widget.ram-widget")
local battery_widget = require("3rd-party.widgets-streetturtle.batteryarc-widget.batteryarc")
local brightness_widget = require("3rd-party.widgets-streetturtle.brightness-widget.brightness")
local volume_widget = require("3rd-party.widgets-streetturtle.volumebar-widget.volumebar")
-- local weather_widget = require("3rd-party.widgets-streetturtle.weather-widget.weather")

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu,
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  -- Left click focuses
  awful.button({ }, 1, function(t) t:view_only() end),
  -- Super + left click moves the current window
  awful.button({ keys.mod.super }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  -- Right click shows windows from multiple tags simultaneously
  awful.button({ }, 3, awful.tag.viewtoggle),
  -- Super + right click assigns a window to multiple tags simultaneously
  awful.button({ keys.mod.super }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  -- Scroll through the tags
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  -- Left click will focus or minimize
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  -- Right click shows a menu of all windows across tags
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  -- Scroll through the windows in the current tag
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local mytextclock = wibox.widget.textclock()

-- Set up each screen
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(
    { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    s,
    awful.layout.layouts[1]
  )

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      cpu_widget({ color = "#434c5e" }),
      ram_widget(),
      battery_widget({
        show_current_level = true
      }),
      brightness_widget(),
      -- weather_widget({
      --   api_key = "611ffea2808b872d7f3ea33f750a11ee",
      --   coordinates = { 50.9046, -113.9423 }
      -- }),
      volume_widget(),
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }
end)
