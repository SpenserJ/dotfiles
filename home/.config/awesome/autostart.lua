local awful = require("awful")

awful.spawn.single_instance("nm-applet", awful.rules.rules)
awful.spawn.single_instance("TogglDesktop", awful.rules.rules)
