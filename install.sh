#!/usr/bin/bash -e

# use this script to start a brand new install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install dependencies to clone the dotfiles repo
brew install bash make git wget curl
git clone git@github.com:njoyce/dotfiles.git ~/dotfiles

cd ~/dotfiles
make
