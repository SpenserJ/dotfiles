#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source RVM
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && . "$HOME/.rvm/scripts/rvm"

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

# Start VMs easily
alias vm-docker="VBoxHeadless --startvm Docker > /dev/null 2>&1 &"

# Pass wildcards through instead of globbing files
alias ansible='noglob ansible'

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
