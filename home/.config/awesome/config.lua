-- Customize these
local terminal = "urxvt"
local fallbackEditor = "vim"

-- Generated return values
local editor = os.getenv("EDITOR") or fallbackEditor

return {
  terminal = terminal,
  editor = editor,
  editor_cmd = terminal .. " -e " .. editor,
}
