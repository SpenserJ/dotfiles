# Ensure our custom themes will be found
fpath=( ~/.zpreztothemes "${fpath[@]}" )

# Alias homesick/homeshick and set up folders
source $HOME/.homesick/repos/homeshick/homeshick.sh
alias homesick=homeshick
# Add Homeshick completions to ZSH
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
export DOTFILES="$HOME/.homesick/repos/dotfiles"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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

NPM_PACKAGES="$HOME/.local/share/npm"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

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
  SITE=$(pwd | awk 'match($0, "www/([^/]*)") { print substr($0, RSTART + 4, RLENGTH - 4) }')
  FOLDER=$(pwd | awk 'match($0, "/([^/]*)/?$") { print substr($0, RSTART + 1, RLENGTH) }')

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

alias steam-wine='WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files/Steam/Steam.exe -no-dwrite >/dev/null 2>&1 &'

# Grep for an argument and open matching files in Vim, then search for the argument.
vimgrep () {
  if [ -z "$1" ]; then
    echo "Please provide an string to search for";
    return 1
  fi

  if [ -z "$2" ]; then
    DIR=".";
  else
    DIR="$2";
  fi

  FILES=$(git grep --name-only "$1" "$DIR" | tr "\n" " ");

  if [ -z "$FILES" ]; then
    echo "No files found";
    return $?;
  fi

  eval vim -c "/$1" $FILES;
}
