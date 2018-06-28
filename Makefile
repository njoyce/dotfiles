SHELL:=/bin/bash
DOTFILES=$(HOME)/.dotfiles
PYTHON=/usr/local/bin/python2.7

BREW_FORMULAE=brew-formulae.txt

$(DOTFILES):
	mkdir $@

$(PYTHON):
	brew install python@2
	pip2 install --upgrade setuptools pip wheel pipenv
	pip2 install virtualenvwrapper

python: $(PYTHON)

# install all brew packages
$(DOTFILES)/installed-formulae.txt: python $(BREW_FORMULAE)
	@$(PYTHON) scripts/install-brew-packages.py < cat brew-formulae.txt
	touch $@

update:
	@echo -n "Updating brew formulaes .."
	@$(PYTHON) scripts/generate-formulae-list.py > $(BREW_FORMULAE)
	@echo " done"

link:
	@echo -n "Linking home files .."
	@$(PYTHON) scripts/link-files.py home/ ~/

bash:
	brew install bash-completion
	brew cask install iterm2

docker:
	brew cask install docker
	open /Applications/Docker.app

vim:
	mkdir -p /var/tmp/vim/undo /var/tmp/vim/backup /var/tmp/vim/swap
	mkdir -p ~/.vim/colors
	wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
	mkdir -p ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

gcloud:
	brew cask install google-cloud-sdk
	gcloud components update -q
	gcloud components install kubectl app-engine-python -q

chrome:
	brew cask install google-chrome

finder:
	defaults write com.apple.finder AppleShowAllFiles YES
	killall Finder /System/Library/CoreServices/Finder.app

apps:
	brew cask install sourcetree slack discord skype steam
