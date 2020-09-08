local menubar = require("menubar")

-- Customize these
local terminal = "konsole"
local fallbackEditor = "vim"

-- Generated return values
local editor = os.getenv("EDITOR") or fallbackEditor

-- Set the terminal for applications that require it
menubar.utils.terminal = terminal

return {
  terminal = terminal,
  editor = editor,
  editor_cmd = terminal .. " -e " .. editor,
}
