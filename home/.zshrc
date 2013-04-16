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

# Customize to your needs...

# Alias homesick/homeshick and set up folders
alias homesick="~/.homeshick"
export DOTFILES="$HOME/.homesick/repos/dotfiles"

# Configure and alias tmuxifier
export TMUXIFIER="$DOTFILES/apps/tmuxifier"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier"
alias tmuxifier="$TMUXIFIER/bin/tmuxifier"

# Remap applications
alias nano=vim
