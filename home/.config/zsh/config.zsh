# Save recent commands to the history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Up and down arrows use history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
