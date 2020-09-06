stds.awesome = {
  -- Global objects defined by the C code
  read_globals = {
    "awesome",
    "button",
    "dbus",
    "drawable",
    "drawin",
    "key",
    "keygrabber",
    "mousegrabber",
    "selection",
    "tag",
    "window",
    "table.unpack",
    "math.atan2",
  },

  -- screen may not be read-only, because newer luacheck versions complain about
  -- screen[1].tags[1].selected = true.
  -- The same happens with the following code:
  --   local tags = mouse.screen.tags
  --   tags[7].index = 4
  -- client may not be read-only due to client.focus.
  globals = {
    "screen",
    "mouse",
    "root",
    "client"
  },
}

stds.custom = {
  -- Enable cache (uses .luacheckcache relative to this rc file).
  cache = true,
}

std = "min+awesome+custom"
