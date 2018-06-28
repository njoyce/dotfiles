#!/bin/sh -e

# use this script to start a brand new install
xcode-select --install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap homebrew/versions
brew tap homebrew/dupes
brew update
brew upgrade

# install dependencies to clone the dotfiles repo
brew install bash make git

/usr/local/bin/bash -c "\
git clone git@github.com:njoyce/dotfiles.git ~/dotfiles; \
cd ~/dotfiles; \
make; \
"
