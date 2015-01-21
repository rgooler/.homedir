#!/bin/bash
alias vi=vim
command -v brew >/dev/null || ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
command -v hub  >/dev/null || brew install hub

alias git=hub

help() {
  echo "Puppet Change Workflow:"
  echo '  1. Create a local copy of the remote repository: clone <GitHub Repository>'
  echo '  2. Create a branch in your local copy: branch <JIRA Ticket ID>'
  echo '  3. Make changes to files in your local branch...'
  echo '  4. Create a PR for your changes: commit <Change Comment>'
  echo '  5. Paste the string that was automatically copied to your clipboard into HipChat...'
  echo '  6. Receive an ack from a peer reviewer...'
  echo '  7. Merge the pull request.'
}

clone() {
  if [[ "$1" == "" ]]; then
    help
  else
    git clone git@github.com:onelogin/$1
    cd $1
    echo "You are now ready to create a branch."
  fi
}

branch() {
  if [[ "$1" == "" ]]; then
    help
  elif [[ ! -d .git ]]; then
    help
  else
    BRANCH=`git branch | awk '/^\*/ { print $2 }'`
    if [[ ! "$BRANCH" == "master" ]]; then
      git checkout master
      git pull
      git branch -d $BRANCH
    fi
    git stash
    git pull
    git fetch -p
    git checkout -b $1
    git branch --set-upstream-to=origin/master $1
    echo "You are now ready to begin making edits."
  fi
}

commit() {
  BRANCH=`git status | awk '/^On branch/ { print $3 }'`

  if [[ "$*" == "" ]]; then
    help
  elif [[ "$BRANCH" == "" ]]; then
    echo "You must first create a branch before making any changes!"
  else
    git add .
    git commit -a -m "$*"
    git push origin $BRANCH
    echo -n "@all ack please: `git pull-request -m "$*"`" | pbcopy
    echo "Pull request URL has been copied to your clipboard."
  fi
}
