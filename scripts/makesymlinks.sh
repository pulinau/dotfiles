#!/usr/bin/env bash

# Variables
DOTFILES_REMOTE=git@github.com:pulinau/dotfiles.git
DOTFILES_DIR=$HOME/.dotfiles
BACKUP_DIR=$HOME/.dotfiles_old

git clone --bare $DOTFILES_REMOTE $DOTFILES_DIR

# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$DOTFILES_DIR --work-tree=$HOME $@
}

# create a directory to backup existing dotfiles to
mkdir -p $BACKUP_DIR
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from $DOTFILES_REMOTE";
  else
    echo "Moving existing dotfiles to $BACKUP_DIR";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BACKUP_DIR{}
fi

# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no
