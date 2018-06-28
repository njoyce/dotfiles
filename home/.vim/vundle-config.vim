"
" Vundle config
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" start vundle
Plugin 'gmarik/Vundle.vim'

" My bundles
Plugin 'tpope/vim-fugitive'
Plugin 'nvie/vim-flake8'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'ElmCast/elm-vim'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on
