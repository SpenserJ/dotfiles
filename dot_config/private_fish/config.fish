eval "$(/opt/homebrew/bin/brew shellenv)"

# Created by `pipx` on 2026-01-27 19:08:01
set PATH $PATH /Users/spenser.jones/.local/bin

if status is-interactive
  if not set -q TMUX
    # exec tmux
  end
end

starship init fish | source
set fish_greeting

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :


# Added by ToolHive UI - do not modify this block
fish_add_path -g $HOME/.toolhive/bin
# End ToolHive UI

fish_add_path /Applications/Cursor.app/Contents/Resources/app/bin
