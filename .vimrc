" vimrc
" vi:syn=vim
set nocompatible
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on
syntax enable
set background=dark
" colorscheme solarized
set number

" Whitespace
set backspace=indent,eol,start
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
