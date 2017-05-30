all: bash vim tmux python docker node golang gcloud chrome apps
	brew cask install java

bash:
	brew install bash
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/bashrc ~/.bashrc
	ln -s `pwd`/bash_profile ~/.bash_profile
	ln -s `pwd`/bin ~/bin
	brew install bash-completion
	brew tap homebrew/completions
	brew cask install iterm2

tmux:
	brew install tmux reattach-to-user-namespace
	ln -s `pwd`/tmux.conf ~/.tmux.conf

git:
	brew install git
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/gitignore_global ~/.gitignore_global

python:
	brew install python
	pip install --upgrade setuptools pip wheel
	pip install virtualenvwrapper

docker:
	brew cask install docker
	open /Applications/Docker.app

node:
	brew install yarn nodejs

golang:
	brew install golang

vim:
	brew install vim --with-override-system-vi
	ln -s `pwd`/vimrc ~/.vimrc
	mkdir -p /var/tmp/vim/undo /var/tmp/vim/backup /var/tmp/vim/swap
	mkdir -p ~/.vim/colors
	wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
	mkdir -p ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

gcloud:
	brew cask install google-cloud-sdk
	gcloud components install kubectl app-engine-python

chrome:
	brew cask install google-chrome

finder:
	defaults write com.apple.finder AppleShowAllFiles YES
	killall Finder /System/Library/CoreServices/Finder.app

apps:
	brew cask install beyond-compare sourcetree
	brew cask install slack discord skype steam
