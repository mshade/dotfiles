" vimrc
" vi:syn=vim
set nocompatible
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
syntax enable
autocmd BufNewFile,BufRead *.sls set syntax=yaml
set background=dark
" colorscheme solarized
" colorscheme ir_black
let base16colorspace=256
colorscheme base16-default

set laststatus=2 title number

" Whitespace
set backspace=indent,eol,start
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"set autoindent
"set smartindent
set shiftround
set nohlsearch
set incsearch
set ignorecase
set ruler
set nowrap
set wrapscan
set hidden
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" Store certain things when exiting a session
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Mappings
"
nmap <silent> <C-f> :NERDTreeToggle<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader=" "

