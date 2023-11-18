" colorscheme edge

syntax enable
syntax on
filetype on
set rtp+=~/.fzf
set autowriteall
set clipboard=unnamed,unnamedplus
set noswapfile
set number
set encoding=UTF-8
set autoindent
set tabstop=2
set matchpairs+=<:>
set ignorecase
set smartcase
set nohlsearch
set list
set ruler
set scrolloff=14
set relativenumber
set virtualedit+=all
set autowriteall
set nolist
set path+=**/**
if has('persistent_undo')
  set undofile                
  set undolevels=1000         
  set undoreload=10000        
  set undodir=~/.undodir/
endif
