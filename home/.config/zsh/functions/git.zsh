# Helper function for confirming before dangerous operations
function confirmInput {
  QUERY=${1:-"Are you sure?"}
  local compcontext='yn:yes or no:(yes no)'
  vared -cp "$QUERY [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) 
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Update the branch specified
function updateGit {
  BASE=${1:-develop}
  git checkout "$BASE" && git fetch -p && git pull
  rc=$?; if [[ $rc != 0 ]]; then
    echo "Pull failed. Aborting"
    return $rc
  fi
}

# Clean up local branches that have been merged, avoiding permanent branches like develop* and master
function gitCleanLocalBranches {
  updateGit "$1"
  rc=$?; if [[ $rc != 0 ]]; then; return $rc; fi
  BRANCHES=$(\
    git branch --merged | \
    grep -v 'master\|release-\|develop\|HEAD' | \
    grep '\/' \
  )
  if [ -z "$BRANCHES" ]; then
    echo "No branches to delete"
    return 0
  fi
  echo "About to delete the following local branches:"
  echo $BRANCHES
  confirmInput
  if [ $? -eq 0 ]; then
    git branch -d $(echo $BRANCHES)
  fi
}

# Clean up remote branches that have been merged, avoiding permanent branches like develop* and master
function gitCleanRemoteBranches {
  updateGit "$1"
  rc=$?; if [[ $rc != 0 ]]; then; return $rc; fi

  BRANCHES=$(\
    git branch -a --merged | \
    grep origin | \
    grep -v 'master\|release-\|develop\|HEAD' | \
    sed 's/remotes\/origin\///' | \
    grep '\/' \
  )
  if [ -z "$BRANCHES" ]; then
    echo "No branches to delete"
    return 0
  fi
  echo "About to delete the following remote branches:"
  echo $BRANCHES
  confirmInput
  if [ $? -eq 0 ]; then
    git push --delete origin $(echo $BRANCHES)
  fi
}

# List authors that have contributed to the repository, along with the number of lines that are
# currently attributed to that author (because they were the last to touch it)
function gitAuthors {
  git ls-tree -r -z --name-only HEAD -- $1 | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr
}

# Open vim for each file that is conflicting, and reset and patch-add it after it has been fixed
function fixConflicts {
  FILES=$(git status | grep 'both modified' | awk '{print $3}' | tr '\n' ' ')
  eval git reset $FILES
  eval vim $FILES
  eval git add -p $FILES
}
