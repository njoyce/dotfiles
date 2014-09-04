# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source $HOME/bin/bash_colours.sh

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

alias ls="BLOCK_SIZE=\'1 ls -G" 

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

# on mac to install

function parse_git_branch {
    # check to ensure if we're in a git directory
    in_wd="$(git rev-parse --is-inside-work-tree 2>/dev/null)" || return
    test "$in_wd" = true || return
    # start building the state
    state=''
    git update-index --refresh -q >/dev/null # avoid false positives with diff-index
    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        git diff-index HEAD --quiet 2>/dev/null || state='*'
    else
        state='#'
    fi
    (
        d="$(git rev-parse --show-cdup)" &&
        cd "$d" &&
        test -z "$(git ls-files --others --exclude-standard .)"
    ) >/dev/null 2>&1 || state="${state}+"
    branch="$(git symbolic-ref HEAD 2>/dev/null)"
    test -z "$branch" && branch='<detached-HEAD>'
    echo ":${branch#refs/heads/}${state} "
}

export PS1="\[${COLOUR_GOLD}\]\u@\h\[${COLOUR_RESET}\]\[${COLOUR_RED}\] \w\[${COLOUR_RESET}\]\[${COLOUR_BLUE}\]""\$(parse_git_branch)""\[${COLOUR_RESET}\]$ "

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'

export EDITOR=vim
export PYOPEN_CMD=vim
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# download this.
# https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
if [ -e "$HOME/bin/git-completion.bash" ]; then
    source "$HOME/bin/git-completion.bash"
fi;

export PATH=/usr/local/share/npm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH
export PATH=$HOME/bin:$PATH

# VirtualEnv
# 
# Setting up the VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

source /usr/local/bin/virtualenvwrapper.sh
source $HOME/.bash_aliases

export GOPATH=~/go
export GOROOT=/usr/local/Cellar/go/1.2.1/libexec
export PATH=~/dev/go/bin:$GOROOT/bin:$PATH
export JAVA_HOME="$(/usr/libexec/java_home)"
