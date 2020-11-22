function antibodyGeneratePlugins {
  antibody bundle < ~/.config/zsh/plugins.txt > ~/.config/zsh/plugins.zsh
}

function caniuse {
  local domain="http://caniuse.com/"
  local query

  if [ $# -eq 0 ]; then
    # If there are no arguments, open the main page
    xdg-open ${domain}
  else
    # Open a window for each search term
    for term in "$@"; do
      xdg-open "${domain}#search=${term}"
    done
  fi
}

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

  eval vim $FILES;
}

# List the subfolders sorted by their size
function duf {
  local RESULT
  if [ $# -eq 0 ]; then
    RESULT=$(du -sk *)
  else
    RESULT=$(du -sk "$@")
  fi

  echo $RESULT | sort -n | while read size fname; do
    for unit in k M G T P E Z Y; do
      if [ $size -lt 1024 ]; then
        echo -e "${size}${unit}\t${fname}"
	break
      fi
      size=$((size/1024))
    done
  done
}

# Open any files that fail linting in Vim
function vimLinting {
  # TODO: This should check if we should use npm or yarn
  vim $(npm run lint | grep "^$HOME")
}

# Open an orgmode file with today's date
function today {
  vim ~/spenser.e.jones@gmail.com/orgmode/journal/$(date +%Y-%m-%d).org
}

# Trust all networks that docker has created
function trustDockerNetworks {
  NETWORKS=("${(@f)$(docker network ls | grep bridge | grep -v 'bridge \+bridge' | awk '{print $1}')}")
  for NETWORK in ${NETWORKS[@]}; do
    echo "Trusting br-$NETWORK"
    sudo firewall-cmd --zone=trusted --add-interface="br-$NETWORK"
    sudo firewall-cmd --zone=trusted --add-interface="br-$NETWORK" --permanent
  done
}

# Print the current kubernetes context and the pods in it
function getKubePods {
  watch -n1 "kubectl config current-context && echo && kubectl get pods --sort-by=.metadata.creationTimestamp"
}
