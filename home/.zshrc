# Set up Base16-Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Ensure our custom themes will be found
fpath=( ~/.zpreztothemes "${fpath[@]}" )

source /etc/profile 2>/dev/null

# Source our current dotfiles environment.
source ~/.dotfiles_env 2>/dev/null

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

# Remap applications
alias nano=nvim
alias vi=nvim
alias vim=nvim
VISUAL=nvim
EDITOR=nvim

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

function duf {
  du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

function gitCleanRemoteBranches {
  git push --delete origin $(git branch -a --merged | grep origin | grep -v 'master\|release-1.3\|development\|HEAD' | sed 's/remotes\/origin\///')
}

function today {
  vim ~/spenser.e.jones@gmail.com/orgmode/journal/$(date +%Y-%m-%d).org
}

source ~/.zsh/tmux.zshrc
