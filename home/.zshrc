# Ensure our custom themes will be found
fpath=( ~/.zpreztothemes "${fpath[@]}" )

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Alias homesick/homeshick and set up folders
source $HOME/.homesick/repos/homeshick/homeshick.sh
alias homesick=homeshick
export DOTFILES="$HOME/.homesick/repos/dotfiles"

# Configure and alias tmuxifier
export TMUXIFIER="$DOTFILES/apps/tmuxifier"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier"
alias tmuxifier="$TMUXIFIER/bin/tmuxifier"

# Remap applications
alias nano=vim

# Pass wildcards through instead of globbing files
alias ansible='noglob ansible'

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
ssh() {
    # Do nothing if we are not inside tmux or ssh is called without arguments
    if [[ $# == 0 || -z $TMUX ]]; then
        command ssh $@
        return
    fi
    # The hostname is the last parameter (i.e. ${(P)#})
    local remote=${(P)#}
    local old_name="$(tmux display-message -p '#W')"
    local renamed=0
    # Save the current name
    if [[ $remote != -* ]]; then
        renamed=1
        tmux rename-window $remote
    fi
    command ssh $@
    if [[ $renamed == 1 ]]; then
        tmux rename-window "$old_name"
    fi
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export GET_TTY=$(tty)

function chpwd() {
  rename_window
  unlock_gpg
}

function rename_window() {
  SITE=$(pwd | awk '{match($0, "www/([^/]*)", site)}END{print site[1]}')
  FOLDER=$(pwd | awk '{match($0, "/([^/]*)/?$", folder)}END{print folder[1]}')

  # If we're not in a site right now, don't change the title
  if [ -z "$SITE" ]; then
    return
  fi

  # If we're in a subfolder, add that to the site
  if [[ "$SITE" != "$FOLDER" ]]; then
    SITE="$SITE - $FOLDER"
  fi

  tmux rename-window $SITE

}

function unlock_gpg() {
  # If we're already unlocked, don't run any GPG commands
  if [ -n "$GPG_AGENT_UNLOCKED" ] && [ $GPG_AGENT_UNLOCKED = 1 ]; then; return; fi

  # Check if we're in a git dir, so we don't always prompt the user
  GITDIR=$(git rev-parse 2>&1)
  if [ "$GITDIR" != "" ]; then; return; fi

  # See if GPG is signing successfully
  GPG_OUTPUT=$(echo "test" | gpg -s 2>&1)
  if [[ "$GPG_OUTPUT" != *"signing failed"* ]]; then
    # Flag that GPG is already unlocked
    export GPG_AGENT_UNLOCKED=1
  fi
}
