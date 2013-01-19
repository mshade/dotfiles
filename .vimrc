set nocompatible
" call pathogen#infect()
filetype plugin indent on
syntax enable
set background=dark
" colorscheme solarized
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"set autoindent
"set smartindent
set shiftround
set nohlsearch
set incsearch
set ignorecase
set ruler
set nowrap

" Store certain things when exiting a session
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
