local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")

-- Customize these
local terminal = "konsole"
local fallbackEditor = "vim"
beautiful.init(awful.util.get_configuration_dir() .. "theme/theme.lua")
-- beautiful.wallpaper = awful.util.get_configuration_dir() .. "wallpapers/wallhaven-p8yq2p_1920x1080.png"

-- Generated return values
local editor = os.getenv("EDITOR") or fallbackEditor

-- Set the terminal for applications that require it
menubar.utils.terminal = terminal

return {
  terminal = terminal,
  editor = editor,
  editor_cmd = terminal .. " -e " .. editor,
}
